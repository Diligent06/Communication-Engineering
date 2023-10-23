clear all;
close all;
clc;

image = imread('./images/Fig0503.tif');
[m, n] = size(image);
k = 0.0025;
[img1, g, H] = atmoTurbulence(image, k);
% 大气湍流模型
subplot(1,3,1)
imshow(image)

% 运动模糊图像，并且加上高斯噪声
% 添加高斯噪声
noise_var = 0.0;
img2 = imnoise(img1, 'gaussian', 0, noise_var);
subplot(1,3,2)
imshow(img2);
title('add gaussian noise');

% 为了接近真实情况，对归一化之后的加噪图像进行逆滤波
F2 = fftshift(fft2(img2));
% 全逆滤波
G2 = F2 ./ H;
g2 = real(ifft2(ifftshift(G2)));
subplot(1,3,3)
imshow(g2)
