f = imread('cat_gray.jpg');%读取原始图像
f1 = imnoise(f ,'gaussian');    %添加高斯噪声
%f1 = imnoise(f,'salt & pepper')   %添加椒盐噪声
figure,imshow(f1)

f1 = double(f1);
[h,w] = size(f1);
f2 = zeros(h+2,w+2);
%边缘填充,保证边缘像素也能进行滤波操作
f2(2:h+1,2:w+1) = f1;

f2(1,2:w+1)=f1(1,:);
f2(h+2,2:w+1)=f1(h,:);

f2(2:h+1,1)=f1(:,1);
f2(2:h+1,w+2)=f1(:,w);

f2(1,1) = f1(1,1);
f2(1,w+2) = f1(1,w);

f2(h+2,1) = f1(h,1);
f2(h+2,w+2) = f1(h,w);
%对图像进行模板为3*3的均值滤波
for i = 1 : h
    for j = 1 : w
      f1(i, j) = (f2(i,j)+f2(i+1,j)+f2(i+2,j)+ f2(i,j+1)+f2(i+1,j+1)+f2(i+2,j+1)+ f2(i,j+2)+f2(i+1,j+2)+f2(i+2,j+2))/9; 
    end  
end  

f1=uint8(f1);    %转换成unit8进行显示和存储
%imwrite(f1,'.jpg');
figure,imshow(f1)


