% max traction force
clear all
close all
zz = sqrt(120);

load ff1.mat
load ff2.mat
load ff3.mat
load ff4.mat
load ff5.mat
% get mean and std for max traction forces
FM1a = max(FF1);
Fm1b = mean(FM1a);
Fm1c = std(FM1a);
%--------------------------------------------------------------------------
FM2a = max(FF2);
Fm2b = mean(FM2a);
Fm2c = std(FM2a);
%--------------------------------------------------------------------------
FM3a = max(FF3);
Fm3b = mean(FM3a);
Fm3c = std(FM3a);
%--------------------------------------------------------------------------
FM4a = max(FF4);
Fm4b = mean(FM4a);
Fm4c = std(FM4a);
%--------------------------------------------------------------------------
FM5a = max(FF5);
Fm5b = mean(FM5a);
Fm5c = std(FM5a);
%--------------------------------------------------------------------------
fma = [Fm1b Fm2b Fm3b Fm4b Fm5b];
fms = [Fm1c Fm2c Fm3c Fm4c Fm5c];
figure
errorbar(fma,fms,'k.','LineWidth',1.5,'MarkerSize',30,'CapSize',20)
xlim([0 6])
% ylim([15 80])
xticks([1 2 3 4 5])
xticklabels({'0.1','1', '10', '100','1000'})
% yticks([10 20 30 40 50 60 70 80])
% yticklabels({10 20 30 40 50 60 70 80})
title({'Average Max Force','vs. Substrate Stiffness'},'FontSize',20)
xlabel('kPa','FontSize',16)
ylabel({'pN'},'FontSize',16)
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
print -dpdf maxForceSpring.pdf
print -dpng maxForceSpring.png