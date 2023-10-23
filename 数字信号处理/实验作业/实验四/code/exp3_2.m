clear all; clc;
x1_n = [1, 2, 2];
x2_n = [1, 2, 5, 4];
%% 5点圆周卷积
N = 5;
n = 0:1:4;
x1_n1 = [x1_n, zeros(1, N - length(x1_n))];
x2_n1 = [x2_n, zeros(1, N - length(x2_n))];
y_n = idft(dft(x1_n1, N) .* dft(x2_n1, N), N);
figure;
scatter(n, abs(y_n));xlabel('n');ylabel('y(n)');title('5点卷积结果');
%% 6点圆周卷积
N = 6;
n = 0:1:5;
x1_n2 = [x1_n, zeros(1, N - length(x1_n))];
x2_n2 = [x2_n, zeros(1, N - length(x2_n))];
y_n = idft(dft(x1_n2, N) .* dft(x2_n2, N), N);
figure;
scatter(n, abs(y_n));xlabel('n');ylabel('y(n)');title('6点圆周卷积');