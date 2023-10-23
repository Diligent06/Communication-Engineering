function [Y] = DTFT(x,w)
%DTFT 此处显示有关此函数的摘要
%   此处显示详细说明
N = length(x);
Y = 0;
for n=0:N-1
    Y = Y + x(n+1).*(exp(-j*w*n));
end
end

