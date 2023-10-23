function [predict_threshold] = Global_thresholds(img,T0)
%GLOBAL_THRESHOLDS 此处显示有关此函数的摘要
%   此处显示详细说明
T1 = 150;
T2 = 0;
img = double(img);
while true
    mask_g1 = img > T1;
    mask_g2 = 1 - mask_g1;
    u1 = mean(mean(mask_g1 .* img));
    u2 = mean(mean(mask_g2 .* img));
    T2 = (u1+u2)/2;
    if abs(T2 - T1) < T0
        break
    end
    T1 = T2;
end
predict_threshold = T2;
end

