function outf = curvesmooth(f,beta)
% f£ºinput instantaneous frequencies (IFs)
% outf: output smoothed IF curves
% beta: controls the smooth degree; the curves will be smoother if beta is smaller
[K,N] = size(f);% K is the number of the components£¬N is the number of the samples
e = ones(N,1);
e2 = -2*e;
% e2(1) = -1;e2(end) = -1;
oper = spdiags([e e2 e], 0:2, N-2, N);% oper = spdiags([e e2 e], -1:1, N, N);%the modified second-order difference matrix
opedoub = oper'*oper;%
outf = zeros (K,N);
for i = 1:K
    outf(i,:) = (2/beta*opedoub + speye(N))\f(i,:).'; % smooth the instantaneous frequency curves by low pass filtering
end
