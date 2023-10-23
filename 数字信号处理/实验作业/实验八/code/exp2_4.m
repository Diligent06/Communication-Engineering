clear all; clc;
%% 定义滤波器参数
ws1=0.2*pi; wp1=0.35*pi; ws2=0.8*pi;wp2=0.65*pi;
As=60; Rp=1;
%% 计算滤波器阶数
delta_f1=(wp1-ws1)/(2*pi);
delta_f2=(ws2-wp2)/(2*pi);
% 凯泽窗计算滤波器阶数公式
N=ceil(7.24*pi/min([delta_f1,delta_f2]));
%% 计算理想带通滤波器时域序列
w1=(ws1+wp1)/2; w2=(ws2+wp2)/2;
h_d=zeros([1,N]);
tao=(N-1)/2;
for i=1:N
    if i-1==tao
        h_d(i)=(w2-w1)/pi;
    else
        h_d(i)=1/(pi*(i-1-tao))*(sin(w2*(i-tao-1))-sin(w1*(i-1-tao)));
    end
end
%% 设计合适的窗函数,As=60dB,采用凯泽窗，beta=5.658
beta=5.658;
w_kaiser=kaiser(N,beta).';
r=w_kaiser.*h_d;
f=fft(r,N);
%% 绘制幅频、相频响应
w=(0:1:N-1)/N;
figure;
subplot(2,1,1);
plot(w,abs(f));xlabel('w/2pi');ylabel('Amp');
title('幅频响应');
subplot(2,1,2);
plot(w,angle(f));xlabel('w/2pi');ylabel('Angle');
title('相频响应');