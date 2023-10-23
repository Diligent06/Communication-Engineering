function [X] = dfs(x, N)
%DFS 此处显示有关此函数的摘要
%   此处显示详细说明
n = 0:1:N-1;
k = -N:1:N-1;
if N > length(x)
    x = [x, zeros(1, N-length(x))];
elseif N < length(x)
    fprintf('Error! N should not be less than length of x(n)\n');
    X = zeros(1, length(x));
    return
end
W = exp(-1i * 2 * pi / N);
nk = n'*k;
X = x * power(W, nk);
end

