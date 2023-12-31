clear all; clc;
n = 0:1:9;
x_n = n + 1;
h_n = [1, 0, -1];
N = 12;
y_n = idft(dft(x_n, N) .* dft(h_n, N), N);
num = 0:1:11;
figure;
scatter(num, abs(y_n));
xlabel('n');ylabel('y(n)');title('用圆周卷积计算线性卷积');