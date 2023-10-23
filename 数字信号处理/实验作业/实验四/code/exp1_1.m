clear all; clc;
x = [1, 2, 3, 4];
N = 4;
xk = dfs(x, 4);

num = -4:1:3;
figure;
scatter(num, abs(xk));xlabel('k');ylabel('abs(X(k))');title('DFS result');

xn = idfs(xk(1,N+1:2*N), N);figure;
scatter(num, xn);xlabel('n');ylabel('x(n)');title('IDFS result');
