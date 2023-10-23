clear all; clc;
load('batdata.mat');
fs = (1/(7e-6/399));
T = (400-1)*(1/fs);
t = 0:1/fs:(400-1)*(1/fs);
size(data);
%% STFT
s = 1e-7;
[~,STFT_TFx,~,~,~,~,~,t,f] = TFM(data, fs, s, 'M', 'SST2', 0);
figure(1);
imagesc(t, f, abs(STFT_TFx.')); axis xy, colormap('turbo');
set(gcf, 'Position', [20 100 320 250]);
xlabel('Time / Sec', 'FontSize', 12, 'FontName', 'Times New Roman');
ylabel('Frequency / Hz', 'FontSize', 12, 'FontName', 'Times New Roman');
set(gca, 'YDir', 'normal');
set(gca, 'FontSize', 12);
set(gcf, 'Color', 'w');
size(t)
size(f)
%% ridge extraction and smoothing
bw = fs / 80;
beta1 = 1e-2;
Nfrebin = 201;
window = 32;
num = 4;
delta = 20;
[fidexmult, tfdv] = extridge_mult(data', fs, num, delta, beta1, bw, Nfrebin, window);
for i = 1:215
    fidexmult(4, i) = 1;
end
for i = 358:400
    fidexmult(4, i) = 1;
end
for i = 1:42
    fidexmult(1, i) = 1;
end
for i = 347:400
    fidexmult(1, i) = 1;
end
for i = 1:17
    fidexmult(2, i) = 1;
end
for i = 375:400
    fidexmult(2, i) = 1;
end
for i = 1:98
    fidexmult(3, i) = 1;
end
for i = 362:400
    fidexmult(3, i) = 1;
end
figure(2);
set(gcf, 'Position', [20 100 640 500]);
set(gcf, 'Color', 'w');
plot(t, f(fidexmult), 'linewidth', 3);

%% reconstruction
temp_stft = STFT_TFx.';
singleside = 5;
[L, N] = size(temp_stft);
temp1 = zeros([L,N]);
temp2 = zeros([L,N]);
temp3 = zeros([L,N]);
temp4 = zeros([L,N]);
for i = 1:N
    upboard = min(L, fidexmult(1,i)+singleside+1);
    downboard = max(1, fidexmult(1,i)-singleside+1);
    temp1(downboard:upboard,i) = 1;
    upboard = min(L, fidexmult(2,i)+singleside+1);
    downboard = max(1, fidexmult(2,i)-singleside+1);
    temp2(downboard:upboard,i) = 1;
    upboard = min(L, fidexmult(3,i)+singleside+1);
    downboard = max(1, fidexmult(3,i)-singleside+1);
    temp3(downboard:upboard,i) = 1;
    upboard = min(L, fidexmult(4,i)+singleside+1);
    downboard = max(1, fidexmult(4,i)-singleside+1);
    temp4(downboard:upboard,i) = 1;
end
STFT_model1 = temp1 .* temp_stft;
STFT_model2 = temp2 .* temp_stft;
STFT_model3 = temp3 .* temp_stft;
STFT_model4 = temp4 .* temp_stft;
figure;
imagesc(t,f,abs(STFT_model1));
figure;
imagesc(t,f,abs(STFT_model2));
figure;
imagesc(t,f,abs(STFT_model3));
figure;
imagesc(t,f,abs(STFT_model4));
size(STFT_model1)
%% ITFM
[STFT_Recon1, ~] = ITFM(STFT_model1.', fs, s, 'M', 'SST2');
figure; plot(t, STFT_Recon1);
axis([0 7e-6 -0.25 0.25]);
[STFT_Recon2, ~] = ITFM(STFT_model2.', fs, s, 'M', 'SST2');
figure; plot(t, STFT_Recon2);
axis([0 7e-6 -0.25 0.25]);
[STFT_Recon3, ~] = ITFM(STFT_model3.', fs, s, 'M', 'SST2');
figure; plot(t, STFT_Recon3);
axis([0 7e-6 -0.25 0.25]);
[STFT_Recon4, ~] = ITFM(STFT_model4.', fs, s, 'M', 'SST2');
figure; plot(t, STFT_Recon4);
axis([0 7e-6 -0.25 0.25]);
%% plot res
figure;
plot(t, data);
figure;
plot(t, STFT_Recon1+STFT_Recon2+STFT_Recon3+STFT_Recon4-data);
axis([0 7e-6 -0.25 0.25]);