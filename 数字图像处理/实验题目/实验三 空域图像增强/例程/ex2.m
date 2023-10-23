f = imread('cat_gray.jpg');%读取原始图像
imshow(f);
size(f)
figure, imhist(f);  %  显示直方图
size(x)
ylim('auto')

g = histeq(f,256); %  zhifangtu 
figure,imshow(g);
figure,imhist(g);
ylim('auto')
