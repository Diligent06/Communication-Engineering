clear all; clc;
w = [0:1000]*pi/500;
H = 1./(1-0.8.*exp(-j*w));

%% 绘制H(e^(jw))的幅频特性与相频特性
figure;
subplot(2,1,1);plot(w/pi,abs(H));xlabel('pi');ylabel('Amp');title('幅频响应');
subplot(2,1,2);plot(w/pi,angle(H));xlabel('pi');ylabel('Amp');title('相频响应');

%% 对于x(n)=cos(0.05pi*n)u(n)的稳态响应
n = 0:0.5:50;
xn = cos(0.05*pi.*n);
figure;
subplot(2,1,1);plot(n,xn);xlabel('n');ylabel('x(n)');title('x(n)序列');

X_w = dtft(xn, n, w);
R = H .* X_w;
n_ = 100:0.5:150;
y_rs = idtft(R, w, n_);
subplot(2,1,2);plot(n_,y_rs);xlabel('n');ylabel('y(rs)');title('y_rs序列');
