% get lifetimes
clear all
load aa1.mat
load aa2.mat
load aa3.mat
load aa4.mat
load aa5.mat
zz = sqrt(120);

for ii = 1:120
    v = [AA1(:,ii)];
    v2 = zeros(size(v)); % Initialize vector of same length.
    props = regionprops(logical(v), 'Area', 'PixelIdxList');
    for k = 1 : length(props)
        v2(props(k).PixelIdxList(1)) = props(k).Area;
        v3 = v2;
        [rows, columns, values] = find(v3);
        avs{ii} = mean(values);
        asd{ii} = std(values);
        v4{ii} = v2;
    end
end
avs1a = cell2mat(avs);
avs1b = mean(avs1a);
asd1a = cell2mat(asd);
asd1b = mean(asd1a)/zz;

for ii = 1:120
    v = [AA2(:,ii)];
    v2 = zeros(size(v)); % Initialize vector of same length.
    props = regionprops(logical(v), 'Area', 'PixelIdxList');
    for k = 1 : length(props)
        v2(props(k).PixelIdxList(1)) = props(k).Area;
        v3 = v2;
        [rows, columns, values] = find(v3);
        avs{ii} = mean(values);
        asd{ii} = std(values);
        v4{ii} = v2;
    end
end
avs2a = cell2mat(avs);
avs2b = mean(avs2a);
asd2a = cell2mat(asd);
asd2b = mean(asd2a)/zz;

for ii = 1:120
    v = [AA3(:,ii)];
    v2 = zeros(size(v)); % Initialize vector of same length.
    props = regionprops(logical(v), 'Area', 'PixelIdxList');
    for k = 1 : length(props)
        v2(props(k).PixelIdxList(1)) = props(k).Area;
        v3 = v2;
        [rows, columns, values] = find(v3);
        avs{ii} = mean(values);
        asd{ii} = std(values);
        v4{ii} = v2;
    end
end
avs3a = cell2mat(avs);
avs3b = mean(avs3a);
asd3a = cell2mat(asd);
asd3b = mean(asd3a)/zz;

for ii = 1:120
    v = [AA4(:,ii)];
    v2 = zeros(size(v)); % Initialize vector of same length.
    props = regionprops(logical(v), 'Area', 'PixelIdxList');
    for k = 1 : length(props)
        v2(props(k).PixelIdxList(1)) = props(k).Area;
        v3 = v2;
        [rows, columns, values] = find(v3);
        avs{ii} = mean(values);
        asd{ii} = std(values);
        v4{ii} = v2;
    end
end
avs4a = cell2mat(avs);
avs4b = mean(avs4a);
asd4a = cell2mat(asd);
asd4b = mean(asd4a)/zz;

for ii = 1:120
    v = [AA5(:,ii)];
    v2 = zeros(size(v)); % Initialize vector of same length.
    props = regionprops(logical(v), 'Area', 'PixelIdxList');
    for k = 1 : length(props)
        v2(props(k).PixelIdxList(1)) = props(k).Area;
        v3 = v2;
        [rows, columns, values] = find(v3);
        avs{ii} = mean(values);
        asd{ii} = std(values);
        v4{ii} = v2;
    end
end
avs5a = cell2mat(avs);
avs5b = mean(avs5a);
asd5a = cell2mat(asd);
asd5b = mean(asd5a)/zz;

avs = [avs1b avs2b avs3b avs4b avs5b];
std = [asd1b asd2b asd3b asd4b asd5b];
figure
errorbar(avs,std,'k.','LineWidth',1.5,'MarkerSize',30,'CapSize',20)
xlim([0 6])
ylim([15 100])
xticks([1 2 3 4 5])
xticklabels({'0.1','1', '10', '100','1000'})
% yticks([10 20 30 40 50 60 70 80])
% yticklabels({10 20 30 40 50 60 70 80})
title({'Average Attached Filaments','vs. Substrate Stiffness'},'FontSize',20)
xlabel('kPa','FontSize',16)
ylabel({'Average Bond Lifetime (ms)'},'FontSize',16)
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
print -dpdf lifeTimeSpring.pdf
print -dpng lifeTimeSpring.png