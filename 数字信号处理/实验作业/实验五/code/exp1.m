%% 生成两个65536个随机序列
clear all; clc;
real1 = randn([1, 65536]);
image1 = randn([1, 65536]);
complex_data1 = real1 + 1i*image1;
real2 = randn([1, 65536]);
image2 = randn([1, 65536]);
complex_data2 = real2 + 1i*image2;

%% 线性卷积计算65536长复序列所需时间
tic;
result_conv = conv(complex_data1, complex_data2);
toc;
%% 利用FFT计算线性卷积所需时间
tic;
data1_f = fft(complex_data1, 65536);
data2_f = fft(complex_data2, 65536);
result_f = data1_f .* data2_f;
result_fft = ifft(result_f, 65536);
toc;
%% 测量N为多少时快速卷积与FFT运行时间相当
N = 2;
conv_time = [];
fft_time = [];
for i = 1:12
    data1_t = randn([1, N]) + 1i*randn([1, N]);
    data2_t = randn([1, N]) + 1i*randn([1, N]);
    tstart = tic;
    conv(data1_t, data2_t);
    tend = toc(tstart);
    conv_time = [conv_time, tend];
    tstart = tic;
    ifft(fft(data1_t, N) .* fft(data2_t, N), N);
    tend = toc(tstart);
    fft_time = [fft_time, tend];
    N = N * 2;
end
figure;
x = 1:1:12;
stem(x, conv_time, 'b');
hold on;
stem(x, fft_time, 'r');
xlabel('2的N次方');ylabel('N点卷积时间');title('FFT与线性卷积时间图');

