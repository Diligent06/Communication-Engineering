clear all; clc;
%% 定义滤波器参数
omu_p=0.2*pi;
Rp=1;
omu_s=0.3*pi;
As=15;
%% 计算阶数和截至频率
[n,Wn]=cheb1ord(omu_p,omu_s,Rp,As);
%% 计算得到直接型滤波器系数
[b,a]=cheby1(n,Rp,omu_p)