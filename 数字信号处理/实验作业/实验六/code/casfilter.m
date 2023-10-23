function [y] = casfilter(b0, B, A, x)
%CASFILTER 实现输入级联型滤波器系数对输入序列x进行滤波
%   y为滤波后输出序列，b0为级联型系数，B为分子系数矩阵，A为分母系数矩阵，x为输入序列
[len, stairs] = size(B);
y = x;
for i = 1:len
    y = filter(B(i,:),A(i,:),y);
end
y = y .* b0;
end

