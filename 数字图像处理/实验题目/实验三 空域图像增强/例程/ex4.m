f = imread('cameraman.tif');%读取原始图像

%w = fspecial('laplacian',0)  % laplacian算子
w = fspecial('sobel')         %sobel算子
imshow(f);

 f1 = double(f);     
 g1 = imfilter(f1,w,'replicate');    %滤波
 figure,imshow(g1)
 
 g = f1 - g1;
 figure,imshow(g);