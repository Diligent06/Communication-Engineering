function [b,a] = u_buttap(N,Omega)
%U_BUTTAP 此处显示有关此函数的摘要
%求归一化buttap滤波器
[z,p,k] = buttap(N);
%获得传递函数
Gs = zpk(z,p,k);
%得到分子分母系数
[b,a] = tfdata(Gs, 'v');
len=max(length(b),length(a));
%生成Omega的等比序列
s=logspace(0,log10(Omega.^(len-1)),len);
%去归一化过程
b=b./s;
a=a./s;
end

