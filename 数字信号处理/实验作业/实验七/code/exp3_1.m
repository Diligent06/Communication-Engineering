clear all; clc;
%% 定义模拟滤波器参数
wp=0.2*pi;
Rp=1;
ws=0.3*pi;
As=15;
T=1;
%% 冲击不变法计算直接型传递函数系数
[b,a]=afd_butt(wp,ws,Rp,As);
[bz1,az1]=imp_invr(b,a,T)
%% 双线性变换法计算直接型传递函数系数
[bz2,az2]=bilinear(b,a,1/T)
