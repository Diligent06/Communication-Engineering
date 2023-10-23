f = imread('cat_gray.jpg');%��ȡԭʼͼ��
f1 = imnoise(f ,'gaussian');    %��Ӹ�˹����
%f1 = imnoise(f,'salt & pepper')   %��ӽ�������
figure,imshow(f1)

f1 = double(f1);
[h,w] = size(f1);
f2 = zeros(h+2,w+2);
%��Ե���,��֤��Ե����Ҳ�ܽ����˲�����
f2(2:h+1,2:w+1) = f1;

f2(1,2:w+1)=f1(1,:);
f2(h+2,2:w+1)=f1(h,:);

f2(2:h+1,1)=f1(:,1);
f2(2:h+1,w+2)=f1(:,w);

f2(1,1) = f1(1,1);
f2(1,w+2) = f1(1,w);

f2(h+2,1) = f1(h,1);
f2(h+2,w+2) = f1(h,w);
%��ͼ�����ģ��Ϊ3*3�ľ�ֵ�˲�
for i = 1 : h
    for j = 1 : w
      f1(i, j) = (f2(i,j)+f2(i+1,j)+f2(i+2,j)+ f2(i,j+1)+f2(i+1,j+1)+f2(i+2,j+1)+ f2(i,j+2)+f2(i+1,j+2)+f2(i+2,j+2))/9; 
    end  
end  

f1=uint8(f1);    %ת����unit8������ʾ�ʹ洢
%imwrite(f1,'.jpg');
figure,imshow(f1)


