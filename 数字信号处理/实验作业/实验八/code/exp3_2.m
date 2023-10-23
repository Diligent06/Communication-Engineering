clear all; clc;
%% 定义滤波器特性
w1s=0.2*pi; w2s=0.8*pi; Rp=1;
w1p=0.35*pi; w2p=0.65*pi; As=60;
N=40; T1=0.5925; T2=0.1099;
%% 计算得到H(k)
np1=(w1p/(2*pi))*N;
np2=(w2p/(2*pi))*N;
n=np1-2:np2+2;
Hk=zeros([1,N/2+1]);
Hk(np1-1:np2+3)=exp(-1i*(N-1)/N.*n);
Hk(np1-1)=Hk(np1-1)*T2; Hk(np2+3)=Hk(np2+3)*T2;
Hk(np1)=Hk(np1)*T1; Hk(np2+2)=Hk(np2+2)*T1;
Hk=[Hk,fliplr(conj(Hk(2:N/2)))];
%% 绘制频率特性图与冲激响应图
w=(0:N-1)/N;
figure;
subplot(2,1,1);
plot(w,abs(Hk));xlabel('w/2pi');ylabel('Amp');
title('幅频响应');
subplot(2,1,2);
plot(w,angle(Hk));xlabel('w/2pi');ylabel('Angle');
title('相频响应');
figure;
n1=0:N-1;
stem(n1,ifft(Hk,N));xlabel('n');ylabel('h(n)');
title('单位冲激响应');

