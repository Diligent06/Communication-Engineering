clear all; clc;
g = imread('cameraman.tif');
figure; imshow(g);
figure; imhist(g), ylim([0, 1800]);
%% 使用histeq实现直方图均衡
g1 = histeq(g);
figure; imshow(g1);
figure; imhist(g1), ylim([0, 1800]);

%% 使用自己编写的HistgramEqulization实现直方图均衡
g2 = HistgramEqulization(g);
figure; imshow(g2);
figure; imhist(g2), ylim([0, 1800]);