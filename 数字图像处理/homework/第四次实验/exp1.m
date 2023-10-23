clear all; clc;

%% 读取一张M*N的灰度图像
img = imread('./images/Fig0438.tif');
figure;
imshow(img);
title('original A');

%% 以零填充为2*M，2*N的图像
[M, N] = size(img);
P = 2 * M;
Q = 2 * N;

img = double(img);
img_fp = zeros(P, Q);
img_fp(1:M, 1:N) = img(1:M, 1:N);

figure;
imshow(img_fp, []);
title('image B');

%% 用(-1)^(x+y)乘以图像的结果
for x = 1:P
    for y = 1:Q
        img_fp(x, y) = img_fp(x, y) .* (-1)^(x+y);
    end
end
figure;
imshow(img_fp, []);
title('image C');
%% 对图像做快速傅里叶变换
img_Fp = fft2(img_fp);

%% 设计滤波器函数
r = 30;
H = ones(P, Q);
for x = 1:P
    for y = 1:Q
        d = sqrt((x-M)^2 + (y-N)^2);
        if d > r
            H(x, y) = 0;
        else
            H(x, y) = 1;
        end
    end
end
figure;
imshow(H, []);
title('image D');

%% 傅里叶反变换
img_G = img_Fp .* H;
img_g = ifft2(img_G);
img_g = real(img_g);
for x = 1:P
    for y = 1:Q
        img_g(x, y) = img_g(x, y) .* (-1)^(x+y);
    end
end

img_o = uint8(img_g(1:M, 1:N));

figure;
imshow(img_o, []);
title('result H');
