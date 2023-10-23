clear all; clc;
%% N=64
N=64;
n = 0:N-1;
x_n = 2*sin(4*pi*0.1*n) + 5*cos(8*pi*0.1*n) + 2*randn(1,N);
x_k = fft(x_n, N);
figure;
scatter(n, abs(x_k));
xlabel('k');ylabel('x_k');title('64点fft');
%% N=65
N=65;
n = 0:N-1;
x_n = 2*sin(4*pi*0.1*n) + 5*cos(8*pi*0.1*n) + 2*randn(1,N);
x_k = fft(x_n, N);
figure;
scatter(n, abs(x_k));
xlabel('k');ylabel('x_k');title('64点fft');