function [output_image] = Gaussion_noise(input_img, mean, sigma)
%GAUSSION_NOISE 
%   向一幅图像添加高斯噪声
[h, w] = size(input_img);
input_img = double(input_img);
noise = normrnd(mean, sigma, h, w);
output_image = noise + input_img;
output_image = max(min(output_image, 255),0);
output_image = uint8(output_image);
end