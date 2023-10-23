function [sIF,out_Sig] = Dechirp_filter(Sig,SampFreq,bw,IF,beta)
%Extract a signal component by using de-chirp and low-pass filtering techniques£»This technique can be regarded as a time-frequency(TF)filtering technique
% Sig£ºmeasured signal£ºa row vector
% SampFreq£ºsampling frequency
% bw£ºbandwidth of the TF filter (unit£ºHz)
% IF: instantaneous frequency series of the target component£»it can be extracted by detecting TF ridges
% beta£ºcontrols the smooth degree the IF; the curves will be smoother if beta is smaller
% out_Sig£ºextracted signal
% sIF£ºsmoothed IF
if (isreal(Sig))
Sig = hilbert(Sig);
end
t = (0:length(Sig)-1)/SampFreq;%time
sIF = curvesmooth(IF,beta);%smooth the IF
phase = cumtrapz(t,sIF); % integral
Sig1r = Sig .* exp( -j * 2.0 * pi * phase);   %de-chirp
Sig_comp = low_filter(Sig1r,SampFreq,bw/2);% low pass filtering
out_Sig = Sig_comp.* exp( j * 2.0 * pi * phase); % recover the filtered signal
end