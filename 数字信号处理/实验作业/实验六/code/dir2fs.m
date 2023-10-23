function [C, B, A] = dir2fs(h)
%DIR2FS 此处显示有关此函数的摘要
%   此处显示详细说明
% C~N，B~Hk，A~wk
C = length(h);
B = fft(h);
k = 0:C-1;
A = exp(2*pi*1i/C).^k;
end

