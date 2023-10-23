clear all; clc;
trees = imread('../material/trees_gray.jpg');
[h, w] = size(trees);
sigma = 2;
trees_big = zeros([h*sigma, w*sigma]);
for i = 1 : h
    for j = 1 : w
        for k = 0:sigma-1
            for l = 0:sigma-1
                if i + 1 > h || j + 1 > w
                    trees_big(sigma*(i-1)+k+1, sigma*(j-1)+l+1) = trees(i,j);
                    continue;
                end
                trees_big(sigma*(i-1)+k+1,sigma*(j-1)+l+1)=(1-k/sigma)*(1-l/sigma)*trees(i,j)+(1-k/sigma)*l/sigma*trees(i,j+1)+(1-l/sigma)*k/sigma*trees(i+1,j)+l/sigma*k/sigma*trees(i+1,j+1);
            end
        end
    end
end

imshow(uint8(trees_big));
imwrite(trees_big, '../output/trees_big.jpg');