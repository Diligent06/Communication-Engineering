function [C, B, A] = dir2par(b, a)
%DIR2PAR 此处显示有关此函数的摘要
%   此处显示详细说明
[r, p, C] = residuez(b, a);
N = length(r);
A = zeros(ceil(N/2), 3); B = A;
k = 1;
if mod(N,2) == 1
    for i = 1:2:N-1
        [B(k,:),A(k,:)] = residuez([r(i),r(i+1)], [p(i),p(i+1)], 0);
        k = k + 1;
    end
    B(end,:) = [r(end), 0, 0];
    A(end,:) = [1, -p(end), 0];
else
    for i = 1:2:N
        [B(k,:),A(k,:)] = residuez([r(i),r(i+1)],[p(i),p(i+1)],0);
        k = k + 1;
    end
end
end

