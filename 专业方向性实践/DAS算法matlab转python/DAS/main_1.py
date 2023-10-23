from DAS_1 import *
#import scipy.io as scio
import h5py

if __name__ == '__main__':

    mic_region = [[-0.5, 0.5], [-0.5, 0.5]]
    scan_region = np.array([[-3, 3], [-3, 3]])
    scan_region = scan_region.reshape(1, -1)
    print(scan_region.shape)

    z_source = 3
    z_source = np.array([z_source])
    c = 343
    fs = 8000
    '''
    mic_pos = np.zeros([6, 3])
    mic_pos[0][0] = 0.0232
    mic_pos[0][1] = 0.0401
    mic_pos[1][0] = -0.0232
    mic_pos[1][1] = 0.0401
    mic_pos[2][0] = -0.0463
    mic_pos[2][1] = 0.0000
    mic_pos[3][0] = -0.0232
    mic_pos[3][1] = -0.0401
    mic_pos[4][0] = 0.0232
    mic_pos[4][1] = -0.0401
    mic_pos[5][0] = 0.0463
    mic_pos[5][1] = 0.0000
    mic_pos = np.array(mic_pos)
    plt.figure()
    plt.plot(mic_pos[:, 0], mic_pos[:, 1])
    plt.show()
    '''
    mic_pos = np.zeros([56, 3])
    path = './56_spiral_array.mat'
    mic_file = h5py.File(path, 'r')
    mic_file = np.array(mic_file['array'])
    mic_pos[:, 0:2] = mic_file.T


    source_x = np.array([-0.50, 0.5]).reshape(-1, 1)
    source_y = np.array([0, 0]).reshape(-1, 1)
    source1_freq = 2000
    source2_freq = 3000
    sources_freq = np.array([2000, 3000]).reshape(-1, 1)
    t_start = 0
    t_end = 0.02
    source_duration = np.array([t_end, t_end]).reshape(-1, 1)
    source1_sp1 = 100
    source2_sp1 = 100
    sources_sp1 = np.array([source1_sp1, source2_sp1]).reshape(-1, 1)
    source_z = np.array([3, 3]).reshape(-1, 1)
    source_info = np.c_[source_x, source_y, source_z, sources_freq, sources_sp1, source_duration]

    my_das = DAS(mic_region, scan_region, z_source, fs, mic_pos, mic_num=56)

    mic_signal = my_das.simulateArraydata(source_info, mic_pos, c, fs, source_duration)

    search_freql = 800
    search_frequ = 4000

    [CSM, freqs] = my_das.developCSM(mic_signal.T, search_freql, search_frequ, t_start, t_end)

    h = my_das.steerVector(freqs)

    X, Y, B = my_das.das(CSM, h, freqs)

    my_das.das_plot(B, X, Y)