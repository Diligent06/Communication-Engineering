clear all; clc;
%% 初始化数字高通滤波器参数
wp=0.6*pi;
Rp=1;
ws=0.45*pi;
As=15;
%% 采用双线性法预畸变为模拟高通滤波器参数，取T=2
omu_p=tan(wp/2);
omu_st=tan(ws/2);
%% 以Rp=1归一化得到低通滤波器
omu_p1=1;
omu_st1=omu_p/omu_st;
%% 得到高通AF滤波器直接型系数
[b,a]=highpass1(omu_p1,omu_st1,Rp,As,wp)