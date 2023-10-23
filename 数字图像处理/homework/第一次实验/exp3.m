clear all;
clc;
A = zeros(512, 512);
for i = 246:265
    for j = 236:275
        A(i,j) = 255;
    end
end
imshow(A);
size(A)
imwrite(A, './output/exp3_output/A.bmp');
imwrite(A, './output/exp3_output/A.jpg');