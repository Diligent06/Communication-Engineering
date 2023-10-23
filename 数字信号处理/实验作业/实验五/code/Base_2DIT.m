function [xk] = Base_2DIT(xn, N)
%BASE_2DIT 此处显示有关此函数的摘要
%   此处显示详细说明
if(N == 2)
    xk = [xn(1)+xn(2);xn(1)-xn(2)];
else
    xk_e = Base_2DIT(xn(1:2:N-1), N/2);
    xk_o = Base_2DIT(xn(2:2:N), N/2);

    wn = exp(-1i*2*pi/N);
    n = 0:1:N/2-1;
    D = (wn*(ones(1, N/2))).^n;
    tmp = (D.') .* xk_o;
    xk = [xk_e+tmp;xk_e-tmp];
end
end

