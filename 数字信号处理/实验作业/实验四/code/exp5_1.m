clear all; clc;
%% N=45
N = 45;
n = 0:N-1;
x_n = 2*sin(4*pi*0.1*n)+5*cos(8*pi*0.1*n);
x_k = fft(x_n, N);
figure;
scatter(n, abs(x_k));
xlabel('k');ylabel('x_k');title('45点fft');
%% N=46
N = 46;
n = 0:N-1;
x_n = 2*sin(4*pi*0.1*n)+5*cos(8*pi*0.1*n);
x_k = fft(x_n, N);
figure;
scatter(n, abs(x_k));
xlabel('k');ylabel('x_k');title('46点fft');
%% N=48
N = 48;
n = 0:N-1;
x_n = 2*sin(4*pi*0.1*n)+5*cos(8*pi*0.1*n);
x_k = fft(x_n, N);
figure;
scatter(n, abs(x_k));
xlabel('k');ylabel('x_k');title('48点fft');
%% N=60
N = 60;
n = 0:N-1;
x_n = 2*sin(4*pi*0.1*n)+5*cos(8*pi*0.1*n);
x_k = fft(x_n, N);
figure;
scatter(n, abs(x_k));
xlabel('k');ylabel('x_k');title('60点fft');