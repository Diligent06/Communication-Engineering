%
close all;
clc;
clear all;

%
img = imread('./Fig0507.tif');
[M, N] = size(img);
figure;
subplot(2,3,1);
imshow(img);
title('原图像');

% 产生周期噪声
C = [120, 0];
[noise, R, S] = imnoise3(M, N, C, 40000000);
subplot(2,3,2);
imshow(noise, []);
title('噪声');

% 计算傅里叶变换
img1 = double(img);
size(noise)
img2 = img1 + noise;
img3 = fft2(img2);
subplot(2,3,3);
imshow(img3);
title('傅里叶变换');

% 生成滤波器
sig = 100;
H = lpfilter('gaussian', M, N,sig);
subplot(2,3,4);
imshow(H);
title('滤波器');

% 频率域滤波
img_G = H .* img3;
subplot(2,3,5);
imshow(img_G);
title('频域陷波滤波');

% 傅里叶逆变换还原图像到时域
img_g = real(ifft2(img_G));
img_g = mat2gray(img_g);
subplot(2,3,6);
imshow(img_g);
title('陷波滤波结果');