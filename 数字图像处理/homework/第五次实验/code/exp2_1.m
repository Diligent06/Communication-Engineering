clear all; clc;
%% 读入图像并添加均值为0，方差为0.15的高斯噪声，并画直方图
img = imread('../images/Fig0507(a)(ckt-board-orig).tif');
img_noise = Gaussion_noise(img, 0, 0.15);
img_noise = double(img_noise);
figure;
imhist(uint8(img_noise));
%% 3*3算术均值滤波器
filter1 = fspecial('average', [3, 3]);
img_filter1 = imfilter(img_noise, filter1);
figure;
imshow(uint8(img_filter1));
%% 3*3几何均值滤波器
img_filter2 = exp(imfilter(log(img_noise), fspecial('average', [3, 3])));
figure;
imshow(uint8(img_filter2));
%% 3*3谐波均值滤波器
img_filter3 = 3*3./imfilter(1./(img_noise+eps), ones(3, 3), 'replicate');
figure;
imshow(uint8(img_filter3));
%% 绘制各种滤波后的直方图
figure;
subplot(3, 1, 1);
imhist(uint8(img_filter1));
subplot(3, 1, 2);
imhist(uint8(img_filter2));
subplot(3, 1, 3);
imhist(uint8(img_filter3));