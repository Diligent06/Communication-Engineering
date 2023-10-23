function [b,a] = u_chb1ap(N,Rp,Omega)
%U_CHB1AP 此处显示有关此函数的摘要
%   此处显示详细说明
%求归一化cheb1ap滤波器
[z,p,k]=cheb1ap(N,Rp);
%获得传递函数
Gs=zpk(z,p,k);
%求直接型传递函数分子分母系数
[b,a]=tfdata(Gs,'v');
len=max(length(b),length(a));
%生成Omega的等比序列
s=logspace(0,log10(Omega.^(len-1)),len);
%去归一化
b=b./s;
a=a./s;
end

