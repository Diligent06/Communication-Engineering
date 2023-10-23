function [image_out, g, H] = atmoTurbulence(image_in, k)
% 模拟受大气湍流影响得到的图像
% 输入为初始灰度图像，大气湍流模型的系数k
% 输出为受到大气湍流影响的结果图像
% 该实现方法没有对原图像进行填充。

[m, n] = size(image_in);
fp = zeros(m, n);
% 中心化
for i = 1 : m
    for j = 1 : n
        fp(i, j) = double(image_in(i,j)) * (-1)^(i+j);
    end
end
% 傅里叶变换
F1 = fft2(fp);
% 变换中心
p = m / 2 + 1.0;
q = n / 2 + 1.0;
% 生成大气湍流模型函数
H = zeros(m, n);
for u = 1 : m
    for v = 1 : n
        temp1 = (u-p)^2+(v-q)^2;
        H(u,v) = exp((-k)*(temp1^(5/6)));
    end
end
% 滤波
G = H .* F1;
% 反傅里叶变换，并取实部
gp = real(ifft2(G));
% 反中心化

g = zeros(m, n);
for i = 1 : m
    for j = 1 : n
        g(i, j) = gp(i, j) * (-1)^(i+j);
    end
end
% 归一化输出图像到[0, 255],g取uint8的结果与课本一致
image_out = zeros(m, n, 'uint8');
mmax = max(g(:));
mmin = min(g(:));
range = mmax-mmin;
for i = 1 : m
    for j = 1 : n
        image_out(i,j) = uint8(255 * (g(i, j)-mmin) / range);
    end
end

end