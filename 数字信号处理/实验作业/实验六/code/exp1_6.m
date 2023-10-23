clear all; clc;
a = [1 2 3];
b = [2 3 4];
[C, B, A] = dir2par(b, a);
[b_, a_] = par2dir(C, B, A)