clear all; clc;
%% 构建采样频率分别为5000和1000的两个采样信号并画出dtft图像
n1 = -0.03:0.0002:0.03;
Ts1 = 0.0002;
x1_n = exp(-1000.*abs(n1));
n2 = -2:0.001:2;
Ts2 = 0.001;
x2_n = exp(-1000.*abs(n2));
w = (-500:500)*2*pi/500;
X1 = dtft(x1_n, n1, w);
X2 = dtft(x2_n, n2, w);
figure;
subplot(2,1,1);plot(w/pi,X1);xlabel('pi');ylabel('Amp');title('x1(e^{jw})');
subplot(2,1,2);plot(w/pi,X2);xlabel('pi');ylabel('Amp');title('x2(e^{jw})');
%% 分别从x1(n)、x2(n)重构xa(t)
%频域乘以理想低通滤波器后进行idtft变换即可
H_w1 = Ts1 * (abs(w) <= pi);
rn1 = -10:0.0003:10;
Reconstruct1 = idtft(H_w1.*X1,w,rn1);
H_w2 = Ts2 * (abs(w) <= pi);
Reconstruct2 = idtft(H_w2.*X2,w,rn1);
figure;
subplot(2,1,1);plot(rn1,Reconstruct1);xlabel('t');ylabel('Amp');title('Reconstruction1');
subplot(2,1,2);plot(rn1,Reconstruct2);xlabel('t');ylabel('Amp');title('Reconstruction2');



