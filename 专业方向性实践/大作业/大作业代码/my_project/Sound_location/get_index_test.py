import pyaudio

if __name__ == '__main__':
    py_audio = pyaudio.PyAudio()
    info = py_audio.get_host_api_info_by_index(0)
    numdevices = info.get('deviceCount')
    for i in range(0, numdevices):
        if (py_audio.get_device_info_by_host_api_device_index(0, i).get('maxInputChannels')) > 0:
            print("Input Device id ", i, " - ",
                  py_audio.get_device_info_by_host_api_device_index(0, i).get('name'))
            if py_audio.get_device_info_by_host_api_device_index(0, i).get('name') == "seeed-8mic-voicecard: bcm2835-i2s-ac10x-codec0 ac10x-codec0-0 (hw:3,0)":
                print(i)
