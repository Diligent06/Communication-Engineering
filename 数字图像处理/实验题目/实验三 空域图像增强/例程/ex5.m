g = imread('.\images\sequences\6.1.01.tiff');%读取原始图像
imshow(g);
g = double(g);
g = g./255;
g2 = imadjust(g,[0 1],[1 0],1);%对灰度级图像进行图像反转
figure,imshow(g2);