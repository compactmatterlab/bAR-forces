clear all
close all
data = dir('ks1_*.mat');
numfiles = size(data,1);
nn = numfiles; % number of filaments
mydata = cell(1, numfiles);
% Load displacement data, states1-4, force
for k = 1:numfiles
  myfilename = sprintf('ks5_%03d.mat', k);
  load(myfilename);
  FF{k} = Force;
  AA{k} = attch;
  SS1{k} = state1;
  SS2{k} = state2;
  SS3{k} = state3;
  SS4{k} = state4;
end
FF5 = cell2mat(FF);
AA5 = cell2mat(AA);
SS1 = cell2mat(SS1);
SS2 = cell2mat(SS2);
SS3 = cell2mat(SS3);
SS4 = cell2mat(SS4);
S5 = SS1 + SS2 + SS3 + SS4;

save('ff5.mat','FF5')
save('aa5.mat','AA5')
save('ss5.mat','S5')

% FF = cell2mat(FF);
% figure
% imagesc(FF')
% figure
% plot(sum(FF,2))
