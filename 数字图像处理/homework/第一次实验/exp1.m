clear all;
clc;
cat = imread('./images/cat.png');
gray = imread('./images/gray.jpg');
taiji = imread('./images/taiji.jpg');

figure(1);
subplot(1, 3, 1);
imshow(cat);
subplot(1,3, 2);
imshow(gray);
subplot(1, 3, 3);
imshow(taiji);

cat
gray
taiji
size(taiji)

imwrite(cat, './output/cat_2.png');
imwrite(gray, './output/gray_2.jpg');
imwrite(taiji, './output/taiji_2.jpg');

