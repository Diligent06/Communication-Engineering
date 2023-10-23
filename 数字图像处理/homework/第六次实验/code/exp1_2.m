clear all; clc;
img = imread('../image/Fig0503 (original_pattern).tif');
img = double(img);
M = 256;
u = [M/2-1];
v = [0];
A = [4000000];
noise = sin_noise(M, A, u, v);
img_noised = img + noise;
%% 对噪声图像进行频谱变换
for i = 1:M
    for j = 1:M
        img_noised(i, j) = (-1)^(i+j) * img_noised(i, j);
    end
end
%% 求出频谱并绘制图像
img_f = fft2(img_noised);
figure;
imshow(uint8(abs(img_f)));
title('幅度光谱');
figure;
imshow(angle(img_f));
title('相位光谱');