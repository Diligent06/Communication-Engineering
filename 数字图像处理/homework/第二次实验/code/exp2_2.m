clear all; clc;
sigma = 6;
I = imread('cameraman.tif');
figure(1);
imshow(I);
num = size(I);
temp = zeros(sigma * num);
num2 = size(temp);
for i = 1:num(1)
    for j = 1:num(2)
        for u = 0:sigma-1
            for v = 0:sigma-1
                if i+1 > num(1) || j+1 > num(2)
                    temp((i-1)*sigma+1+u,(j-1)*sigma+1+v) = I(i,j);
                    continue;
                end
                temp((i-1)*sigma+u+1,(j-1)*sigma+1+v)=(1-u/sigma)*(1-v/sigma)*I(i,j)+u/sigma*(1-v/sigma)*I(i+1,j)+(1-u/sigma)*v/sigma*I(i,j+1)+u/sigma*v/sigma*I(i+1,j+1);
            end
        end
    end
end
figure(2);
img = mat2gray(temp);
imshow(img);
imwrite(img, 'exp2_4.jpg');
