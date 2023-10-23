clear all; clc;
trees = imread('../material/trees.jpg');

[h, w, ~] = size(trees);
trees_gray = zeros([h, w]);
for i = 1 : h
    for j = 1 : w
        trees_gray(i, j) = trees(i,j,1)*0.299+trees(i,j,2)*0.578+trees(i,j,3)*0.114;
    end
end
trees_gray = uint8(trees_gray);
imshow(trees_gray);
imwrite(trees_gray, '../output/trees_gray.jpg');
