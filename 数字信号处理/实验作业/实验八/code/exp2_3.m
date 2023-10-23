clear all; clc;
%% 定义设计指标
wp=0.2*pi; Rp=0.25; ws=0.3*pi; As=50;
delta_f=(ws-wp)/(2*pi);
%计算滤波器阶数
N=ceil((As-7.95)/(14.35*delta_f)+1);
%因为要求As50dB，因此选择布莱克曼窗即可满足需求
w=blackman(N).';
%理想低通滤波器为
wc=(wp+ws)/2;
tao=(N-1)/2;
h_d=zeros([1,N]);
for i=1:N
    if i-1==tao
        h_d(i)=wc/pi;
        continue;
    else
        h_d(i)=sin(wc*(i-1-tao))/(pi*(i-1-tao));
    end
end
%计算设计好的滤波器时域序列
r=h_d.*w;
w_pi=(0:1:N-1)/N;
%计算频域特性并绘制幅频、相频特性图
f=fft(r,N);
figure;
subplot(2,1,1);
plot(w_pi,abs(f));xlabel('w/2pi');ylabel('Amp');
title('幅度响应');
subplot(2,1,2);
plot(w_pi,angle(f));xlabel('w/2pi');ylabel('Angle');
title('角度响应');
