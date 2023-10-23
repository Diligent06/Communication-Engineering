clear all;
clc;
%% 读入原始图片并加入大气湍流模型
image = imread('../image/Fig0503 (original_pattern).tif');
[m, n] = size(image);
k = 0.0025;
[img1, g, H] = atmoTurbulence(image, k);
% 大气湍流模型
figure;
subplot(1,2,1)
imshow(image)
title('大气湍流模型下的图像');
%% 添加入方差为0.08的高斯噪声后的图像
% 运动模糊图像，并且加上高斯噪声
% 添加高斯噪声
noise_var = 0.08;
img2 = imnoise(img1, 'gaussian', 0, noise_var);
subplot(1,2,2)
imshow(img2);
title('add gaussian noise');
%% 对比加噪与不加噪经过全逆滤波后的结果。
% 为了接近真实情况，对归一化之后的加噪图像进行逆滤波
F1 = fftshift(fft2(img1));
F2 = fftshift(fft2(img2));
% 全逆滤波
G1 = F1 ./ H;
G2 = F2 ./ H;
g1 = real(ifft2(ifftshift(G1)));
g2 = real(ifft2(ifftshift(G2)));
figure;
subplot(1, 2, 1);
imshow(g1);
title('无噪图像经过全逆滤波后的输出');
subplot(1, 2, 2);
imshow(g2);
title('加噪图像经过全逆滤波后的输出');
%% 有噪情况下使用半径受限的逆滤波复原有噪退化图像
r = 33;
[U, V] = dftuv(m, n);
D = sqrt(U.^2+V.^2);
max_D = max(D);
D = D >= max_D-r;
H3 = H .* D;
G3 = F2 ./ H3;
g3 = real(ifft2(fftshift(G3)));
figure;
imshow(g3);
title('半径33的逆滤波复原输出');
