clear all; clc;
%% 定义滤波器参数
w1=pi/3; w2=2*pi/3;
As=60; N=45;
%% 设计凯泽窗函数,因为As=60，所以beta=5.658
beta=5.658;
w_kaiser=kaiser(N,beta).';
%% 设计理想带阻滤波器时域序列
tao=(N-1)/2;
n=0:1:N-1;
h_d(1:tao)=1./(pi.*((n(1:tao)-tao))).*(sin(pi.*(n(1:tao)-tao))-sin(w2.*(n(1:tao)-tao))+sin(w1.*(n(1:tao)-tao)));
h_d(tao+2:N)=1./(pi.*((n(tao+2:N)-tao))).*(sin(pi.*(n(tao+2:N)-tao))-sin(w2.*(n(tao+2:N)-tao))+sin(w1.*(n(tao+2:N)-tao)));
h_d(tao+1)=1-w2/pi+w1/pi;
%% 计算滤波器时域波形并绘制频域特性
r=h_d.*w_kaiser;
w=(0:1:N-1)/N;
f=fft(r,N);
figure;
subplot(2,1,1);
plot(w,abs(f));xlabel('w/2pi');ylabel('Amp');
title('幅频响应');
subplot(2,1,2);
plot(w,angle(f));xlabel('w/2pi');ylabel('Angle');
title('相频响应');