clear all
close all
% before runing all the simulations, params.m needs to be updated
% to run the appropriate experiment. there are two experiments that
% can be run: increasing [Iso] and increasing substrate stiffness.
% for simplicity, line 40 is to change the substrate stiffness, and
% line 67. in line 40 of params.m, change the value in the 
% parenthesis "k_spring = k_spring_vals()" to 
% 1 for 0.1 kPa, 2 for 1 kPa, 3 for 10 kPa, 4 for 100 kPa, 
% and 5 or 1000 kPa.
% in line 67 or params.m, change the value in the paranthesis
% "WBratio = WB()" to 1 for veh, 2 for 0.1 nM, 3 for 1 nM, 
% 4 for 10 nM, 5 for 100 nM, and 6 for 1000 nM. 
% to save the data, change line 25 in this file, runsims.m to
% wb1, wb2, wb3, wb4, wb5, or wb6 to match the parameter for 
% [Iso] from params.m. similarly, to save the substrate stiffness
% data, change line 25 in this file, runsims.m to ks1, ks2, ks3,
% ks4, or ks5. it is important to keep the underscore in the 
% naming scheme.

% number of simulation is the number of filaments
numsims = 120;
for iii = 1:numsims
    forces
    save(sprintf('wb1_%03d',iii))
end