# -*- coding: utf-8 -*-

# Form implementation generated from reading ui file 'd:\Su\2022大三上课程\专业方向性实践\实践\exp2\test.ui'
#
# Created by: PyQt5 UI code generator 5.15.4
#
# WARNING: Any manual changes made to this file will be lost when pyuic5 is
# run again.  Do not edit this file unless you know what you are doing.


from PyQt5 import QtCore, QtGui, QtWidgets, QtGui
import cv2


class Ui_MainWindow(object):
    def setupUi(self, MainWindow):
        MainWindow.setObjectName("MainWindow")
        MainWindow.resize(720, 650)
        self.centralwidget = QtWidgets.QWidget(MainWindow)
        self.centralwidget.setObjectName("centralwidget")
        self.cameraLabel = QtWidgets.QLabel(self.centralwidget)
        self.cameraLabel.setGeometry(QtCore.QRect(120, 20, 480, 480))
        self.cameraLabel.setObjectName("cameraLabel")
        self.cameraButton = QtWidgets.QPushButton(self.centralwidget)
        self.cameraButton.setGeometry(QtCore.QRect(160, 510, 90, 23))
        self.cameraButton.setObjectName("cameraButton")
        self.returnButton = QtWidgets.QPushButton(self.centralwidget)
        self.returnButton.setGeometry(QtCore.QRect(460, 510, 90, 23))
        self.returnButton.setObjectName("returnButton")
        MainWindow.setCentralWidget(self.centralwidget)
        self.menubar = QtWidgets.QMenuBar(MainWindow)
        self.menubar.setGeometry(QtCore.QRect(0, 0, 800, 22))
        self.menubar.setObjectName("menubar")
        MainWindow.setMenuBar(self.menubar)
        self.statusbar = QtWidgets.QStatusBar(MainWindow)
        self.statusbar.setObjectName("statusbar")
        MainWindow.setStatusBar(self.statusbar)

        self.retranslateUi(MainWindow)
        QtCore.QMetaObject.connectSlotsByName(MainWindow)

    def retranslateUi(self, MainWindow):
        _translate = QtCore.QCoreApplication.translate
        MainWindow.setWindowTitle(_translate("MainWindow", "MainWindow"))
        self.cameraLabel.setText(_translate("MainWindow", "TextLabel"))
        self.cameraButton.setText(_translate("MainWindow", "PushButton"))
        self.returnButton.setText(_translate("MainWindow", "PushButton"))

