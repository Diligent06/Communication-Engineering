clear all; clc;
%% 设计长度为34，通带为0.35<w<0.65的各种类型带通滤波器
%定义窗长度
N=34; 
% 通带为0.35<w<0.65的理想带通滤波器
tao=(N-1)/2;
n=0:1:N-1;
h_d=1./(pi*(n-tao)).*(sin(0.65*(n-tao))-sin(0.35*(n-tao)));
% 矩形窗
W1=boxcar(N).';
r1=h_d.*W1;
f1=abs(fft(r1,N));
% 三角形窗
W2=triang(N).';
r2=h_d.*W2;
f2=abs(fft(r2,N));
% 汉宁窗
W3=hanning(N).';
r3=h_d.*W3;
f3=abs(fft(r3,N));
% 汉明窗
W4=hamming(N).';
r4=h_d.*W4;
f4=abs(fft(r4,N));
% 布莱克曼窗
W5=blackman(N).';
r5=h_d.*W5;
f5=abs(fft(r5,N));
% 凯塞窗
W6=kaiser(N,5.6).';
r6=h_d.*W6;
f6=abs(fft(r6,N));
w=(0:1:N-1)/N;
figure;
subplot(3,1,1);
plot(w,f1);xlabel('w/2pi');ylabel('Amp');
title('矩形窗设计结果');
subplot(3,1,2);
plot(w,f2);xlabel('w/2pi');ylabel('Amp');
title('三角形窗设计结果');
subplot(3,1,3);
plot(w,f3);xlabel('w/2pi');ylabel('Amp');
title('汉宁窗设计结果');
figure;
subplot(3,1,1);
plot(w,f4);xlabel('w/2pi');ylabel('Amp');
title('汉明窗设计结果');
subplot(3,1,2);
plot(w,f5);xlabel('w/2pi');ylabel('Amp');
title('布莱克曼窗设计结果');
subplot(3,1,3);
plot(w,f6);xlabel('w/2pi');ylabel('Amp');
title('凯泽窗beta=5.6设计结果');

