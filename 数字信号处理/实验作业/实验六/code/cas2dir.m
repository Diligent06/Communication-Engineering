function [b, a] = cas2dir(b0, B, A)
%CAS2DIR 此处显示有关此函数的摘要
%   此处显示详细说明
[len, stairs] = size(B);
a = A(1,:);
b = b0*B(1,:);
for i = 2:len
    a = conv(a, A(i,:));
    b = conv(b, B(i,:));
end
end

