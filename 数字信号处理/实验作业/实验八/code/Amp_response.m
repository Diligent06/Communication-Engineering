function [Amp,w] = Amp_response(h)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
n=length(h);
Amp=abs(fft(h,n));
w=(0:1:n-1)/n;
end

