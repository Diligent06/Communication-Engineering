function [b,a] = afd_cheb1(Wp,Ws,Rp,As)
%AFD_CHEB1 此处显示有关此函数的摘要
%   此处显示详细说明
epsilon=sqrt(10^(Rp/10)-1);
A=10^(As/20);
omu_r=Ws/Wp;
g=sqrt((A^2-1)/epsilon^2);
N=log10(g+sqrt(g^2-1))/log10(omu_r+sqrt(omu_r-1));
N=floor(N)+1;
[b,a]=u_chb1ap(N,Rp,Wp);
end

