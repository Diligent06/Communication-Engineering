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

% Chinese : ����5.2.3����������DFT��ʽ�õ���A�������u0��v0�ǹ���x���y��ȷ������Ƶ�ʣ�������C��ʾ
% Bx��By�ǹ���ԭ������ơ�
% [r��R��S] = IMNOISE3��M��N��C��A��B����������СΪM-by-N�Ŀռ���������ģʽr��
% �丵��Ҷ�任R��Ƶ��S�� ����������£�
% C��K-by-2���󣬰���K��Ƶ�����꣨u��v���� ��ʾƵ���������λ�á� 
% ��Щλ�������Ƶ�ʾ������ģ�M / 2 + 1��N / 2 + 1���� ÿ������ֻ��Ҫһ�����ꡣ 
% �����Զ����ɹ���Գ������λ�á� ��Щ�����źž�����r��Ƶ�ʳɷ֡�
% A��1��kʸ��������ÿ��K����Եķ��ȡ� ��������в�����A����ʹ�õ�Ĭ��ֵΪA = ONES��1��K���� 
% Ȼ��B�Զ�����Ϊ��Ĭ��ֵ���μ���һ�Σ��� ΪA��j��ָ����ֵ��C��j��1��2���е������������ 
% B��K-by-2���󣬰���ÿ������Ե�Bx��By��λ������ B��Ĭ��ֵΪB��1��K��1��2��= 0��

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
    R(u1, v1) = i * (A(j)/2) * exp(i * 2 * pi * C(j, 1)* B(j,1)/M);  % λ��(u + u0, v + v0) �ĳ������R
    % Complex conjugate.
    u2 = M/2 + 1 - C(j, 1);
    v2 = N/2 + 1 - C(j, 2);
    R(u2, v2) = -i * (A(j)/2) * exp(i * 2 * pi * C(j, 2)* B(j,2)/M);% λ��(u - u0, v - v0) �ĳ������R
end
% Compute spectrum and spatial sinusoidal pattern.
S = abs(R);
r = real(ifft2(ifftshift(R)));