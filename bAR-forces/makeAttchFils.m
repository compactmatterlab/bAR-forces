% average count of attached filaments
clear all
close all
zz = sqrt(120);
load ff1.mat
load ff2.mat
load ff3.mat
load ff4.mat
load ff5.mat
FF1( FF1 <= 20 ) = 0;
FF1( FF1 >= 10 ) = 1;
FF2( FF2 <= 20 ) = 0;
FF2( FF2 >= 10 ) = 1;
FF3( FF3 <= 20 ) = 0;
FF3( FF3 >= 10 ) = 1;
FF4( FF4 <= 20 ) = 0;
FF4( FF4 >= 10 ) = 1;
FF5( FF5 <= 20 ) = 0;
FF5( FF5 >= 10 ) = 1;

% get mean and SD for attached fils
AF1a = sum(FF1,2);
AF1b = mean(AF1a);
AF1c = std(AF1a);
% -------------------------------------------------------------------------
AF2a = sum(FF2,2);
AF2b = mean(AF2a);
AF2c = std(AF2a);
% -------------------------------------------------------------------------
AF3a = sum(FF3,2);
AF3b = mean(AF3a);
AF3c = std(AF3a);
% -------------------------------------------------------------------------
AF4a = sum(FF4,2);
AF4b = mean(AF4a);
AF4c = std(AF4a);
% -------------------------------------------------------------------------
AF5a = sum(FF5,2);
AF5b = mean(AF5a);
AF5c = std(AF5a);
% -------------------------------------------------------------------------
fa = [AF1b AF2b AF3b AF4b AF5b];
fs = [AF1c AF2c AF3c AF4c AF5c];
figure
errorbar(fa,fs,'k.','LineWidth',1.5,'MarkerSize',30,'CapSize',20)
xlim([0 6])
ylim([0 80])
xticks([1 2 3 4 5])
xticklabels({'0.1','1', '10', '100','1000'})
% yticks([10 20 30 40 50 60 70 80])
% yticklabels({10 20 30 40 50 60 70 80})
title({'Average Attached Filaments','vs. Substrate Stiffness'},'FontSize',20)
xlabel('kPa','FontSize',16)
ylabel({'Average Filament Count'},'FontSize',16)
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
print -dpdf attchFilsSpring.pdf
print -dpng attchFilsSpring.png