clear all;
close all;
clc;

image = imread('./images/Fig0503.tif');
[m, n] = size(image);
k = 0.0025;
[img1, g, H] = atmoTurbulence(image, k);
% ��������ģ��
subplot(1,3,1)
imshow(image)

% �˶�ģ��ͼ�񣬲��Ҽ��ϸ�˹����
% ��Ӹ�˹����
noise_var = 0.0;
img2 = imnoise(img1, 'gaussian', 0, noise_var);
subplot(1,3,2)
imshow(img2);
title('add gaussian noise');

% Ϊ�˽ӽ���ʵ������Թ�һ��֮��ļ���ͼ��������˲�
F2 = fftshift(fft2(img2));
% ȫ���˲�
G2 = F2 ./ H;
g2 = real(ifft2(ifftshift(G2)));
subplot(1,3,3)
imshow(g2)
