clear all; clc;
%% 定义输入模拟信号经过AD采样后的序列,采样时间0.3s
fs=1000; T=0.3;
N=fs*T;
seq_n=0:1/fs:T-1/fs;
x_n=5*sin(200*pi*seq_n)+2*cos(300*pi*seq_n);
%% 设计Rp=1dB，fp=150Hz，As=40dB，fst=100Hz的切比雪夫I型数字高通滤波器
Rp=1; As=40;
fp=150; fst=100;
wp=fp/fs*2; wst=fst/fs*2;
[n,wn]=cheb1ord(wp,wst,Rp,As);
[b,a]=cheby1(n,Rp,wp,'high');
%% 绘制该高通滤波器响应
figure;
freqz(b,a);title('要求设计的滤波器频率响应图');
%% 绘制输入输出信号图并解释结果
figure;
plot(seq_n,x_n); xlabel('t/s');ylabel('x(t)');
title('输入信号图');
y_n=filter(b,a,x_n);
figure;
plot(seq_n,y_n); xlabel('t/s');ylabel('y(t)');
title('输出信号图');