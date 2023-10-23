clear all; clc;
%% 读取一张图片
img = imread('../images/Fig0312.tif');
figure;
imshow(img); title('原始图像');
%% 通过全局阈值估计函数计算估计阈值
T0 = 3;
T2 = Global_thresholds(img, T0)
%% 使用T2对原始图像二值化
bw = im2bw(img, T2/256);
figure;
imshow(bw); title('采用估计阈值对原始图像二值化的结果');