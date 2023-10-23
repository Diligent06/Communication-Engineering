function [X] = dtft(x, n, w)
%DTFT 此处显示有关此函数的摘要
%   此处显示详细说明


X = x * exp(-j*(n'*w));


end

