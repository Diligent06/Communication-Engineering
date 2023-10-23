function [fidexmult, tfdv] = extridge_mult(Sig, SampFreq, num, delta, beta,bw,Nfrebin,window)
% Extract ridges for multi-component signals.
% In each iteration,the signal component associated with the extrated ridge is
% reconstructed by a time-frequency (TF) filter and then removed from the original signal so
% that the ridge curves of other signal components with smaller energies
% can be extracted in the subsequent iterations.
%%%%%%%%%%%%%%%%%%%%%%%    input      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Sig£ºmeasured signal,a row vector
% SampFreq: sampling frequency
% num: the number of the signal components
% delta£ºmaximum allowable frequency variation between two consecutive points for ridge detection
% beta: controls the smooth degree; the curves will be smoother if beta is smaller
% bw£ºthe bandwidth of the TF filter (unit£ºHz);
% Nfrebin,window are two parameters for implementing the STFT


%%%%%%%%%%%%%%%%%%%%%%%%%%%%  output   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% fidexmult: obtained ridge index for multi-component signals
% tfdv: the corresponding ridge magnitude 

%if (isreal(Sig))
%Sig = hilbert(Sig);
%end
fidexmult = zeros(num,length(Sig));
tfdv = zeros(num,length(Sig));
s=1e-7;
[~,Spec,~,~,~,~,~,t,f] = TFM(Sig', SampFreq, s, 'M', 'SST2', 0);
Spec = Spec.';
for i = 1:num
%[Spec,f] = STFT(Sig(:),SampFreq,Nfrebin,window); %STFT
%c = findridges(Spec,delta);
c = findridges(Spec, delta);
[sIF,extr_Sig] = Dechirp_filter(Sig,SampFreq,bw,f(c),beta); % the TF filter; we smooth the extracted ridges and the smoothed curve is sIF
findex = zeros(1,length(Sig));
for j = 1:length(Sig)
   [~,findex(j)] = min(abs(f - sIF(1,j)));
   tfdv(i,j) = abs(Spec(findex(j),j));
end
for k = 1:400
    q = findex(k);
    for l = 1:5
        Spec(min(q+l,201), k) = 0;
        Spec(max(q-l,1), k) = 0;
    end
    Spec(q, k) = 0;
end

fidexmult(i,:) = findex;
Sig = Sig - extr_Sig; % remove the extracted signal component so that other ridge curves with smaller energies can be extracted in the subsequent iterations
end