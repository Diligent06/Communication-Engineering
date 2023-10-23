clear all; clc;
img = imread('./images/Fig0422.tif');
figure;
%imshow(img);
%title('original');
%% padding
[M, N] = size(img);
P = 2 * M;
Q = 2 * N;
img = double(img);
img_fp = zeros(P, Q);
img_fp(1:M, 1:N) = img(1:M, 1:N);
%% (-1)^(x+y)
for x = 1:P
    for y = 1:Q
        img_fp(x, y) = img_fp(x, y) .* (-1)^(x+y);
    end
end
%% 2dfft
img_Fp = fft2(img_fp);
%% filter
H = ones(P, Q);
D0 = 80;
for i = 1:P
    for j = 1:Q
        H(i,j) = H(i,j) - exp(-((i-P/2)^2+(j-Q/2)^2)/(2*D0^2));
    end
end
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