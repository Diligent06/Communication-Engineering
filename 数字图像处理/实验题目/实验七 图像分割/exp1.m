%
close all;
clc;
clear all;

%
img = imread('./images/Fig1026.tif');
[M, N] = size(img);
figure;
subplot(2,3,1);
imshow(img);
title('Ô­Í¼Ïñ');

h = fspecial('gaussian',3,100);
smooth = imfilter(img,h);
subplot(2,3,2);
imshow(smooth)

h = fspecial('sobel');
edge = imfilter(smooth,h);
subplot(2,3,3);
imshow(edge)

bw = im2bw(edge,0.3);
subplot(2,3,4);
imshow(bw)


