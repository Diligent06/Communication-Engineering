from Ui_test import Ui_MainWindow
from PyQt5.QtWidgets import *
from PyQt5.QtGui import *
from PyQt5.QtCore import *
import cv2
import numpy as np
import struct
from DAS import *
from Audio import *
import time
import threading


class CameraPageWindow(QMainWindow, Ui_MainWindow):
    returnSignal = pyqtSignal()

    def __init__(self, parent=None):
        super(CameraPageWindow, self).__init__(parent)
        #读取厦大校徽封面图并进行大小、色彩转换，最终形成QImage显示图片
        frame = cv2.imread('/home/pi/Desktop/my_project/XMU.png', cv2.IMREAD_COLOR)
        frame = cv2.resize(frame, (480, 480))
        frame = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
        self.showImage = QImage(frame.data, frame.shape[1], frame.shape[0], QImage.Format_RGB888)

        self.color = [(255, 0, 0), (255, 255, 0), (70, 130, 100), (0, 0, 255)]
        #定义一个回调定时器,用于回调执行音频接收与DAS分析
        self.timer_camera = QTimer()
        #初始化摄像头
        self.cap = cv2.VideoCapture()
        self.CAM_NUM = 0
        #设置PyQt的UI界面并初始化以及链接触发事件对应的回调函数
        self.setupUi(self)
        self.initUI()
        self.slot_init()
        self.pic_add = np.array((480, 480, 3))
        #初始化麦克风坐标数据
        mic_pos = np.zeros([6, 3])
        mic_pos[0][0] = -0.0232
        mic_pos[0][1] = 0.0401
        mic_pos[1][0] = 0.0232
        mic_pos[1][1] = 0.0401
        mic_pos[2][0] = 0.0463
        mic_pos[2][1] = 0.0000
        mic_pos[3][0] = 0.0232
        mic_pos[3][1] = -0.0401
        mic_pos[4][0] = -0.0232
        mic_pos[4][1] = -0.0401
        mic_pos[5][0] = -0.0463
        mic_pos[5][1] = 0.0000
        mic_pos = np.array(mic_pos)
        #定义麦克风坐标区域以及声源扫描平面参数
        mic_region = [[-0.05, 0.05], [-0.05, 0.05]]
        scan_region = np.array([[-0.20, 0.20], [-0.20, 0.20]])
        scan_region = scan_region.reshape(1, -1)
        z_source = 0.75
        z_source = np.array([z_source])
        #定义声源采集时的采样频率
        fs = 44100
        record_time = 0.01
        #初始化DAS模型
        self.das = DAS(mic_region, scan_region, z_source, fs, mic_pos, end_time=record_time, scan_resolution=0.01)
        #初始化麦克风阵列
        self.audio = Audio(fs, 8, 2, 1024, record_time)
        #初始化线程锁
        self.lock_state_record = False
        self.lock_state_show = False
        #初始化麦克风接收数据空间,temp用于多线程的缓存
        self.mic_data = np.zeros((1024, 6))
        self.mic_data_temp = np.zeros((1024, 6))
        #初始化图像接收数据空间
        self.photo = np.zeros((480, 640, 3))
        self.photo_temp = np.zeros((480, 640, 3))
        #定义坐标滤波器
        self.filter = []
        #以下为测试使用变量
        self.cnt = 0
        self.time_1 = 0

    def initUI(self):
        #使画布初始时显示厦大校徽图样，并设置按键文本
        self.cameraLabel.setPixmap(QPixmap.fromImage(self.showImage))
        self.returnButton.setText('quit')
        self.cameraButton.setText('open')

    def slot_init(self):
        self.timer_camera.timeout.connect(self.show_camera)
        self.returnButton.clicked.connect(self.close)
        self.cameraButton.clicked.connect(self.slotCameraButton)

    def show_camera(self):
        self.time_1 = time.time()
        #判断是否已经完成对mic_data与mic_data_temp完成使用
        #多线程编程中需要注意多个线程对同一地址空间进行访问导致不可知的错误
        while self.lock_state_record or self.lock_state_show:
            return
        #创建两个线程，一个用于录制音频,一个用于显示图像
        thread_1 = threading.Thread(target = self.show_image)
        thread_2 = threading.Thread(target = self.record_mic)
        thread_1.start()
        thread_2.start()
        #等待线程的终止
        thread_2.join()
        thread_1.join()
        self.mic_data = self.mic_data_temp
        self.photo = self.photo_temp
        #print('all need time %f' % (time.time() - self.time_1))
    def record_mic(self):
        time_r = time.time()
        self.lock_state = True
        self.mic_data_temp = self.audio.record_data()
        flag, self.photo_temp = self.cap.read()
        self.lock_state = False
        #print('record need time %f' % (time.time() - time_r))
    def show_image(self):
        time_s = time.time()
        self.lock_state_show = True
        self.das.developCSM(self.mic_data)
        SPL = self.das.das_SPL()
        maxSPL = np.max(SPL)
        if maxSPL < 140:
            self.image = self.photo[:, 80:560, :]
            self.image = cv2.cvtColor(np.uint8(self.image), cv2.COLOR_BGR2RGB)
            showImage = QImage(np.uint8(self.image.data), self.image.shape[1], self.image.shape[0], QImage.Format_RGB888)
            self.cameraLabel.setPixmap(QPixmap.fromImage(showImage))
            self.lock_state_show = False
            return
        index = list(np.unravel_index(SPL.argmax(), SPL.shape))
        index[0] = index[0] * 480 / 41
        index[1] = index[1] * 480 / 41
        index = list(map(int, index[:]))
        self.filter.append(index)
        if len(self.filter) > 5:
            del self.filter[0]
        temp = np.array(self.filter)
        temp = temp.mean(axis=0)
        index = list(map(int, temp[:]))
        index = list(reversed(index))
        index = tuple(index)
        # pic_add = np.array(np.zeros((41, 41, 3)))
        # pic_add[np.where(SPL > maxSPL - 0.005)] = self.color[1]
        # pic_add[np.where(SPL > maxSPL - 0.01) and np.where(SPL <= maxSPL - 0.01)] = self.color[0]
        # pic_add[np.where(SPL > maxSPL - 0.02) and np.where(SPL <= maxSPL - 0.015)] = self.color[2]
        # pic_add[np.where(SPL > maxSPL - 0.03) and np.where(SPL <= maxSPL - 0.025)] = self.color[3]
        # pic_add[np.where(SPL <= maxSPL - 0.03)] = self.color[4]
        # pic_add = cv2.resize(pic_add, (480, 480), interpolation=cv2.INTER_AREA)
        self.image = self.photo[:, 80:560, :]
        self.image = cv2.cvtColor(np.uint8(self.image), cv2.COLOR_BGR2RGB)
        # self.image = np.minimum(self.image + pic_add, 255)
        for i in range(4):
            self.image = cv2.circle(self.image, index, 5 + i * 10, self.color[i], 5 * (i+1))
        showImage = QImage(np.uint8(self.image.data), self.image.shape[1], self.image.shape[0], QImage.Format_RGB888)
        self.cameraLabel.setPixmap(QPixmap.fromImage(showImage))
        self.lock_state_show = False
        #print('show need %f' % (time.time() - time_s))
    def slotCameraButton(self):
        if self.timer_camera.isActive() == False:
            self.openCamera()
        else:
            self.closeCamera()
            self.cameraLabel.setPixmap(QPixmap.fromImage(self.showImage))

    def openCamera(self):
        flag = self.cap.open(self.CAM_NUM)
        if flag == False:
            msg = QMessageBox.Warning(self, u'Warning', u'detect camera',
                                      buttons=QMessageBox.Ok, defaultButton=QMessageBox.Ok)
        else:
            self.timer_camera.start(1)
            self.show_camera()
            self.cameraButton.setText('close')

    def closeCamera(self):
        self.timer_camera.stop()
        self.cap.release()
        self.cameraLabel.clear()
        self.cameraButton.setText('open')