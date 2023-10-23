clear all; clc;
g = imread('cameraman.tif');
figure; imshow(g);
figure; imhist(g), ylim([0, 1800]);
%% ʹ��histeqʵ��ֱ��ͼ����
g1 = histeq(g);
figure; imshow(g1);
figure; imhist(g1), ylim([0, 1800]);

%% ʹ���Լ���д��HistgramEqulizationʵ��ֱ��ͼ����
g2 = HistgramEqulization(g);
figure; imshow(g2);
figure; imhist(g2), ylim([0, 1800]);