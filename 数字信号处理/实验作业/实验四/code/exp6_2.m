clear all; clc;
fs = 150; %设置采样频率
t0 = 1; %设置采样总时长
N = fs * t0; %计算总采样点数
n = 0:N-1;
x_n = 2*sin(2*pi*50*n/fs)+1.2*randn(1, N);
x_k = fft(x_n, N);
figure;
scatter(n, abs(x_k));xlabel('k');ylabel('abs(x_k)');title('加入噪声的信号频谱分析');
