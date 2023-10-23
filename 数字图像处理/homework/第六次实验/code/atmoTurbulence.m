function [image_out, g, H] = atmoTurbulence(image_in, k)
% ģ���ܴ�������Ӱ��õ���ͼ��
% ����Ϊ��ʼ�Ҷ�ͼ�񣬴�������ģ�͵�ϵ��k
% ���Ϊ�ܵ���������Ӱ��Ľ��ͼ��
% ��ʵ�ַ���û�ж�ԭͼ�������䡣

[m, n] = size(image_in);
fp = zeros(m, n);
% ���Ļ�
for i = 1 : m
    for j = 1 : n
        fp(i, j) = double(image_in(i,j)) * (-1)^(i+j);
    end
end
% ����Ҷ�任
F1 = fft2(fp);
% �任����
p = m / 2 + 1.0;
q = n / 2 + 1.0;
% ���ɴ�������ģ�ͺ���
H = zeros(m, n);
for u = 1 : m
    for v = 1 : n
        temp1 = (u-p)^2+(v-q)^2;
        H(u,v) = exp((-k)*(temp1^(5/6)));
    end
end
% �˲�
G = H .* F1;
% ������Ҷ�任����ȡʵ��
gp = real(ifft2(G));
% �����Ļ�

g = zeros(m, n);
for i = 1 : m
    for j = 1 : n
        g(i, j) = gp(i, j) * (-1)^(i+j);
    end
end
% ��һ�����ͼ��[0, 255],gȡuint8�Ľ����α�һ��
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