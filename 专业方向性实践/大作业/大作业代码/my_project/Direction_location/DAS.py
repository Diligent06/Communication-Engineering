import numpy as np
import matplotlib.pyplot as plt
class DAS():
    def __init__(self, mic_region, scan_region, z_source, fs, mic_pos, mic_num=6, start_time=0, end_time=0.02, search_frel=800, search_freu=4000):
        #初始化DAS算法扫描的平面以及麦克风阵列区域，以麦克风中心作为坐标原点建系
        self.mic_region = mic_region
        self.scan_region = scan_region
        self.z_source = z_source
        #定义麦克风采集数据的采样频率与声速参数
        self.fs = fs
        self.c = 343
        #初始化麦克风数量、扫描平面分辨率、麦克风阵列位置
        self.mic_num = mic_num
        self.mic_pos = mic_pos
        #计算声源扫描平面的扫描点数
        self.n_scanpoints = len(scan_region[0])
        #形成声源扫描平面的x、y坐标
        self.x = scan_region[0,:]
        self.y = scan_region[1,:]
        self.x_t = np.zeros([self.n_scanpoints, 3])
        self.x_t[:,0] = self.x
        self.x_t[:,1] = self.y
        self.x_t[:,2] = self.z_source
        #计算6个麦克风沿三个坐标轴方向上的平均值
        self.mic_pos_mean = np.mean(self.mic_pos, 0)
        #计算麦克风阵列中心距离声源扫描平面每个方格的欧氏距离
        self.r_t0 = np.sqrt(np.square(self.x_t[:, 0] - self.mic_pos_mean[0]) +
                       np.square(self.x_t[:, 1] - self.mic_pos_mean[1]) +
                       np.square(self.x_t[:, 2] - self.mic_pos_mean[2]))
        #计算每个麦克风距离声源扫描平面的距离
        self.r_t = np.zeros([self.mic_num, 1, self.n_scanpoints])
        for i in range(0, self.mic_num):
            self.r_t[i] = np.sqrt(np.square(self.x_t[:, 0] - self.mic_pos[i, 0]) +
                           np.square(self.x_t[:, 1] - self.mic_pos[i, 1]) +
                           np.square(self.x_t[:, 2] - self.mic_pos[i, 2]))
        #计算起始采样点下标与终止采样点下标+1的下标
        self.start_sample = np.int(np.floor(start_time * self.fs))
        self.block_samples = np.int(np.ceil(end_time * self.fs))
        #self.fs/self.block_samples即频率分辨率
        x_fr = self.fs / self.block_samples * np.arange(0, np.floor(self.block_samples / 2), 1)
        #np.intersect1d作用为找到两个数组的交集,返回两个输入数组中已排序的唯一值
        #np.where作用为找到符合判断条件的数组中值的下标
        self.freq_sels = np.intersect1d(np.where(search_frel <= x_fr)[0], np.where(x_fr <= search_freu)[0])
        #计算搜索频率范围的长度以及每个频率下标对应的真实频率值
        self.N_freqs = len(self.freq_sels)
        self.freqs = x_fr[self.freq_sels]
        #计算转向矢量
        self.h = self.steerVector()
        #初始化CSM互谱矩阵
        self.CSM = np.zeros((self.block_samples, self.mic_num, self.mic_num))
        
    def developCSM(self, p):
        #计算麦克风阵列输入信号的功率谱
        p_fft1 = (2 * np.fft.fft(p[self.start_sample:self.start_sample+self.block_samples, :], axis=0) / self.block_samples).reshape((self.block_samples, self.mic_num, 1))
        p_fft2 = p_fft1.reshape((self.block_samples, 1, self.mic_num))
        #计算互谱矩阵
        self.CSM = 0.5 * np.matmul(np.conj(p_fft1), p_fft2)
        #对角线擦除技术
        for i in range(self.block_samples):
            self.CSM[i] -= np.diag(np.diag(self.CSM[i]))
        # return CSM #np.matmul(CSM, self.mask)

    def steerVector(self):
        #h为转向矢量
        h = np.zeros([self.mic_num, self.x_t.shape[0], self.N_freqs], dtype='complex')
        #k为扫描频率下标
        k = np.arange(0, self.N_freqs)
        temp = 2 * np.pi * self.freqs[k] / self.c
        temp = temp.reshape((1, self.N_freqs))
        for i in range(0, self.mic_num):
            h[i, :, :] = np.multiply((self.r_t[i] / self.r_t0).T, np.exp(-1j * np.matmul((self.r_t[i] - self.r_t0).T, temp)))
        print(h.shape)
        return h / self.mic_num
    def das(self):
        b = np.zeros([1, len(self.x) * len(self.y)], dtype='complex')
        for k in range(0, self.N_freqs):
            b = b + np.sum(np.multiply(self.h[:, :, k], np.matmul(self.CSM[k, :, :], np.conj(self.h[:, :, k]))), axis=0)
        b = b.reshape(len(self.x), len(self.y))
        return self.x, self.y, b
    def das_SPL(self):
        b = np.zeros((1, len(self.x)), dtype='complex')
        for k in range(0, self.N_freqs):
            b = b + np.sum(np.multiply(self.h[:, :, k], np.matmul(self.CSM[k, :, :], np.conj(self.h[:, :, k]))), axis=0)
        b[np.where(b < 0)] = 0
        SPL = 20 * np.log10(2e-52 + np.sqrt(np.real(b)) / 2e-5)
        return SPL
    def das_plot(self, B, X, Y):
        B[np.where(B < 0)] = 0
        SPL = 20 * np.log10(2e-52 + np.sqrt(np.real(B)) / 2e-5) #2e-52
        plt.figure()

        BF_dr = 6
        maxSPL = np.ceil(np.max(SPL[:, :]))

        plt.contourf(X, Y, SPL, levels=np.arange(maxSPL - BF_dr, maxSPL + 1, 1))
        plt.colorbar()

        plt.show()
    def simulateArraydata(self, source_info, mic_info, c, fs, duration):
        n_source = source_info.shape[0]
        n_mic = mic_info.shape[0]
        x_ac = np.mean(mic_info, 0)
        t = np.arange(0, duration[0], 1/fs)
        n_samples = len(t)
        mic_signal = np.zeros([n_mic, n_samples])
        for i in range(n_source):
            dist_source_point = np.linalg.norm(x_ac - source_info[i, 0:3])
            amp = dist_source_point * 2e-5 * np.power(10, source_info[i][4] / 20)
            for j in range(n_mic):
                r = np.sqrt(np.dot(mic_info[j, :] - source_info[i, 0:3], mic_info[j, :] - source_info[i, 0:3]))
                delay_time = r / c
                mic_signal[j, :] = mic_signal[j, :] + np.sqrt(2) * amp * np.cos(2*np.pi*source_info[i, 3] * (t - delay_time)) / r
        return mic_signal

