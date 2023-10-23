clear all; clc;
%% 读入图像Fig1039并显示
img = imread('../images/Fig1039.tif');
figure;
imshow(img); title('原始图像');
%% 对比实验二算法和Otsu算法进行图像分割的结果
T2 = Global_thresholds(img, 1);
bw1 = im2bw(img, T2/256);
level = graythresh(img);
bw2 = im2bw(img, level);
figure;
subplot(2,1,1);
imshow(bw1);
title('实验二算法结果');
subplot(2,1,2);
imshow(bw2);
title('Otsu算法结果');
%% 输入Fig1036并使用Otsu算法生成图像分割结果
img2 = imread('../images/Fig1036.tif');
level2 = graythresh(img2);
bw3 = im2bw(img2, level2);
figure;
imshow(img2);
title('原始图像');
figure;
imshow(bw3);
title('对Fig1036采用Otsu算法实现分割结果');