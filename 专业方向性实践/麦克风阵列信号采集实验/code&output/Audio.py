import pyaudio
import wave
import numpy as np
from matplotlib import pyplot as plt

class Audio:
    py_audio = pyaudio.PyAudio()
    def __init__(self):
        return
    def get_index(self):
        '''
        function: to get the sound card id
        '''
        info = self.py_audio.get_host_api_info_by_index(0)
        numdevices = info.get('deviceCount')
        for i in range(0, numdevices):
            if (self.py_audio.get_device_info_by_host_api_device_index(0, i).get('maxInputChannels')) > 0:
                print("Input Device id ", i, " - ", self.py_audio.get_device_info_by_host_api_device_index(0, i).get('name'))
                if self.py_audio.get_device_info_by_host_api_device_index(0, i).get('name') == "seeed-8mic-voicecard: bcm2835-i2s-ac10x-codec0 ac10x-codec0-0 (hw:3,0)":
                    return i
    def record(self, rate, channels, width, index, chunk, t, output):
        '''
        function: record a fixed duration of audio and save it
        params:
        rate: sample rate
        channels: number of sound channels
        width: sample width
        index: the sound card id
        chunk: quantify the progression
        t: the total duration of the recording
        output: output file path
        '''
        stream = self.py_audio.open(
            rate=rate,
            format=self.py_audio.get_format_from_width(width),
            channels=channels,
            input=True,
            input_device_index=index, )
        print("* recording")
        frames = []
        for i in range(0, int(rate / chunk * t)):
            data = stream.read(chunk)
            frames.append(data)
        print("* done recording")
        stream.stop_stream()
        stream.close()
        self.py_audio.terminate()
        wf = wave.open(output, 'wb')
        wf.setnchannels(channels)
        wf.setsampwidth(self.py_audio.get_sample_size(self.py_audio.get_format_from_width(width)))
        wf.setframerate(rate)
        wf.writeframes(b''.join(frames))
        wf.close()
        return
    def file2np_data(self, path):
        '''
        funtion: get data from specified file and conver to np array data form
        params:
        path:target file path
        output waveData time N 
        '''
        f = wave.open(path, 'rb')
        params = f.getparams()
        #print(params)
        nchannels, sampwidth, framerate, nframes = params[:4]
        strData = f.readframes(nframes)
        waveData = np.frombuffer(strData, dtype=np.int16)
        waveData = waveData*1.0/(max(abs(waveData)))#wave幅值归一化
        waveData = np.reshape(waveData, [nframes, nchannels])
        f.close()
        return [waveData, framerate, nchannels]
    def denoising(self, wavedata, num):
        '''
        function: remove the noise channels from the captured sound
        params
        wavedata: input wave data
        num: number of noise channels
        attention: num can not equal to the num of input channels
        '''
        wavemean = np.mean(np.abs(wavedata), axis=0)
        temp = np.argsort(wavemean)
        index = []
        for i in range(num):
            index.append(temp[i])
        max_index = np.max(index)
        min_index = np.min(index)
        input_shape = wavedata.shape
        if max_index == input_shape[1] - 1:
            if min_index != 0:
                return wavedata[:,0:min_index]
            else:
                sort_temp = np.sort(temp)
                break_point = -1
                for i in range(sort_temp.shape[0] - 1):
                    if sort_temp[i+1] - sort_temp[i] != 1:
                        break_point = i
                        break
                return wavedata[:, sort_temp[break_point] + 1 : sort_temp[break_point + 1]]
        else:
            return np.append(wavedata[:, max_index + 1:input_shape[1]], wavedata[:, 0:min_index], axis=1)
    def plot(self, wavedata, framerate, select=0):
        '''
        funtion: plot the time domain or frequency domain waveform
        params:
        wavedata: input wave data
        framerate: time domain sample rate
        select: if select=0 plot the time domain waveform 
                else plot the frequency domain waveform
        '''
        plt.figure()
        if select == 0:
            time = np.arange(0, wavedata.shape[0])*(1.0 / framerate)
            for i in range(wavedata.shape[1]):
                plt.subplot(2,3,i+1)
                plt.plot(time,wavedata[:,i])
                plt.xlabel("Time(s)")
                plt.ylabel("Amplitude")
        else:
            freq = framerate / wavedata.shape[0] * np.arange(0, np.floor(wavedata.shape[0] / 2))
            fft_wavedata = 2 * np.abs(np.fft.fft(wavedata, axis=0)) / wavedata.shape[0]
            for i in range(wavedata.shape[1]):
                plt.subplot(2,3,i+1)
                plt.plot(freq, fft_wavedata[:wavedata.shape[0]//2,i])
                plt.xlabel("Freqency(Hz)")
                plt.ylabel("Amplitudu")
        plt.show()
        return

        
