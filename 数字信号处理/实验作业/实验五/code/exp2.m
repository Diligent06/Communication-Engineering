clear all; clc;
N = 463421;
M = 100;
seq1 = randn(1, N) + 1i*randn(1, N);
seq2 = randn(1, M) + 1i*randn(1, M);
%% 直接卷积法
tic;
result = conv(seq1, seq2);
toc;
%% 快速卷积法
tic;
seq1_f = fft([seq1, zeros(1, N+M-1-N)], N+M-1);
seq2_f = fft([seq2, zeros(1, N+M-1-M)], N+M-1);
result_f = seq1_f .* seq2_f;
result_t = ifft(result_f, N+M-1);
toc;
%% 重叠保留法实现
tic;
result = Overlap_reservation(seq1, seq2, 512);
toc;
%% 重叠相加法实现
tic;
result = Overlap_addition(seq1, seq2, 512);
toc;