function [xn] = idfs(xk, N)
%IDFS 此处显示有关此函数的摘要
%   此处显示详细说明
n = -N:1:N-1;
k = 0:1:N-1;
if N > length(xk)
    xk = [xk, zeros(1, N-length(xk))];
elseif N < length(xk)
    fprintf("Error! N should not be less than length of x(k)\n");
    xn = zeros(1, length(xk));
    return
end
WN = exp(-1i*2*pi/N);
nk = k'*n;
xn = xk * power(WN, -nk) / N;
end

