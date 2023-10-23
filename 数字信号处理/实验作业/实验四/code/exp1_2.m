clear all; clc;
xn = [1, 2, 3, 0];
N = 4;
xk = dfs(xn, N);
num = -N:1:N-1;
scatter(num, abs(xk));xlabel('k');ylabel('abs(x(k))');title('DFS result');