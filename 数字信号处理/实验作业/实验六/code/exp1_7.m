clear all; clc;
%% 直接型
b = [1 -4 10 -25 16];
a = [15 10 3 -5 -2];
t = 0:31;
delta = [1 zeros(1, 31)];
figure;
plot(t, filter(b, a, delta));
xlabel('t');ylabel('Dir Output');title('直接型冲激响应');
%% 级联型
[b0, B, A] = dir2cas(b, a);
figure;
plot(t, casfilter(b0, B, A, delta));
xlabel('t');ylabel('Cas Output');title('级联型冲激响应');
%% 并联型
[C, B, A] = dir2par(b, a)
figure;
plot(t, parfilter(C, B, A, delta));
xlabel('t');ylabel('Par Output');title('并联型冲激响应');