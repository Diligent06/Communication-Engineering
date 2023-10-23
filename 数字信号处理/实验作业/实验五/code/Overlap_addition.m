function [result] = Overlap_addition(data_t1,data_t2, K)
%OVERLAP_ADDITION 此处显示有关此函数的摘要
%   此处显示详细说明
N = length(data_t1);
M = length(data_t2);
data_t2 = [data_t2, zeros(1, K - M)];
data_f2 = fft(data_t2, K);
num = K - M + 1;
num_epoch = ceil(N/num);
if num_epoch*num ~= N
    num_epoch = num_epoch+1;
    data_t1 = [data_t1, zeros(1,num_epoch*num-N)];
end
result = zeros([1, K+(num_epoch-1)*num]);
for i = 1:num_epoch
    cur_data = data_t1(1, 1+(i-1)*num:i*num);
    cur_f = fft([cur_data, zeros(1, K-num)], K);
    cur_t = ifft(cur_f.*data_f2, K);
    result(1+(i-1)*num:K+(i-1)*num) = cur_t;
end
result = result(1, 1:N+M-1);
end

