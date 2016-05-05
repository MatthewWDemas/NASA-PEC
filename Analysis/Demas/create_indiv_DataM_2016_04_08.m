clear all 
close all 
clc 

% load('./Data/DataMatrixSeta_ZScoreFullTime_M3_2016_04_29_v5.mat', 'DataM')
load('./Data/DataMatrixSeta_ZScoreFullTime_M3_2016_06_02_v6.mat', 'DataM')

DataM_matb_nora = DataM(DataM(:,40) == 3 & DataM(:, 38) ~= 1, :);

% FeatArr_indiv = DataM_matb_nora;
% 
% selected_features = [1:34 36 42:78 84:108];
% 
% i = 3;
% j = 2;
% 
% tmp = FeatArr_indiv(FeatArr_indiv(:,39) == i & FeatArr_indiv(:,38) == j,...
%             [39 38 37 selected_features]);

% Individualize Features y1 diff (DataB)
DataM_indivB = IndividualizeFeatures(DataM_matb_nora,...
    [1:34 36 42:78 85:108], 1, 3);

% Individualize Features lag diff (DataC)
DataM_indivC = IndividualizeFeatures(DataM_matb_nora,...
    [1:34 36 42:78 85:108], 2, 3);

% DataM_indiv = horzcat(DataM_indivB, DataM_indivC(:,109:end));
DataM_indiv = horzcat(DataM_indivB, DataM_indivC(:,120:end));

DataM_3_feat_version = DataM_indiv;

% save('./Data/DataMatrixSeta_ZScoreFullTime_M3_indiv_2016_04_08.mat', 'DataM_3_feat_version', 'DataM_indivB', 'DataM_indivC')
% save('../SharedDataExport/DataMatrixSeta_ZScoreFullTime_M3_indiv_2016_04_08.mat', 'DataM_3_feat_version')
% save('../SharedDataExport/DataMatrixSeta_ZScoreFullTime_M3_indiv_2016_05_02.mat', 'DataM_3_feat_version')
save('../SharedDataExport/DataMatrixSeta_ZScoreFullTime_M3_indiv_2016_05_03.mat', 'DataM_3_feat_version')