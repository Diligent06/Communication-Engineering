clear all; clc;
a = [1 2 3];
b = [2 3 4];
[b0, B, A] = dir2cas(b, a);
[b_, a_] = cas2dir(b0, B, A)