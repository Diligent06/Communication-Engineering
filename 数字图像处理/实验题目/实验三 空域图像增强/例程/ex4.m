f = imread('cameraman.tif');%��ȡԭʼͼ��

%w = fspecial('laplacian',0)  % laplacian����
w = fspecial('sobel')         %sobel����
imshow(f);

 f1 = double(f);     
 g1 = imfilter(f1,w,'replicate');    %�˲�
 figure,imshow(g1)
 
 g = f1 - g1;
 figure,imshow(g);