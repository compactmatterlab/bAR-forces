% README 
% The files in this folder recreate the computational results in the 
% paper. The files are:
% runsims.m                       % runs and save all runs for one experimental
%                                 % condition
% params.m                        % paramater file for forces.m
% forces.m                        % main file that returns forces
% makeForceAttchMotorMatrices.m   % make relevant matrices
% makeForcePlots.m                % make normalized traction and kymograph
% makeMotorsPlots.m               % make active motors plot
% makeMaxTractionPlots.m          % make max traction plot
% makeAttchFils.m                 % make number of attached filaments plot
% makeAttchTimes.m                % make average attachment times plot
% 
% To run new experiments to recreate the figures:
%     1. Change the params.m file to reflect spring or [Iso]. 
%     2. Change the name in runsims.m so that each run for a particular
%        experiment has the same prefix. More information is in runsims.m
%     3. Repeat this process for all [Iso] and all stiffness values. The 
%        result should be 6 [Iso] runs of 120 files each, and 5 stiffness 
%        runs with 120 files each.
%     4. Run makeForceAttchMotorMatrices.m for each experimental group.
%     5. To desired plot, run the appropriate file.