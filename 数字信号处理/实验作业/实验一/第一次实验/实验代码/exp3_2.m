clear all; clc;
[back, fs1] = audioread('background.wav');
[audio, fs2] = audioread('exp3_2.wav');

audio_f = audio + 0.1*back(1:length(audio),:);
t = 0:1/fs2:(length(audio)-1)*(1/fs2);
figure(1);
plot(t, audio), xlabel('t'), ylabel('幅度'), title('采样频率为88200Hz的序列');
figure(2);
plot(t, audio_f), xlabel('t'), ylabel('幅度');
title('不同采样率合成音频');
sound(audio_f, fs2);