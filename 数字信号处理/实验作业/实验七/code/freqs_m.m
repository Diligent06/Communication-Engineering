function [db,pha,w] = freqs_m(b,a,wmax)
%FREQS_M 此处显示有关此函数的摘要
%形成频率点
w=0:1/wmax:wmax-1/wmax;
%求频率响应
h=freqs(b,a,w);
%求出幅频、相频响应
db=20*log10(abs(h));
pha=angle(h);
end

