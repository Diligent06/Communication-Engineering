%%
close all;
clc;
clear all;

%%
% ��ȡͼ��
img = imread('./images/Fig0438.tif');
figure(1)
imshow(img);
title('original A');

% �õ�������P��Q
[M, N] = size(img);
P = 2 * M;
Q = 2 * N;

img = double(img);
% ��ӱ�Ҫ������0
img_fp = zeros(P, Q);
img_fp(1:M, 1:N) = img(1:M, 1:N);

figure(2);
imshow(img_fp, []);
title('image B');

% ��(-1)^(x+y)����ͼ��Ľ��
for x = 1:P
    for y = 1:Q
        img_fp(x, y) = img_fp(x, y) .* (-1)^(x+y);
    end
end

% ��ͼ�������ٸ���Ҷ�任
img_Fp = fft2(img_fp);

%����˲�������
r = 30;
H = ones(P, Q);
for x = 1:P
    for y = 1:Q
        d = sqrt((x-M)^2 + (y-N)^2);
        if d > r
            H(x, y) = 0;
        else
            H(x, y) = 1;
        end
    end
end


figure(5);
imshow(H, []);
title('image E');

img_G = img_Fp .* H;

img_g = ifft2(img_G);
img_g = real(img_g);

for x = 1:P
    for y = 1:Q
        img_g(x, y) = img_g(x, y) .* (-1)^(x+y);
    end
end


img_o = uint8(img_g(1:M, 1:N));

figure(8);
imshow(img_o, []);
title('result H');

% imwrite(img_o, 'result.jpg');