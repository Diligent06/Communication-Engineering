function [b, a] = par2dir(C, B, A)
%PAR2DIR 此处显示有关此函数的摘要
%   此处显示详细说明
b = B(1,:);
a = A(1,:);
[len, stairs] = size(B);
for i = 2:len
    b = conv(b, A(i)) + conv(a, B(i));
    a = conv(a, A(i));
end
b = b + conv(a, C);
end

