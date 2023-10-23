%% (a)
n = 0:1:10;
N = length(n);
x_n = cos(0.47*pi*n) + cos(0.53*pi*n);
x_k = dft(x_n, N);
figure;
scatter(n, abs(x_k));xlabel('k');ylabel('abs(x_k)');title('(a)');
%% (b)
n = 0:1:10;
x_n = cos(0.47*pi*n) + cos(0.53*pi*n);
x_n = [x_n, zeros(1, 101 - length(n))];
N = length(x_n);
x_k = dft(x_n, N);
num = 0:1:100;
figure;
scatter(num, abs(x_k));xlabel('k');ylabel('abs(x_k)');title('(b)');
%% (c)
n = 0:1:100;
N = length(n);
x_n = cos(0.47*pi*n) + cos(0.53*pi*n);
x_k = dft(x_n, N);
figure;
scatter(n, abs(x_k));xlabel('k');ylabel('abs(x_k)');title('(c');
%% (d)
% 当要使不出现频谱泄露的情况时，应该使采样点数正好为原始信号的整数倍，经过计算采样200点即可满足要求。
n = 0:1:199;
N = length(n);
x_n = cos(0.47*pi*n) + cos(0.53*pi*n);
x_k = dft(x_n, N);
figure;
scatter(n, abs(x_k));xlabel('k');ylabel('abs(x_k)');title('(d)');
