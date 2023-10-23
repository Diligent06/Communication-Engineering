%%
close all;
clc;
clear all;

%%
% 读取图像
img = imread('house.tiff');
figure(1)
imshow(img);
title('original A');

% 得到填充参数P和Q
[M, N ,C] = size(img)
P = 2 * M;
Q = 2 * N;

img = double(img);
img1 = img(1:M, 1:N ,1);
img2 = img(1:M, 1:N ,2);
img3 = img(1:M, 1:N ,3);

% 添加必要数量的0
img_fp1 = zeros(P, Q);
img_fp2 = zeros(P, Q);
img_fp3 = zeros(P, Q);
img_fp1(1:M, 1:N) = img1(1:M, 1:N);
img_fp2(1:M, 1:N) = img2(1:M, 1:N);
img_fp3(1:M, 1:N) = img3(1:M, 1:N);


% 用(-1)^(x+y)乘以图像的结果
for x = 1:P
    for y = 1:Q
        img_fp1(x, y) = img_fp1(x, y) .* (-1)^(x+y);
        img_fp2(x, y) = img_fp2(x, y) .* (-1)^(x+y);
        img_fp3(x, y) = img_fp3(x, y) .* (-1)^(x+y);
    end
end

% 对图像做快速傅里叶变换
img_Fp1 = fft2(img_fp1);
img_Fp2 = fft2(img_fp2);
img_Fp3 = fft2(img_fp3);

%设计滤波器函数
r = 30;
H = ones(P, Q);

img_G1 = img_Fp1 .* H;
img_G2 = img_Fp2 .* H;
img_G3 = img_Fp3 .* H;

img_g1 = ifft2(img_G1);
img_g2 = ifft2(img_G2);
img_g3 = ifft2(img_G3);
img_g1 = real(img_g1);
img_g2 = real(img_g2);
img_g3 = real(img_g3);

for x = 1:P
    for y = 1:Q
        img_g1(x, y) = img_g1(x, y) .* (-1)^(x+y);
        img_g2(x, y) = img_g2(x, y) .* (-1)^(x+y);
        img_g3(x, y) = img_g3(x, y) .* (-1)^(x+y);
    end
end

img_o(:,:,1)= uint8(img_g1(1:M, 1:N));
img_o(:,:,2)= uint8(img_g2(1:M, 1:N));
img_o(:,:,3)= uint8(img_g3(1:M, 1:N));

figure(8);
imshow(img_o);
title('result H');