g = imread('.\images\sequences\6.1.01.tiff');%��ȡԭʼͼ��
imshow(g);
g1 = double(g);
[h, w] = size(g1);
for i = 1 : h
    for j = 1 : w
      g1(i, j) = 2*g1(i,j);   %��ͼ�����ָ�����������Ա任
    end  
end  

g1=uint8(g1);    %ת����unit8������ʾ�ʹ洢
%imwrite(g1,'ROI.jpg');
figure,imshow(g1)


g2 = imadjust(g,[0 1],[1 0],1);%�ԻҶȼ�ͼ�����ͼ��ת
figure,imshow(g2);

g3 = imadjust(g,[0.5 0.75],[0 1]); %��0.5��0.75֮��ĻҶ���չ��[0 1]
figure,imshow(g3);

g4 = imadjust(g,[ ],[ ],0.5);  %٤��任
figure,imshow(g4);

