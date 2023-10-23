clear all; clc;
taiji = imread('../material/太极.jpg');
[h, w, ~] = size(taiji);
taiji = im2gray(taiji);
taiji = im2bw(taiji, 0.5);

x_difference = zeros([h, w]);
y_difference = zeros([h, w]);
xy_difference = zeros([h, w]);
for i = 1 : h
    if i == h
        continue;
    end
    y_difference(i,:)=abs(taiji(i+1,:)-taiji(i,:));
end
for i = 1 : w
    if i == w
        continue;
    end
    x_difference(:,i)=abs(taiji(:,i+1)-taiji(:,i));
end

xy_difference = x_difference + y_difference;
xy_difference = im2bw(xy_difference, 0.9999);
figure(2);
imshow(xy_difference);
imwrite(xy_difference, '../output/xy_difference.jpg');