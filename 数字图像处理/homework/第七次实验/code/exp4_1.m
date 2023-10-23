clear all; clc;
%% 读取原始图像
global R BW counter row col
img = imread('../images/Fig0312.tif');
img = img(:,:,1);
[row,col] = size(img);
figure;
imshow(img); title('原始图像');
%% 采用Otsu算法实现图像二值化
level = graythresh(img);
BW = im2bw(img,level);
figure,imshow(BW); title('二值化后的图像');
%% 区域生长算法实现图像中主血管的分割
[y0, x0] = getpts;
x0 = uint32(x0);
y0 = uint32(y0);
counter = 0;
R = zeros(row, col);
R = uint8(R);
fsrRegiongrow1(x0, y0, 8);
figure;
imshow(R); title('区域生长进行图像分割后的图像');