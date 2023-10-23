import sys
from Camera_Win import *
import os
#from tkinter import _flatten
if __name__ == '__main__':
    app = QApplication(sys.argv)
    mywin = CameraPageWindow()
    mywin.show()
    sys.exit(app.exec_())