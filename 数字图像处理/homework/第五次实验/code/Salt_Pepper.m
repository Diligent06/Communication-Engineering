function [output_img] = Salt_Pepper(input_img, salt, pepper)
%SALT_PEPPER 
%   向一幅图像添加椒盐噪声
[h, w] = size(input_img);
a1 = unifrnd(0, 1,h, w);
a2 = (a1>0) & (a1<salt);
a3 = (a1>1-pepper)&(a1<1);
output_img = input_img;
output_img(a2) = 255;
output_img(a3) = 0;
end

