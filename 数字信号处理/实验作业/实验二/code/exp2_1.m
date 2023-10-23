clear all; clc;
trees = imread('../material/trees_gray.jpg');
figure(1);
imshow(trees);
[h, w] = size(trees)
trees_small = zeros([h / 2, w / 2]);
for i = 1 : h / 2
    for j = 1 : w / 2
        trees_small(i,j) = 1/4*(trees(2*i-1, 2*j-1) + trees(2*i, 2*j-1) + trees(2*i-1,2*j) + trees(2*i, 2*j));
    end
end
figure(2);
imshow(uint8(trees_small));
trees_small_2 = trees(1:2:end,1:2:end);
figure(3);
imshow(uint8(trees_small_2));
imwrite(trees_small, '../output/trees_small.jpg');