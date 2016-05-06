clear all 
close all 
clc 


%% How Many NaNs are there?
load('./Data/DataMatrixSeta_ZScoreFullTime_M3_2016_04_28_v3.mat', 'DataM')

DataM_matb = DataM(DataM(:,40) == 3 & DataM(:,38) ~= 1);
DataM_matb_hp = DataM_matb(:,43:78);
sum(isnan(DataM_matb_hp),1)
% sum(isnan(DataM_matb_hp),1)
% 
% ans =
% 
%   Columns 1 through 12
% 
%    136   136   136   136   136   136   136   136   136   136   136   136
% 
%   Columns 13 through 24
% 
%      0     0     0     0     0     0     0     0     0     0     0     0
% 
%   Columns 25 through 36
% 
%     50    50    50    50    50    50    50    50    50    50    50    50

136/49

%% At what time instances are the NaNs occuring?
figure;
image(isnan(DataM_matb_hp), 'CDataMapping','scaled')

maxtrack_times = DataM_matb(isnan(DataM_matb(:,70)),37);

unique(maxtrack_times)

tabulate(maxtrack_times)

meancomm_times = DataM_matb(isnan(DataM_matb(:,43)),37);

unique(meancomm_times)

tabulate(meancomm_times)
% tabulate(meancomm_times)
%   Value    Count   Percent
%       1       70     51.47%
%       2        0      0.00%
%       3        0      0.00%
%       4        0      0.00%
%       5       66     48.53%

%% How Many Missing Values are there?
load('./Data/DataMatrixSeta_ZScoreFullTime_M3_2016_04_29_v5.mat', 'DataM')

% Select only Session 3 (col 40) and no room air trials (col 38)
DataM_matb = DataM(DataM(:,40) == 3 & DataM(:,38) ~= 1, :);

tabulate(DataM_matb(:,109))
% tabulate(DataM_matb(:,109))
%   Value    Count   Percent
%       1        5      1.02%
%       2        0      0.00%
%       3        0      0.00%
%       4        0      0.00%
%       5        0      0.00%
%       6        0      0.00%
%       7        0      0.00%
%       8        0      0.00%
%       9        0      0.00%
%      10        0      0.00%
%      11        5      1.02%
%      12      480     97.96%

tabulate(DataM_matb(:,111))
tabulate(DataM_matb(:,113))

tabulate(DataM_matb(:,110))
% tabulate(DataM_matb(:,110))
%   Value    Count   Percent
%       0      354     72.24%
%       1       66     13.47%
%       3        2      0.41%
%       5       13      2.65%
%       6       16      3.27%
%       7        3      0.61%
%       9        1      0.20%
%      10       20      4.08%
%      11       12      2.45%
%      12        3      0.61%
tabulate(DataM_matb(:,112))
% tabulate(DataM_matb(:,112))
%   Value    Count   Percent
%       0      490    100.00%
tabulate(DataM_matb(:,114))
% tabulate(DataM_matb(:,114))
%   Value    Count   Percent
%       0      440     89.80%
%       1       50     10.20%