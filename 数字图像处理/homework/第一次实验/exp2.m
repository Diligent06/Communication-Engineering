clear all;
clc;
trees = imread('./images/trees.jpg');
trees_gray = rgb2gray(trees);
figure(1);
imshow(trees_gray);
imwrite(trees_gray, './output/exp2_output/trees_gray.jpg');
size(trees)
size(trees_gray)

trees_gray = imread('./output/exp2_output/trees_gray.jpg');
trees_bw = im2bw(trees_gray, 0.5);
figure(1);
imshow(trees_bw);
imwrite(trees_bw, './output/exp3_output/trees_bw.jpg');
size(trees_bw)