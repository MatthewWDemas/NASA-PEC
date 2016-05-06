clear all 
close all 
clc 

load('../../DataAnalysis_Matt/NASA-PEC-MATLAB/PerformanceCFTMATB.mat', 'matb_ts_pec')
matb_times = matb_ts_pec(matb_ts_pec.TypeofRun == 2 |  matb_ts_pec.TypeofRun == 3, {'Time'});

matb_times = table2array(matb_times); % length 12936

sum(rem(matb_times,1) ~= 0) % 1049 affected (8 percent)

figure
image(Perform(

MATB_Comm_NH = Perform{1,3}{1,2}{1,1}(133:end,:);
sum(~isnan(MATB_Comm_NH), 1)

figure
image(MATB_Comm_NH, 'CDataMapping','scaled')
colorbar
title('Number of Not NaNs for each subject for non-hypoxic Comm trials')


MATB_Comm_H = Perform{1,3}{1,3}{1,1}(133:end,:);
sum(~isnan(MATB_Comm_H), 1)

figure
image(MATB_Comm_H, 'CDataMapping','scaled')
colorbar
title('Number of Not NaNs for each subject for hypoxic Comm trials')

MATB_ResMan_NH = Perform{1,3}{1,2}{1,2}(133:end,:);
sum(~isnan(MATB_ResMan_NH), 1)

figure
image(MATB_ResMan_NH, 'CDataMapping','scaled')
colorbar
title('Number of Not NaNs for each subject for hypoxic ResMan trials')

