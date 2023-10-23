clear all; clc;
%% 输入系统函数
h1=[-4,1,-1,-2,5,6,5,-2,-1,1,-4];
h2=[-4,1,-1,-2,5,6,6,5,-2,-1,1,-4];
h3=[-4,1,-1,-2,5,0,-5,2,1,-1,4];
h4=[-4,1,-1,-2,5,6,-6,-5,2,1,-1,4];
%% 计算每个系统函数的幅度响应
[H1,w1]=Amp_response(h1);
[H2,w2]=Amp_response(h2);
[H3,w3]=Amp_response(h3);
[H4,w4]=Amp_response(h4);
%% 找到振幅响应为0的点
n1=find(H1==0)
n2=find(H2==0)
n3=find(H3==0)
n4=find(H4==0)
%% 绘制振幅响应;
figure;

subplot(2,2,1);
plot(w1,H1);xlabel('w/2pi');ylabel('Amp');
title('类型1滤波器振幅响应曲线');
subplot(2,2,2);
plot(w2,H2);xlabel('w/2pi');ylabel('Amp');
title('类型2滤波器振幅响应曲线');
subplot(2,2,3);
plot(w3,H3);xlabel('w/2pi');ylabel('Amp');
title('类型3滤波器振幅响应曲线');
subplot(2,2,4);
plot(w4,H4);xlabel('w/2pi');ylabel('Amp');
title('类型4滤波器振幅响应曲线');
