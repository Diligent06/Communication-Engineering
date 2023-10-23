from Audio import *



if __name__ == '__main__':
    audio = Audio()#实例化对象
    
    id = audio.get_index()#获取麦克风设备id

    audio.record(16000, 8, 2, id, 1024, 5, "output1.wav")#记录音频并保存

    [wavedata, framerate, nchannels] = audio.file2np_data('output1.wav')#将音频文件转成np格式数据返回

    wave_denoise = audio.denoising(wavedata, 2)#去除两个噪声通道

    audio.plot(wave_denoise, framerate, 0)#绘制时域波形
    audio.plot(wave_denoise, framerate, 1)#绘制频域波形
