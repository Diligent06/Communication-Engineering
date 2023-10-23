function [r, R, S] = imnoise3(M, N, C, A, B)
% IMNOISE3 Generates periodic noise.
%   [r, R, S] = IMNOISE3(M, N, C, A, B), generates a spatial sinusoidal
%   noise pattern, r, of size M-by-N, its Fourier transform, R, and
%   spectrum, S. The remaining parameters are as follows:
%   C is a K-by-2 matrix containing K pairs of frequency domain coordinates
%   (u, v) indicating the locations of impulses in the frequency domain.
%   These locations are with respect to the frequency rectangele center at
%   (M/2 + 1, N/2 + 1). Only one paor of coordinates is required for each
%   impulse. The program automatically generates the locations of the
%   conjugate symmetric impulses. These impulse paird determine the
%   frequency content of r.
%   A is a 1-by-k vector that contains the ampitude of each of the K
%   impulse pairs. If A is not included in the argument, the default used
%   is A = ONES(1, K). B is then automatically set to its default values
%   (see next paragraph). The value specified for A(j) is associated with
%   the coordinates in C(j, 1:2).
% B is a K-by-2 matrix containing the Bx and By phase components for each
% impulse pair. The default values for B are B(1:K, 1:2) = 0.

% Chinese : 根据5.2.3周期噪声的DFT公式得到，A是振幅，u0，v0是关于x轴和y轴确定正弦频率，这里是C表示
% Bx和By是关于原点的相移。
% [r，R，S] = IMNOISE3（M，N，C，A，B），产生大小为M-by-N的空间正弦噪声模式r，
% 其傅里叶变换R和频谱S。 其余参数如下：
% C是K-by-2矩阵，包含K对频域坐标（u，v）， 表示频域中脉冲的位置。 
% 这些位置相对于频率矩形中心（M / 2 + 1，N / 2 + 1）。 每个脉冲只需要一个坐标。 
% 程序自动生成共轭对称脉冲的位置。 这些脉冲信号决定了r的频率成分。
% A是1×k矢量，包含每个K脉冲对的幅度。 如果参数中不包含A，则使用的默认值为A = ONES（1，K）。 
% 然后B自动设置为其默认值（参见下一段）。 为A（j）指定的值与C（j，1：2）中的坐标相关联。 
% B是K-by-2矩阵，包含每个脉冲对的Bx和By相位分量。 B的默认值为B（1：K，1：2）= 0。

% Process input parameters.
[K, n] = size(C);
if nargin ==3
    A(1:K) = 1.0;
    B(1:K, 1:2) = 0;
elseif nargin == 4
    B(1:K, 1:2) = 0;
end

% Generate R
R = zeros(M, N);
for j = 1:K
    u1 = M/2 + 1 + C(j, 1);
    v1 = N/2 + 1 + C(j, 2);
    R(u1, v1) = i * (A(j)/2) * exp(i * 2 * pi * C(j, 1)* B(j,1)/M);  % 位于(u + u0, v + v0) 的冲击处的R
    % Complex conjugate.
    u2 = M/2 + 1 - C(j, 1);
    v2 = N/2 + 1 - C(j, 2);
    R(u2, v2) = -i * (A(j)/2) * exp(i * 2 * pi * C(j, 2)* B(j,2)/M);% 位于(u - u0, v - v0) 的冲击处的R
end
% Compute spectrum and spatial sinusoidal pattern.
S = abs(R);
r = real(ifft2(ifftshift(R)));