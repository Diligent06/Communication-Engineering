function [b,a] = afd_butt(Wp,Ws,Rp,As)
%AFD_BUTT 此处显示有关此函数的摘要
%求滤波器阶数N
N=log10((10^(As/10)-1)/(10^(Rp/10)-1))/(2*log10(Ws/Wp));
N=floor(N)+1;
%求Omega
Omega_p=Wp/nthroot(10^(Rp/10)-1,2*N);
Omega_s=Ws/nthroot(10^(As/10)-1,2*N);
Omega=(Omega_s+Omega_p)/2;
%求去归一化后的低通滤波器
[b,a]=u_buttap(N,Omega);
end

