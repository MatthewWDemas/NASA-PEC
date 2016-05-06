clear all
close all
clc

%% How different are files?
% File v2 was presented to NASA in April
load('./Data/DataMatrixSeta_ZScoreFullTime_M3_2016_04_08_v2.mat', 'DataM')
DataM_v2 = DataM;
% File v3 was corrected (NaN removal and unstacking error).
load('./Data/DataMatrixSeta_ZScoreFullTime_M3_2016_04_28_v3.mat', 'DataM')
DataM_v3 = DataM;

clear DataM


%% Visually
figure
subplot(1,2,1)
image(DataM_v2)%, 'CDataMapping','scaled')
colorbar
title('Data as Presented')
subplot(1,2,2)
image(DataM_v3)%, 'CDataMapping','scaled')
colorbar
title('Data after Corrections')


%% Chisq

