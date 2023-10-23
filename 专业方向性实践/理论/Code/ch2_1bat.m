load('batdata');
fs=1/(7e-6/399);
%% STFT
s = 1e-7;
[~,STFT_TFx,~,~,~,~,~,t,f] = TFM(data, fs, s,'M','SST2',0);
figure; imagesc(t,f,abs(STFT_TFx.')); axis xy; colormap('Turbo');

xlabel('Time/s','FontSize',24,'FontName','Times New Roman');
ylabel('Frequency/Hz','FontSize',24,'FontName','Times New Roman');
% ylim([0 50]);
% set(gca,'FontSize',24)
% set(gca,'linewidth',2);
% rectangle('Position',[x1 y1 x2-x1 y2-y1],'EdgeColor','r','Linewidth',1);
% h1=axes('position',[0.6 0.2 0.3 0.3]);
% axis(h1);
% imagesc(t,f,abs(STFT_TFx.'));axis xy; set(gca,'xcolor','r','ycolor','r');
% xlim([x1 x2]);ylim([y1 y2]);
% set(gca,'xticklabel',[]);set(gca,'yticklabel',[]);
% set(gca,'fontsize',12,'linewidth',1)