
function [ g_out ] = linear_transform( g_in, a, b )
%LINEAR_TRANSFORM 此处显示有关此函数的摘要
%   此处显示详细说明
[h, w] = size(g_in);
g_out = zeros([h, w]);
g_in = double(g_in);
g_out = a*g_in+b;
g_out = uint8(g_out);
end

