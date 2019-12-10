% get average motors
clear all
close all
zz = sqrt(120);
load ss1.mat
load ss2.mat
load ss3.mat
load ss4.mat
load ss5.mat
% get mean, std -----------------------------------------------------------
Mot1a = mean(S1);
Mot1b = std(S1);
Mot1c = mean(Mot1a);
Mot1d = mean(Mot1b)/zz;
%--------------------------------------------------------------------------
Mot2a = mean(S2);
Mot2b = std(S2);
Mot2c = mean(Mot2a);
Mot2d = mean(Mot2b)/zz;
%--------------------------------------------------------------------------
Mot3a = mean(S3);
Mot3b = std(S3);
Mot3c = mean(Mot3a);
Mot3d = mean(Mot3b)/zz;
%--------------------------------------------------------------------------
Mot4a = mean(S4);
Mot4b = std(S4);
Mot4c = mean(Mot4a);
Mot4d = mean(Mot4b)/zz;
%--------------------------------------------------------------------------
Mot5a = mean(S5);
Mot5b = std(S5);
Mot5c = mean(Mot5a);
Mot5d = mean(Mot5b)/zz;
%--------------------------------------------------------------------------
ma = [Mot1c Mot2c Mot3c Mot4c Mot5c];
ms = [Mot1d Mot2d Mot3d Mot4d Mot5d];
figure
errorbar(ma,ms,'k.','LineWidth',1.5,'MarkerSize',30,'CapSize',20)
xlim([0 6])
ylim([0 15])
xticks([1 2 3 4 5])
xticklabels({'0.1','1', '10', '100','1000'})
% yticks([10 20 30 40 50 60 70 80])
% yticklabels({10 20 30 40 50 60 70 80})
title({'Average Active Motors','vs. Substrate Stiffness'},'FontSize',20)
xlabel('kPa','FontSize',16)
ylabel({'Active Motors'},'FontSize',16)
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
print -dpdf motorsSpring.pdf
print -dpng motorsSpring.png
