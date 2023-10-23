clear all; clc;
%% 读入一张灰度图并显示原始图像
img = imread('../image/Fig0503 (original_pattern).tif');
figure;
imshow(img);
%% 对图像进行加正弦噪声
img = double(img);
M = 256;
u = [M/2-1];
v = [0];
A = [4000000];
noise = sin_noise(M, A, u, v);
figure;
imshow(uint8(img + noise));
%% 绘制噪声三维图
x = 1:256;
y = 1:256;
figure;
plot3(x, y, noise);
title('噪声信号波形');