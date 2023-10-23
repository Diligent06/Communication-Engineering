clear all; clc;
t = -0.01:0.00001:0.01;
xa_t = sin(1000*pi*t);
figure; plot(t,xa_t);xlabel('t');ylabel('Amp');title('x_a(t)');

%% 不同抽样间隔的频谱
n = -500:500;
w = (-500:500)*pi/500;
ts1 = 0.0001;
x1 = sin(1000*pi.*n*ts1);
W1 = dtft(x1,n,w);
ts2 = 0.001;
x2 = sin(1000*pi.*n*ts2);
W2 = dtft(x2,n,w);
ts3 = 0.01;
x3 = sin(1000*pi.*n*ts3);
W3 = dtft(x3,n,w);
figure;
subplot(3,1,1);plot(w/pi,abs(W1));xlabel('pi');ylabel('Amp');title('W_1(w)');
subplot(3,1,2);plot(w/pi,abs(W2));xlabel('pi');ylabel('Amp');title('W_2(w)');
subplot(3,1,3);plot(w/pi,abs(W3));xlabel('pi');ylabel('Amp');title('W_3(w)');

%% 对模拟信号x_a(t)=sin(20pi*t+pi/4),0<=t<=1进行分析
T = 2;
f = 20;
N = f*T;
t = linspace(-0.5,1.5,25*N);
xa = sin(20*pi*(t.*(t>=0).*(t<=1))+pi/4);
figure;
plot(t,xa);hold on;
t2 = linspace(-0.5,1.5,N);
xn = sin(20*pi*t2.*((t2<=1).*(t2>=0))+pi/4);
plot(t2,xn,'o');
%% 内插恢复
delta_t = 0.001;
t_ = -0.5:delta_t:1.5;
y = [];
for i = 1:length(t)
    x = t(i);
    h = sinc((x - t2).*f);
    g = dot(xn, h);
    y = [y,g];
end
figure;
plot(t,y); hold on;
plot(t2, xn, 'o');

