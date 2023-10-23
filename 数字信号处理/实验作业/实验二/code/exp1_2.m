clear all; clc;
trees_gray = uint8(imread('../material/trees_gray.jpg'));
threshold = 256 / 2;
[h, w] = size(trees_gray);
for i = 1 : h
    for j = 1 : w
        if trees_gray(i, j) < threshold
            trees_gray(i, j) = 0;
        end
    end
end

trees_bw = logical(trees_gray);
imshow(trees_bw);
imwrite(trees_bw, '../output/trees_bw.jpg');