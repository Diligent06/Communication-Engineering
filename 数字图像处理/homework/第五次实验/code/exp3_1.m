clear all; clc;
%% 读入一张图片并添加概率分别为0.25、0.25的椒盐噪声
img = imread(['../images/Fig0507(a)(ckt-board-orig).tif']);
img_noise = Salt_Pepper(img, 0.25, 0.25);
img_noise = double(img_noise);
figure;
imshow(uint8(img_noise));
%% 利用3*3阶数1.5的逆谐波均值滤波器进行滤波
Q1=1.5;
img_filter1 = imfilter(img_noise.^(Q1+1),fspecial('average', 3))./imfilter(img_noise.^Q1, fspecial('average', 3));
figure;
imshow(uint8(img_filter1));
%% 利用3*3结束-1.5的逆谐波均值滤波器进行滤波
Q2 = -1.5;
img_filter2 = imfilter(img_noise.^(Q2+1),fspecial('average', 3))./imfilter(img_noise.^Q2, fspecial('average', 3));
figure;
imshow(uint8(img_filter2));
