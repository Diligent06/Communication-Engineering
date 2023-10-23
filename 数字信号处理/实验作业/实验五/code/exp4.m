clear all; clc;
test_data = randn(1, 65536) + 1i*randn(1, 65536);
%% 内置fft函数
tic;
result = fft(test_data, 65536);
toc;
%% 基2-DIT算法
tic;
result = Base_2DIF(test_data, 65536);
toc;