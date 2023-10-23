function [x] = idtft(X,w,n)
%IDTFT 此处显示有关此函数的摘要
%   此处显示详细说明
x = 1/(2*pi).*(X*exp(j*w'*n)).*(w(2)-w(1));
end

