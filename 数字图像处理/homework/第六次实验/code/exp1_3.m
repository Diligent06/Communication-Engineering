clear all; clc;
img = imread('../image/Fig0503 (original_pattern).tif');
figure;
imshow(img);
title('原始图像');
img = double(img);
M = 256;
u = [M/2-1];
v = [0];
A = [4000000];
noise = sin_noise(M, A, u, v);
img_noised = img + noise;
img_noised = max(min(img_noised, 255), 0);
figure;
imshow(uint8(img_noised));
title('加噪后图像');
%% 频谱变换后进行二维傅里叶变换
img_convert = img_noised;
for i = 1: M
    for j = 1:M
        img_convert(i,j) = (-1)^(i+j)*img_convert(i,j);
    end
end
img_f = fft2(img_convert);
%% 采用陷波滤波器对噪声图像滤波
[H, D] = bsfilter('ideal', M, M, 100, 50);
H;
img_filter = img_f .* H;
img_reconstruct = real(ifft2(ifftshift(img_filter)));
figure;
imshow(uint8(img_reconstruct));
title('滤波后图像');