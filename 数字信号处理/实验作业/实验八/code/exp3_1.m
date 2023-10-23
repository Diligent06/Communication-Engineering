clear all; clc;
%% 定义滤波器参数
wp=0.2*pi; Rp=0.25;
ws=0.3*pi; As=50;
%% 选择N=20的结果
%计算H(k)
N1=20;
n_p=ceil(wp/(2*pi)*N1);
H_k=[ones([1,n_p]),zeros([1,N1-2*n_p+1]),ones([1,n_p-1])];
n=0:1:n_p-1;
H_k(1:n_p)=exp(-1i*pi*19/20.*n);
H_k(20:-1:20-n_p+2)=exp(1i*pi*19/20.*n(n_p:-1:2));
h_n=ifft(H_k,N1);
w1=(0:N1-1)/N1;
%绘制频率响应与冲激响应图
figure;
subplot(2,1,1);
plot(w1,abs(H_k));xlabel('w/2pi');ylabel('Amp');
title('幅频响应');
subplot(2,1,2);
plot(w1,angle(H_k));xlabel('w/2pi');ylabel('Angle');
title('相频响应');
figure;
n1=0:N1-1;
stem(n1,h_n);xlabel('n');ylabel('h(n)');
title('单位冲激响应');
%% 选择N=40并且过渡带插入T1=0.5
%计算H(k)
T1=0.5;
N2=40;
n_p2=ceil(wp/(2*pi)*N2);
H_k2=[ones([1,n_p2+1]),zeros([1,N2-2*n_p2-1]),ones([1,n_p2])];
n2=0:1:n_p2;
H_k2(1:n_p2+1)=exp(-1i*pi*(N2-1)/N2.*n2);
H_k2(n_p2+1)=H_k2(n_p2+1)*T1;
H_k2(N2:-1:N2-n_p2+1)=conj(H_k2(2:n_p2+1));
%绘制频率响应与冲激响应图
w2=(0:N2-1)/N2;
figure;
subplot(2,1,1);
plot(w2,abs(H_k2));xlabel('w/2pi');ylabel('Amp');
title('幅频响应');
subplot(2,1,2);
plot(w2,angle(H_k2));xlabel('w/2pi');ylabel('Angle');
title('相频响应');
figure;
h_n2=ifft(H_k2,N2);
n2=0:N2-1;
stem(n2,h_n2);xlabel('n');ylabel('h(n)');
title('单位冲激响应');
%% 选择N=60，过渡带插入两个取样点T1=0.5925，T2=0.1099
%求H(k)
N3=60; T2=0.5925; T3=0.1099;
n_p3=ceil(wp/(2*pi)*N3);
H_k3=[ones([1,n_p3+2]),zeros([1,N3-2*n_p3-3]),ones([1,n_p3+1])];
n3=0:1:n_p3+1;
H_k3(1:n_p3+2)=exp(-1i*pi*(N3-1)/N3.*n3);
H_k3(n_p3+1)=H_k3(n_p3+1)*T2;
H_k3(n_p3+2)=H_k3(n_p3+2)*T3;
H_k3(N3:-1:N3-n_p3)=conj(H_k3(2:n_p3+2));
%绘制频率特性和单位冲激响应图
w3=(0:N3-1)/N3;
figure;
subplot(2,1,1);
plot(w3,abs(H_k3));xlabel('w/2pi');ylabel('Amp');
title('幅频响应');
subplot(2,1,2);
plot(w3,angle(H_k3));xlabel('w/2pi');ylabel('Angle');
title('相频响应');
h_n3=ifft(H_k3,N3);
n3=0:N3-1;
figure;
stem(n3,h_n3);xlabel('n');ylabel('h(n)');
title('单位冲激响应');