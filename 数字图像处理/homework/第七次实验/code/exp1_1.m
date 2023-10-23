clear all; clc;
%% 读取一张图片,并显示它
img = imread('../images/Fig1026.tif');
figure;
imshow(img); title('原始图像');
%% 经过3×3平滑滤波
h = fspecial('gaussian',3,100);
img = imfilter(img,h);
%% 利用Sobel算子得到输入图像的边缘图像
h = fspecial('sobel');
edge = imfilter(img, h);
figure;
imshow(edge); title('经过sobel算子的图像');
%% 设定阈值将经过sobel算子后的图像转换为二值图像
histogram(edge);
bw = im2bw(edge, 0.3);
figure;
imshow(bw); title('二值化后的图像');