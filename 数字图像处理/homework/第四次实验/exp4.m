clear all; clc;
img1 = imread('./images/Fig0417.tif');
img2 = imread('./images/Fig0418.tif');
%% 图像resize
img1 = imresize(img1, [1024, 1024]);
img2 = imresize(img2, [1024, 1024]);
img1 = double(img1);
img2 = double(img2);
[P, Q] = size(img1);
%% 用(-1)^(x+y)乘以图像的结果
for x = 1:P
    for y = 1:Q
        img1(x, y) = img1(x, y) .* (-1)^(x+y);
    end
end
for x = 1:P
    for y = 1:Q
        img2(x, y) = img2(x, y) .* (-1)^(x+y);
    end
end
%% 做傅里叶变换并作共轭相乘
img_Fp1 = fft2(img1);
img_Fp2 = fft2(img2);
img_res = img_Fp1 * conj(img_Fp2);
%% 反变换取实部
img_g = ifft2(img_res);
img_g = real(img_g);
figure;
imshow(img_g, []);
[r, l] = size(img_g);
max_x = 0;
max_y = 0;
max = -100000;
for i = 1:r
    for j = 1:l
        if max < img_g(i, j)
            max = img_g(i, j);
            max_x = i;
            max_y = j;
        end
    end
end
max_x
max_y