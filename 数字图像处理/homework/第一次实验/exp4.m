clear all;
clc;
trees_gray = imread('./output/exp2_output/trees_gray.jpg');
img_size = size(trees_gray)
trees_resize = imresize(trees_gray, [img_size(1) / 2, img_size(2) / 2]);
size(trees_resize)
figure(1);
imshow(trees_resize);
imwrite(trees_resize, './output/exp4_output/trees_small.jpg');