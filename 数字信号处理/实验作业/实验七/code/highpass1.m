function [bz,az] = highpass1(w_p,ws,Rp,As,wc)
%HIGHPASS 此处显示有关此函数的摘要
%wp、ws、Rp、As为低通数字滤波器参数，wc为高通截止频率
[b,a]=afd_cheb1(w_p,ws,Rp,As);
wp=2*atan(w_p);
alpha=cos((wp+wc)/2)/cos((wc-wp)/2);
Nz=[alpha,1];
Dz=[1,alpha];
[bz,az]=zmapping(b,a,Nz,Dz);
end

