clear all; clc;
g = imread('cameraman.tif');
[h, w] = size(g);
figure; imshow(g);

%% 4邻域laplacian滤波
w_1 = fspecial('laplacian', 0);
f1 = double(g);
g1 = imfilter(f1, w_1, 'replicate');
figure; imshow(g1);

%% 8邻域laplacian滤波
w_2 = w_1;
w_2(1,1) = 1; w_2(1,3) = 2; w_2(3,1) = 1; w_2(3,3) = 1;
w_2(2,2) = -8;
f2 = double(g);
g2 = imfilter(f2, w_2, 'replicate');
figure; imshow(g2);

%% Sobel算子滤波
w_3 = fspecial('sobel');
f3 = double(g);
g3 = imfilter(f3, w_3, 'replicate');
figure; imshow(g3);
figure; imshow(f3 - g3);

%% Roberts算子滤波
g4 = zeros([h, w]);
t = 20;
for i = 1:h
    for j = 1:w
        if i <= h-1 & i >= 2 & j <= w-1 & j >= 2
            g4(i,j) = abs(g(i,j)-g(i+1,j+1))+abs(g(i+1,j)-g(i,j+1));
            if g4(i,j) < t
                g4(i,j) = 0;
            else
                g4(i,j) = 255;
            end
        end
    end
end
figure; imshow(g4);

%% Prewitt算子滤波
g5 = zeros([h, w]);
t2 = 15;
for i = 2:h-1
    for j = 2:w-1
        g5(i,j) = abs(g(i-1,j+1)+2*g(i,j+1)+g(i+1,j+1)-g(i-1,j-1)-2*g(i,j-1)-g(i+1,j-1))+abs(g(i+1,j-1)+2*g(i+1,j)+g(i+1,j+1)-g(i-1,j-1)-2*g(i-1,j)-g(i-1,j+1));
        if g5(i,j) < t2
            g5(i,j) = 0;
        else
            g5(i,j) = 255;
        end
    end
end
figure; imshow(g5);