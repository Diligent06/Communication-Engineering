import numpy as np
import matplotlib.pyplot as plt
class DAS():
    def __init__(self, mic_region, scan_region, z_source, fs, mic_pos, scan_resolution=0.1, mic_num=6):
        self.mic_region = mic_region
        self.scan_region = scan_region
        self.z_source = z_source
        self.fs = fs
        self.c = 343
        self.mic_num = mic_num
        self.scan_resolution = scan_resolution
        self.mic_pos = mic_pos

    def developCSM(self, p, freq_l, freq_u, t_start, t_end):
        start_sample = np.int(np.floor(t_start * self.fs))
        block_samples = np.int(np.ceil(t_end * self.fs))
        x_fr = self.fs / block_samples * np.arange(0, np.floor(block_samples / 2), 1)

        freq_sels = np.intersect1d(np.where(freq_l <= x_fr)[0], np.where(x_fr <= freq_u)[0])
        N_freqs = len(freq_sels)

        CSM = np.zeros([self.mic_num, self.mic_num, N_freqs], dtype='complex')

        N_start = start_sample
        N_end = N_start + block_samples
        p_fft = 2 * np.fft.fft(p[N_start:N_end, :], axis=0) / block_samples

        for k in range(0, N_freqs):
            CSM[:, :, k] = CSM[:, :, k] + 0.5 * np.matmul(np.conj(p_fft[freq_sels[k], :]).reshape(-1, 1), p_fft[freq_sels[k], :].reshape(1, 56))
            CSM[:, :, k] = CSM[:, :, k] - np.diag(np.diag(CSM[:, :, k]))

        return CSM, x_fr[freq_sels]

    def steerVector(self, freqs):
        N_freqs = len(freqs)
        x = np.arange(self.scan_region[0][0], self.scan_region[0][1] + self.scan_resolution, self.scan_resolution)
        y = np.arange(self.scan_region[0][2], self.scan_region[0][3] + self.scan_resolution, self.scan_resolution)
        z = self.z_source
        n_x = len(x)
        n_y = len(y)
        n_z = len(z)

        n_scanpoints = n_x * n_y * n_z
        x_t = np.zeros([n_scanpoints, 3])
        x_t[:, 0] = np.tile(x, [1, n_y])
        x_t[:, 1] = y.repeat(n_x)
        x_t[:, 2] = z

        x_0 = np.mean(self.mic_pos, 0)
        r_t0 = np.sqrt(np.square(x_t[:,0] - x_0[0]) +
                       np.square(x_t[:,1] - x_0[1]) +
                       np.square(x_t[:,2] - x_0[2]))
        h = np.zeros([self.mic_num, x_t.shape[0], N_freqs], dtype='complex')
        for K in range(0, N_freqs):
            k = 2 * np.pi * freqs[K] / self.c
            sum_r_ti = np.zeros([n_scanpoints, 1])
            for i in range(0, self.mic_num):
                r_ti = np.sqrt(np.square(x_t[:, 0] - self.mic_pos[i, 0]) +
                               np.square(x_t[:, 1] - self.mic_pos[i, 1]) +
                               np.square(x_t[:, 2] - self.mic_pos[i, 2]))
                sum_r_ti = sum_r_ti + r_ti * (-2)
                h[i, :, K] = r_ti * np.exp(-1j * k * (r_ti-r_t0)) / r_t0

        return h / self.mic_num
    def das(self, csm, h, freqs):
        n_freq = len(freqs)
        x = np.arange(self.scan_region[0][0], self.scan_region[0][1] + self.scan_resolution, self.scan_resolution)
        y = np.arange(self.scan_region[0][2], self.scan_region[0][3] + self.scan_resolution, self.scan_resolution)
        n_x = len(x)
        n_y = len(y)
        b = np.zeros([1, n_x * n_y], dtype='complex')
        for k in range(0, n_freq):
            b = b + np.sum(np.multiply(h[:, :, k], np.matmul(csm[:, :, k], np.conj(h[:, :, k]))), axis=0)
        b = b.reshape(n_x, n_y)
        return x, y, b
    def das_plot(self, B, X, Y):
        B[np.where(B < 0)] = 0
        SPL = 20 * np.log10(2e-52 + np.sqrt(np.real(B)) / 2e-5) #2e-52
        plt.figure()

        BF_dr = 6
        maxSPL = np.ceil(np.max(SPL[:, :]))

        plt.contourf(X, Y, SPL, levels=np.arange(maxSPL - BF_dr, maxSPL, 1))
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

