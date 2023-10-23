clear all; clc;
g = imread('cameraman.tif');
figure; imshow(g);
%% 加入均值为0，方差为1的高斯白噪声
g_noise = imnoise(g, 'gaussian', 0, 1);
figure; imshow(uint8(g_noise));

%% 3×3均值滤波器
g_3_3 = my_filter(g_noise, 3, 3, 'average');
figure; imshow(g_3_3);

%% 5×5均值滤波器
g_5_5 = my_filter(g_noise, 5, 5, 'average');
figure; imshow(g_5_5);

%% 9×9均值滤波器
g_9_9 = my_filter(g_noise, 9, 9, 'average');
figure; imshow(g_9_9);

%% 椒盐噪声图像
g_pepper = imnoise(g, 'salt & pepper');
figure; imshow(g_pepper);

%% 3×3均值滤波椒盐噪声图像
g_pepper_average = my_filter(g_pepper, 3, 3, 'average');
figure; imshow(g_pepper_average);

%% 3×3中值滤波椒盐噪声图像
g_pepper_median = my_filter(g_pepper, 3, 3, 'median');
figure; imshow(g_pepper_median);
