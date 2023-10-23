function [g_out] = my_filter(g_in, a, b, mode)
%AVERAGE_FILTER 此处显示有关此函数的摘要
%   此处显示详细说明
% param:a 滤波器的高 b 滤波器的长
[h, w] = size(g_in);
g_in = double(g_in);
g_temp = zeros([h+(a-1), w+(b-1)]);
g_temp(1+(a-1)/2:(a-1)/2+h, 1+(b-1)/2:(b-1)/2+w) = g_in;
for i = 1:(a-1)/2
    g_temp(i, 1+(b-1)/2:(b-1)/2+w) = g_in(1,:);
    g_temp(h+a-i, 1+(b-1)/2:(b-1)/2+w) = g_in(1,:);
    g_temp(1+(a-1)/2:(a-1)/2+h, i) = g_in(:,1);
    g_temp(1+(a-1)/2:(a-1)/2+h, w+b-i) = g_in(:,1);
end
g_temp_corn = zeros([(a-1)/2, (b-1)/2]);
g_temp(1:(a-1)/2,1:(b-1)/2) = g_temp_corn + g_in(1,1);
g_temp((a-1)/2+h+1:(h+a-1),1:(b-1)/2) = g_temp_corn + g_in(h,1);
g_temp(1:(a-1)/2,(b-1)/2+w+1:(b+w-1)) = g_temp_corn + g_in(1,w);
g_temp((a-1)/2+h+1:(h+a-1),(b-1)/2+w+1:(b+w-1)) = g_temp_corn + g_in(h, w);
if strcmp(mode, 'average') == 1
    for i = 1:h
        for j = 1:w
            temp = 0;
            for k = i:i+(a-1)
                for l = j:j+(b-1)
                    temp = temp + g_temp(k,l);
                end
            end
            g_in(i,j) = 1/(a*b)*temp;
        end
    end
else 
    for i = 1:h
        for j = 1:w
            temp = g_temp(i:i+a-1,j:j+b-1);
            temp = temp(:);
            g_in(i,j) = median(temp);
        end
    end     
end
g_out = uint8(g_in);

end

