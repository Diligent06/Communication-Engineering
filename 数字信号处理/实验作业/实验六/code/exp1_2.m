clear all; clc;
a = [1 2 3];
b = [2 3 4];
[b0, B, A] = dir2cas(b, a);
delta = [1 zeros(1, 31)];
t = 0:31;
y = casfilter(b0,B,A,delta);
figure;
plot(t, y);
xlabel('t');ylabel('Filter Output');title('冲激响应时域波形');