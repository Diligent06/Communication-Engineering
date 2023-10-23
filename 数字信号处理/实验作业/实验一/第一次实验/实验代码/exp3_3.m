clear all; clc;
[back, fs1] = audioread('background.wav');
[audio, fs2] = audioread('exp3_2.wav');
audio_f = audio + 0.1*back(1:length(audio),:);
sound(audio_f, fs1);
sound(audio_f, fs2);