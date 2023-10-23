clear all; clc;
g = imread('cameraman.tif');
[h, w] = size(g);
figure; imshow(g);
%% 分段线性变换
g1 = double(g);
for i = 1:h
    for j = 1:w
        if g1(i,j) > 125
            g1(i,j) = 0.5*g1(i,j)+10;
        else
            g1(i,j) = 2*g1(i,j)-10;
        end
    end
end
g1 = uint8(g1);
figure; imshow(g1);
%% 幂变换
g2 = imadjust(g,[],[],0.1);
figure; imshow(g2);
g3 = imadjust(g,[],[],0.5);
figure; imshow(g3);
g4 = imadjust(g,[],[],1);
figure; imshow(g4);
g5 = imadjust(g,[],[],2.5);
figure; imshow(g5);
g6 = imadjust(g,[],[],5);
figure; imshow(g6);
g7 = imadjust(g,[],[],10);
figure; imshow(g7);