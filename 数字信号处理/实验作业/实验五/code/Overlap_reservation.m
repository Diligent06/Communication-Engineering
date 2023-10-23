function [result] = Overlap_reservation(data_t1,data_t2,N)
%OVERLAP_RESERVATION 此处显示有关此函数的摘要
%   此处显示详细说明
%前补M-1个点即可
M = length(data_t2);
Q = length(data_t1);
data_t2 = [data_t2, zeros([1, N-M])];
data_f2 = fft(data_t2, N);
num = ceil(length(data_t1) / (N-M+1));
if num * (N-M+1) ~= length(data_t1)
    data_t1 = [data_t1, zeros([1, (num+1)*(N-M+1)-length(data_t1)])];
    num = num + 1;
end
data_t1 = [zeros(1, M-1), data_t1];
result = zeros(1, num*(N-M+1)+M-1);
for i = 1:num
    cur = data_t1(1, (i-1)*(N-M+1)+1:(i-1)*(N-M+1)+N);
    cur_f = fft(cur, N) .* data_f2;
    cur_t = ifft(cur_f, N);
    cur_t(1, 1:M-1) = 0;
    result(1,(i-1)*(N-M+1)+1:(i-1)*(N-M+1)+N) = cur_t(1, 1:N);
end
result = [1, M:2*M+Q-3];
end

