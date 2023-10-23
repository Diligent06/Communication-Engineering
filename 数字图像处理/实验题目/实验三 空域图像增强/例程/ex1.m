g = imread('.\images\sequences\6.1.01.tiff');%读取原始图像
imshow(g);
g1 = double(g);
[h, w] = size(g1);
for i = 1 : h
    for j = 1 : w
      g1(i, j) = 2*g1(i,j);   %对图像进行指定函数的线性变换
    end  
end  

g1=uint8(g1);    %转换成unit8进行显示和存储
%imwrite(g1,'ROI.jpg');
figure,imshow(g1)


g2 = imadjust(g,[0 1],[1 0],1);%对灰度级图像进行图像反转
figure,imshow(g2);

g3 = imadjust(g,[0.5 0.75],[0 1]); %将0.5到0.75之间的灰度扩展到[0 1]
figure,imshow(g3);

g4 = imadjust(g,[ ],[ ],0.5);  %伽马变换
figure,imshow(g4);

