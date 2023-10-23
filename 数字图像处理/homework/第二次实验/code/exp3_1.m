clear all; clc;
I = imread('cameraman.tif');
num = size(I);
figure(1);
imshow(I);
temp_I = I;
for i = 1:num(1)
    if i == num(1)
        break;
    end
    for j = 1:num(2)
        I(i,j) = abs(I(i+1,j)-I(i,j));
    end
end
I1 = im2bw(I, 0.1);
figure(2);
imshow(I1);
for i = 1:num(2)
    if i == num(2)
        break;
    end
    for j = 1:num(1)
        temp_I(j,i) = abs(temp_I(j,i+1)-temp_I(j,i));
    end
end
I2 = im2bw(temp_I, 0.1);
figure(3);
imshow(I2);
I3 = I1 + I2;
figure(4);
imshow(I3);