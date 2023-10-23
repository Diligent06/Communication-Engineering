function [ g_out ] = HistgramEqulization(g_in, level)
%HISTGRAMEQULIZATION 此处显示有关此函数的摘要
%   此处显示详细说明
narginchk(1,2);
if nargin == 1
    num = zeros(1, 256);
    [h, w] = size(g_in);
    for i = 1:h
        for j = 1:w
            num(g_in(i,j)+1) = num(g_in(i,j)+1)+1;
        end
    end
    for i = 2:256
        num(i) = num(i-1)+num(i);
    end
    g_out = zeros([h, w]);
    for i = 1:h
        for j = 1:w
            g_out(i,j) = 255*num(g_in(i,j)+1)/(h*w);
        end
    end
else
    num = zeros(1, level);
    [h, w] = size(g_in);
    for i = 1:h
        for j = 1:w
            num(g_in(i,h)+1) = num(g_in(i,j)+1)+1;
        end
    end
    for i = 2:level
        num(i) = num(i-1)+num(i);
    end
    g_out = zeros([h, w]);
    for i = 1:h
        for j = 1:w
            g_out(i,j) = (level-1)*num(g_in(i,j)+1)/(h*w);
        end
    end
end
g_out = uint8(g_out);
end

