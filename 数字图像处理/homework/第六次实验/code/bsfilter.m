function [H, D] = bsfilter(type,M,N,D0,n)
%BSFILTER 此处显示有关此函数的摘要
%   此处显示详细说明
%use function dftuv to set up the meshgrid arrays needed for computing 
%the required distances.
[U, V] = dftuv(M,N);

%compute the distances D(U,V)
D = sqrt(U.^2 + V.^2);

switch type
    case 'ideal'
        H = double(D > D0+n) + double(D < D0-n);
    case 'btw'
        if nargin == 4
            n = 1;
        end
        H = 1./(1+(D./D0).^(2*n));
    case 'gaussian'
        H = exp(-(D.^2)./(2*(D0^2)));
    otherwise 
        error('Unkown filter type');

end

