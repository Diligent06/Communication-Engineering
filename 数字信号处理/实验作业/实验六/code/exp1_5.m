clear all; clc;
a = [1 2 3];
b = [2 3 4];
[C, B, A] = dir2par(b, a);
delta = [1 zeros(1, 31)];
t = 0:31;
y = parfilter(C, B, A, delta);
figure;
plot(t, y);
xlabel('t');ylabel('Filter Output');
title('并联型冲激响应')