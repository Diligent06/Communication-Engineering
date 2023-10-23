function [U,V]=dftuv(M,N)

% DFTUV Computes meshgrid frequency matrices.

% [U,V]=dftuv(M,N) computes meshgrid frequency matrices U and V.

% U and V are useful for computing frequency-domain filter

% functions.U and V are both M-by-N.

% %****from ggbondg****

% Set up range of variables.

u=0:M-1;

v=0:N-1;

%****from ggbondg****

% Compute the incides for use in meshgrid.

idx=find(u>M/2);

u(idx)=u(idx)-M;

idy=find(v>N/2);

v(idy)=v(idy)-N;

%****from ggbondg****

% Compute the meshgrid arrays.

[V,U]=meshgrid(v,u);

%****from ggbondg****