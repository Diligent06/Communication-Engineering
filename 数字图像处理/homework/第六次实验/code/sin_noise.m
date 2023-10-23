function [img_t] = sin_noise(M, A, u, v)
%SIN_NOISE 此处显示有关此函数的摘要
%   此处显示详细说明
img_f = zeros(M, M);
len = length(u);
for m = 1:len
    img_f(M/2+1+u(m), M/2+1+v(m)) = A(m);
    img_f(M/2+1-u(m), M/2+1-v(m)) = A(m);
end
img_t = real(ifft2(ifftshift(img_f)));
end