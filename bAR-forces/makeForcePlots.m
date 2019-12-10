% makeForces.m
clear all
close all

load ff1.mat
load ff2.mat
load ff3.mat
load ff4.mat
load ff5.mat
zz = sqrt(120);
% traction forces
TF1 = sum(FF1,2);
TF2 = sum(FF2,2);
TF3 = sum(FF3,2);
TF4 = sum(FF4,2);
TF5 = sum(FF5,2);
% traction forces average after 5 seconds
TF1a = TF1(5001:end,:);
% break up into 1 second samples
TF1b = reshape(TF1a,1000,25);
% get means for each second
TF1c = mean(TF1b);
% get mean for the means -- this value will normalize remaining groups
TF1d = mean(TF1c);
TF1dd = TF1d/TF1d;
% get standard deviation
TF1e = std(TF1b);
% get mean of SDs
TF1f = mean(TF1e);
% get SEM
TF1g = TF1f/zz;
%--------------------------------------------------------------------------
TF2a = TF2(5001:end,:);
% break up into 1 second samples
TF2b = reshape(TF2a,1000,25);
% get means for each second
TF2c = mean(TF2b);
% normalize 
TF2d = TF2c/TF1d;
% get mean of normalized means
TF2e = mean(TF2d);
% get SDs of normalized means
TF2f = std(TF2d);
% get SEM
TF2g = TF2f/zz;
%--------------------------------------------------------------------------
TF3a = TF3(5001:end,:);
% break up into 1 second samples
TF3b = reshape(TF3a,1000,25);
% get means for each second
TF3c = mean(TF3b);
% normalize 
TF3d = TF3c/TF1d;
% get mean of normalized means
TF3e = mean(TF3d);
% get SDs of normalized means
TF3f = std(TF3d);
% get SEM
TF3g = TF3f/zz;
%--------------------------------------------------------------------------
TF4a = TF4(5001:end,:);
% break up into 1 second samples
TF4b = reshape(TF4a,1000,25);
% get means for each second
TF4c = mean(TF4b);
% normalize 
TF4d = TF4c/TF1d;
% get mean of normalized means
TF4e = mean(TF4d);
% get SDs of normalized means
TF4f = std(TF4d);
% get SEM
TF4g = TF4f/zz;
%--------------------------------------------------------------------------
TF5a = TF5(5001:end,:);
% break up into 1 second samples
TF5b = reshape(TF5a,1000,25);
% get means for each second
TF5c = mean(TF5b);
% normalize 
TF5d = TF5c/TF1d;
% get mean of normalized means
TF5e = mean(TF5d);
% get SDs of normalized means
TF5f = std(TF5d);
% get SEM
TF5g = TF5f/zz;
%--------------------------------------------------------------------------
fa = [TF1dd TF2e TF3e TF4e TF5e];
fs = [TF1g TF2g TF3g TF4g TF5g];
figure
errorbar(fa,fs,'k.','LineWidth',1.5,'MarkerSize',30,'CapSize',20)
xlim([0 6])
% ylim([15 80])
xticks([1 2 3 4 5])
xticklabels({'0.1','1', '10', '100','1000'})
% yticks([10 20 30 40 50 60 70 80])
% yticklabels({10 20 30 40 50 60 70 80})
title({'Normalized Traction Force','vs. Substrate Stiffness'},'FontSize',20)
xlabel('kPa','FontSize',16)
ylabel({'Relative Traction Force'},'FontSize',16)
set(gca,'FontSize',16)
ti = get(gca,'TightInset');
set(gca,'Position',[ti(1) ti(2) 1-ti(3)-ti(1) 1-ti(4)-ti(2)]);
set(gca,'units','centimeters');
pos = get(gca,'Position');
ti = get(gca,'TightInset');
set(gcf, 'PaperUnits','centimeters');
set(gcf, 'PaperSize', [pos(3)+ti(1)+ti(3) pos(4)+ti(2)+ti(4)]);
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperPosition',[0 0 pos(3)+ti(1)+ti(3) pos(4)+ti(2)+ti(4)]);
print -dpdf normalizedTractionSpring.pdf
print -dpng normalizedTractionSpring.png
%--------------------------------------------------------------------------
figure
pcolor(FF3')
hc = colorbar;
hc=colorbar;
title(hc,'pN','FontSize',20);
set(hc,'fontsize',20)
colormap jet
shading interp
xticks([5000 10000 15000 20000 25000 30000])
xticklabels({5 10 15 20 25 30'})
caxis([0 80])
axis tight
set(gcf, 'Position',  [100, 100, 1000, 400])
title({'\fontsize{24}Force vs. Time. 10 kPa'})
xlabel('Time (s)','FontSize',16)
ylabel('Filament Number','FontSize',16)
set(gca,'FontSize',20)
ti = get(gca,'TightInset');
set(gca,'Position',[ti(1) ti(2) 1-ti(3)-ti(1) 1-ti(4)-ti(2)]);
set(gca,'units','centimeters');
pos = get(gca,'Position');
ti = get(gca,'TightInset');
set(gcf, 'PaperUnits','centimeters');
set(gcf, 'PaperSize', [pos(3)+ti(1)+ti(3) pos(4)+ti(2)+ti(4)]);
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperPosition',[0 0 pos(3)+ti(1)+ti(3) pos(4)+ti(2)+ti(4)]);
print -dpdf kymograph10kPa.pdf
print -dpng kymograph10kPa.png
%--------------------------------------------------------------------------
figure
pcolor(FF4')
hc = colorbar;
hc=colorbar;
title(hc,'pN','FontSize',20);
set(hc,'fontsize',20)
colormap jet
shading interp
xticks([5000 10000 15000 20000 25000 30000])
xticklabels({5 10 15 20 25 30'})
caxis([0 80])
axis tight
set(gcf, 'Position',  [100, 100, 1000, 400])
title({'\fontsize{24}Force vs. Time. 100 kPa'})
xlabel('Time (s)','FontSize',16)
ylabel('Filament Number','FontSize',16)
set(gca,'FontSize',20)
ti = get(gca,'TightInset');
set(gca,'Position',[ti(1) ti(2) 1-ti(3)-ti(1) 1-ti(4)-ti(2)]);
set(gca,'units','centimeters');
pos = get(gca,'Position');
ti = get(gca,'TightInset');
set(gcf, 'PaperUnits','centimeters');
set(gcf, 'PaperSize', [pos(3)+ti(1)+ti(3) pos(4)+ti(2)+ti(4)]);
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperPosition',[0 0 pos(3)+ti(1)+ti(3) pos(4)+ti(2)+ti(4)]);
print -dpdf kymograph100kPa.pdf
print -dpng kymograph100kPa.png