clear all; clc;
%% 读入图片并添加均匀噪声
img = imread('../images/Fig0507(a)(ckt-board-orig).tif');
img_noise = Uniform(img, 0, 255);
img_noise = double(img_noise);
%% 利用7*7的中值滤波器对噪声图像进行滤波
img_filter1 = medfilt2(img_noise, [7, 7]);
figure;
imshow(uint8(img_filter1));
%% 利用7*7且d=7的修正阿尔法均值滤波器进行滤波
[h, w] = size(img_noise);
n = 7;
d = 7;
img_filter2 = zeros([h, w]);
len = floor(n/2);
I_D_pad = padarray(img_noise, [len, len], 'symmetric');
[h, w] = size(I_D_pad);
for i = 1+len:h-len
    for j = 1+len:w-len
        Block = I_D_pad(i-len:i+len,j-len:j+len);
        img_filter2(i-len,j-len)=sum(sum(Block))/(n*n-d);
    end
end
figure;
imshow(uint8(img_filter2));
