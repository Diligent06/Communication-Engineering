clear all; clc;
n = 0:10;
x1 = unifrnd(0,1,[1, 11]);
x2 = unifrnd(0,1,[1, 11]);
size(x1)
size(x2)
w = [0:500]*pi/500;
W1 = dtft(x1, n, w);
W2 = dtft(x2, n, w);
%% 线性
W12 = dtft(x1 + x2, n, w);
figure; 
subplot(2,1,1); plot(w/pi, W1 + W2);title('线性证明');
subplot(2,1,2); plot(w/pi, W12);
res1 = abs(W1 + W2 - W12) < 1e-5;
[h1, w1] = size(W1);
equal1 = sum(res1) == w1

%% 时移
n2 = n - 5;%向左平移
W2 = dtft(x1, n2, w);
figure;
subplot(2,1,1); plot(w/pi, W2);title('时移证明');
subplot(2,1,2); plot(w/pi, W1.*exp(5*j*w));
res2 = abs(W2 - W1.*exp(5*j*w)) < 1e-5;
[h2, w2] = size(W1);
equal2 = sum(res2) == w2

%% 频移
w_ = w - 0.2*pi;
W3 = dtft(x1.*exp(-j*0.2*pi*n), n, w_);
figure;
subplot(2, 1, 1); plot(w_/pi, W1);title('频移证明');
subplot(2, 1, 2); plot(w_/pi, W3);
res3 = abs(W3 - W1) < 1e-5;
[h3, w3] = size(W1);
equal3 = sum(res3) == w3;

%% 反折
n3 = -n;
W4 = dtft(x1, n3, w);
W5 = dtft(x1, n, -w);
figure;
subplot(2, 1, 1); plot(w/pi, W4);title('反折证明');
subplot(2, 1, 2); plot(w/pi, W5);
res4 = abs(W5 - W4) < 1e-5;
[h4, w4] = size(W4);
equal4 = sum(res4) == w4;

%% 共轭 对称
w_temp = [-500:500]*pi/500;
W6 = dtft(x1, n, w_temp);
figure;
subplot(2, 2, 1);plot(w_temp/pi,abs(W6));xlabel('pi');ylabel('Amp');title('幅值');
subplot(2, 2, 2);plot(w_temp/pi,angle(W6));xlabel('pi');ylabel('Amp');title('相角');
subplot(2, 2, 3);plot(w_temp/pi,real(W6));xlabel('pi');ylabel('Amp');title('实部');
subplot(2, 2, 4);plot(w_temp/pi,imag(W6));xlabel('pi');ylabel('Amp');title('虚部');
title('共轭与对称证明')