%
close all;
clc;
clear all;

% ��ȡͼ��
img = imread('./images/Fig0507.tif');
img = im2double(img);
figure;
subplot(1,3,1);
imshow(img);
title('original image');

% ģ��ͼ��
PSF = fspecial('motion', 15, 30);
img1 = imfilter(img, PSF);
subplot(1,3,2);
imshow(img1);
title('filtered image');

% ����ά���˲���NSRֱ�Ӹ�0
% Specifying 0 for the NSR is equivalent to creating an ideal inverse filter.
% img3 = deconvwnr(img2, PSF, 0.012);
img2 = deconvwnr(img1, PSF, 0.00012);
subplot(1,3,3);
imshow(img2);
title('Restoration of Blurred, Noisy Image Using NSR = 0');
