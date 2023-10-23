clear all; clc;
[hao, fs] = audioread('hao.wav');

%% D=2的抽取系统
res1 = [];
[h, w] = size(hao);
for i = 1:2:h
    res1 = [res1; hao(i)];
end
t = 1:floor(h/2);
figure;
plot(t, res1);
sound(res1, fs/2, 8);

%% 插值参数为4的插值系统
res2 = zeros([h*4, w]);
for i = 1:h
    res2((i-1)*4+1) = hao(i);
    for j = 1:3
        if i == h
            res2((i-1)*4+1+j) = hao(i);
        else
            res2((i-1)*4+1+j) = hao(i)+(hao(i+1)-hao(i))/4*j;
        end
    end
end
figure;
t2 = 1:h*4;
plot(t2, res2);
sound(res2, fs*4, 8);