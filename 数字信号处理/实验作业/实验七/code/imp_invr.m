function [b,a] = imp_invr(c,d,T)
%IMP_INVR 此处显示有关此函数的摘要
%调用matlab库函数实现冲激不变法。
[b,a]=impinvar(c,d,1/T);
end

