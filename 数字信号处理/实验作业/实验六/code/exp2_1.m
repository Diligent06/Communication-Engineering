clear all; clc;
b = [1, 0, 0, 8.125, 0, 0, 1];
a = [1];
%% 求级联型系数
[b0, B, A] = dir2cas(b, a)