clear all; clc;
fs = 120;  %采样频率
t0 = 4.5;  %采样总时长
N = t0 * fs;  %采样总点数
n = 0:N-1;
x_n = 2*sin(2*pi*20*n/fs)+5*cos(2*pi*30*n/fs)+sin(2*pi*45*n/fs);
x_k = dft(x_n, N);
figure;
scatter(n, abs(x_k));xlabel('k');ylabel('abs(x_k)');title('x(t)频谱分析图');
