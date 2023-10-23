clear all; clc;
%% 定义模拟滤波器各种参数
omu_p=0.2*pi;
Rp=1;
omu_s=0.3*pi;
As=15;
%% 求出直接型系数
[b,a]=afd_butt(omu_p,omu_s,Rp,As);
%% 转换成级联型系数
while b(1)==0
    b=b(2:length(b));
end
[b0,B,A]=dir2cas(b,a)
%% 绘制幅频、相频曲线
[db,pha,w]=freqs_m(b,a,pi);
w=w/pi;
figure;
plot(w,db);xlabel('w/pi');ylabel('Amp/dB');
title('幅频特性');
figure;
plot(w,pha);xlabel('w/pi');ylabel('Angle');
title('相频特性');
