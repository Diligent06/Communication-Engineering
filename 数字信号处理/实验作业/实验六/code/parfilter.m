function [y] = parfilter(C, B, A, x)
%PARFILTER 此处显示有关此函数的摘要
%   此处显示详细说明
y = zeros(1, length(x));
[len, stairs] = size(B);
for i = 1:len
    y = y + filter(B(i,:), A(i,:), x);
end
y = y + filter(C, 1, x);
end

