clear all;clc;
path_1 = 'wei.wav';
path_2 = 'ni.wav';
path_3 = 'hao.wav';
[audio_1, fs] = audioread(path_1);
size(audio_1)
fs
[audio_2, fs] = audioread(path_2);
size(audio_2)
fs
[audio_3, fs] = audioread(path_3);
size(audio_3)
fs
Z = [];
Z = [Z; audio_1];
Z = [Z; audio_2];
Z = [Z; audio_3];
audiowrite('merge.wav', Z, fs);
t = 0:1/fs:(length(Z)-1)*(1/fs);
plot(t, Z);
xlabel('t'), ylabel('幅度');
title('合成后的音频信号');


