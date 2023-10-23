clear all; clc;
xn = [1, 1, 1, 1, 1, 1, 0, 0];
N = 8;
xk = dft(xn, N);
num = 0:1:N-1;
figure;
subplot(2, 1, 1);
scatter(num, abs(xk));xlabel('k');ylabel('amp(x(k))');title('dft amp');
subplot(2, 1, 2);
scatter(num, angle(xk));xlabel('k');ylabel('angle(x(k))');title('dft angle');

w = -pi:0.1:pi;
n = 0:1:7;
x_w = dtft(xn, n, w);
figure;
subplot(2, 1, 1);
plot(w/pi, abs(x_w));xlabel('w/pi');ylabel('amp(x(w))');title('dtft amp');
subplot(2, 1, 2);
plot(w/pi, angle(x_w));xlabel('w/pi');ylabel('angle(x(w))');title('dtft angle');