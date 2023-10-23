clc;
clear all;
close all;
%申明全局变量 R：区域生长的结果图像；BW：二值化图像；counter：感兴趣连通区域的像素个数
%row：图像的行数；col：图像的列数
global R BW counter row col
  
I = imread('./images/Fig0312.tif');
I = I(:,:,1);
[row,col] = size(I);
figure,imshow(I);
  
level = graythresh(I);
BW = im2bw(I,level);
figure,imshow(BW);
  
[y0,x0] = getpts;  %鼠标选取初始种子点
x0 = uint32(x0);
y0 = uint32(y0);
counter = 0;
R = zeros(row,col);
R = uint8(R);
fsrRegiongrow1(x0,y0,8);
figure,imshow(R);