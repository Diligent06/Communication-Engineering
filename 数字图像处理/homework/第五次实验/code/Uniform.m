function [output_img] = Uniform(input_img, a, b)
%UNIFORM 
%   向一幅图像添加均匀分布噪声
input_img = double(input_img);
[h, w] = size(input_img);
noise = rand(h, w);
noise = noise * (b - a);
noise = noise + a;
output_img = input_img + noise;
output_img = max(min(output_img, 255), 0);
output_img = uint8(output_img);
end

