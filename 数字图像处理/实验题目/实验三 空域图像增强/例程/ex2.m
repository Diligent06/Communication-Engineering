f = imread('cat_gray.jpg');%��ȡԭʼͼ��
imshow(f);
size(f)
figure, imhist(f);  %  ��ʾֱ��ͼ
size(x)
ylim('auto')

g = histeq(f,256); %  zhifangtu 
figure,imshow(g);
figure,imhist(g);
ylim('auto')
