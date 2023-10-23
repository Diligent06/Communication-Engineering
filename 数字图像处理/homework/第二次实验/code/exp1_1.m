clear all; clc;
I=imread('cameraman.tif');
figure(1);
title('原始灰度图像');
imshow(I);
temp = I;
for i = 1:256
    for j = 1:256
        if I(i,j) <= 127
            I(i,j) = 0;
        else
            I(i,j) = 255;
        end
    end
end
figure(2);
title('自设定算法将灰度级降为2');
imshow(I);
imwrite(I, 'exp1_1.jpg');
figure(3);
title('im2bw函数将灰度级降为2');
temp = im2bw(temp);
imshow(temp);
imwrite(temp, 'exp1_2.jpg');
