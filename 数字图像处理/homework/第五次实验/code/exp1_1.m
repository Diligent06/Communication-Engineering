clear all; clc;
%% 添加高斯噪声 均值为0方差为0.1
img1 = imread('../images/Fig0503 (original_pattern).tif');
img1_add_noise = Gaussion_noise(img1, 2, 10);
figure;
imshow(img1_add_noise);
%% 添加椒盐噪声，函数可以指定两个噪声分量的概率
img2 = imread('../images/Fig0507(a)(ckt-board-orig).tif');
img2_add_saltpepper = Salt_Pepper(img2, 0.1, 0.1);
figure;
imshow(img2_add_saltpepper);
%% 添加均匀密度分布噪声
img3 = imread('../images/Fig0525(a)(aerial_view_no_turb).tif');
img3_add_uniform = Uniform(img3, 50, 100);
figure;
imshow(img3_add_uniform);
%% 直方图展示
figure;
subplot(3, 1, 1);
imhist(img1_add_noise);
subplot(3, 1, 2);
imhist(img2_add_saltpepper);
subplot(3, 1, 3);
imhist(img3_add_uniform);