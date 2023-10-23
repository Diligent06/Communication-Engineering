clear all; clc;
g = imread('cameraman.tif');
[h, w] = size(g);
figure; imshow(g);
figure; imhist(g);
%linear_transform为自定义线性灰度变换函数
%输入参数分别为原图像，a，b
%实现g_out=g_in*a+b;
g1 = linear_transform(g, 2, 0);
figure; imshow(g1);
g2 = linear_transform(g, 0.3, 0);
figure; imshow(g2);
g3 = linear_transform(g, 1, 0);
figure; imshow(g3);
g4 = linear_transform(g, 1, -20);
figure; imshow(g4);
g5 = linear_transform(g, 1, 20);
figure; imshow(g5);

        
