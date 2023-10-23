clear all; clc;
%% 定义滤波器参数
f_p=[100 200];
f_s=[60 240];
fs1=500;fs2=1000;
Rp=1; As=30;
%% 计算数字带通滤波器参数
w_p1=f_p/fs1;
w_s1=f_s/fs1;
w_p2=f_p/fs2;
w_s2=f_s/fs2;
%% 计算butterworth滤波器阶数和截止频率
[n1,wn1]=cheb1ord(w_p1,w_s1,Rp,As);
[n2,wn2]=cheb1ord(w_p2,w_s2,Rp,As);
%% 计算butterworth带通滤波器直接型系数
[b1,a1]=cheby1(n1,Rp,w_p1);
[b2,a2]=cheby1(n2,Rp,w_p2);
%% 绘制滤波器幅频响应
figure;
freqz(b1,a1);
title('采样频率500Hz');
figure;
freqz(b2,a2);
title('采样频率1000Hz');