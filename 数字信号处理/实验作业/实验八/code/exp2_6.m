clear all; clc;
%% 设计窗长为25的Hanning窗
N=25;
w_hanning=hanning(N).';
%% 设计长度N为25的理想希尔伯特变换器
h_d=zeros([1,N]);
n=1:2:N-1;
h_d(n)=2./(n.*pi);
%% 计算设计结果并绘制幅频、相频特性曲线
r=h_d.*w_hanning;
f=fft(r,N);
w=(0:N-1)/N;
figure;
subplot(2,1,1);
plot(w,abs(f));xlabel('w/2pi');ylabel('Amp');
title('幅频响应');
subplot(2,1,2);
plot(w,angle(f));xlabel('w/2pi');ylabel('Angle');
title('相频响应');