g = imread('.\images\sequences\6.1.01.tiff');%��ȡԭʼͼ��
imshow(g);
g = double(g);
g = g./255;
g2 = imadjust(g,[0 1],[1 0],1);%�ԻҶȼ�ͼ�����ͼ��ת
figure,imshow(g2);