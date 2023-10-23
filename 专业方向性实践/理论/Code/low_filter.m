function out_Sig = low_filter(Sig,SampFreq,cutFreq)
% FIR low-pass filtering 
% Sig: measured signal for filtering
% SampFreq: sampling frequency
% cutFreq: cutoff frequency of the filter

n0 = length(Sig);
n = floor(n0*0.8); % length of the filter
T = 1/SampFreq; % 
w1 = 2*pi*cutFreq; %
w1 = w1*T/pi; %normalized cutoff frequency

if mod(n,2) == 0
L = n;
else
L = n + 1;
end
b = fir1(L,w1,'low');
Sig1 = conv(b,Sig);
out_Sig = Sig1(L/2+1:L/2+n0); %correct the phase shift of the filter