clear all; clc;
%% 定义滤波器特性
ws=0.6*pi; Rp=1;
wp=0.8*pi; As=1;
T1=0.5925; T2=0.1099;
N=33;
%% 求H(k)
Hk=zeros([1,(N+1)/2]);
np=ceil(wp/(2*pi)*N);
n1=np-2:(N+1)/2-1;
Hk(np-1:(N+1)/2)=exp(-1i*(N-1)/N*pi.*n1);
Hk(np-1)=T2*Hk(np-1);
Hk(np)=T1*Hk(np);
Hk=[Hk,fliplr(conj(Hk(2:(N+1)/2)))];
%% 绘制频率响应与单位冲激响应
w=(0:N-1)/N;
figure;
subplot(2,1,1);
plot(w,abs(Hk));xlabel('w/2pi');ylabel('Amp');
title('幅频响应');
subplot(2,1,2);
plot(w,angle(Hk));xlabel('w/2pi');ylabel('Angle');
title('相频响应');
n=0:N-1;
figure;
stem(n,ifft(Hk,N));
xlabel('n');ylabel('h(n)');
title('单位冲激响应');