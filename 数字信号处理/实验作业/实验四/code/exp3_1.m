clear all; clc;
n = 0:1:14;
x_n = 10*(0.8).^n;
%% 向右移位6个单位
x_n_6 = zeros(1, 15);
x_n_6(1) = x_n(10);
x_n_6(2) = x_n(11);
x_n_6(7:15) = x_n(1:9);

%% 绘制y(n)=x((n-6))_15波形
n_y = -50:1:50;
y_n = zeros(1, 101);
for i = 1:101
    y_n(i) = x_n_6(mod(mod((i - 51), 11)+11, 11) + 1);
end
scatter(n_y, y_n);
xlabel('n');ylabel('y(n)');title('y(n)=x((n-6))_15');