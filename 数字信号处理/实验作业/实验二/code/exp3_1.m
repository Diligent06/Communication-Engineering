clear all; clc;
car00 = imread('../material/Car00.jpg');
car11 = imread('../material/Car11.jpg');
car00_gray = rgb2gray(car00);
car11_gray = rgb2gray(car11);

tao = 5;
[h, w, ~] = size(car00);
detect = zeros([h, w]);
for i = 1:h
    for j = 1:w
        detect(i,j) = abs(car00_gray(i,j)-car11_gray(i,j)) > tao;
    end
end

imshow(detect);
imwrite(detect, '../output/target_detect.jpg');
        