% load Data
% 
% Remove RA trials
% 
% Separate into:
%     1) Neural Net: array (HP features) and vector (responses)
%     2) Machine Learning: Array (HP Features + Responses)
%     
% Features (cols 43-78):
%     A) Scores (Comm, ResMan, Tracking)
%     B) Features (Mean, Median, Min, Max, Std Dev, Trend Slope)
%     C) Manipulations (Raw, 1st order derivative)
% 
% Responses:
%     A) Trial Hypoxic/Non-Hypoxic (col 38)
%     B) O2 Concentration (Hypoxic/Non-Hypoxic) (col 35)
%     C) O2 Saturation (Hypoxic Stable/Non-Hypoxic) (col 36)
% 
% INPUT:
%     DataM: array of features + responses
% 
% OUTPUT:
%     For Machine Learning Toolbox:
%         DataM_ml: Array of z-scored features + responses
%     For Neural Net Toolbox:
%         DataM_nn_feat: Array of HP features
%         DataM_nn_respA: Vector of Trial
%         DataM_nn_respB: Vector of O2 Concentrations (22% or 11%)
%         DataM_nn_respC: Vector of O2 Saturations (Stable High or Low)

% For Versions 1 and 2:
% load('../DataExportMATLAB/DataM_2016_03_23.mat')
% For Version 3+:
load('../DataExportMATLAB/DataMatrixSeta_ZScoreFullTime_M3_2016_03_24.mat');

% Remove RA trials and select columns of interest
% for V1 through V3
%DataM_noRA = zscore(DataM(DataM(:,38) ~= 1 & DataM(:,40) == 3, [35 36 38 43:78]));
% For V4 through:
DataM_noRA = zscore(DataM(DataM(:,38) ~= 1 & DataM(:,40) == 3, [35 36 38 43:78 1:34 42]));

% tmp = RemoveOutliers(DataM_noRA(:, [4:end]));
tmp = RemoveOutliers(DataM_noRA);
tmpA = RemoveOutliers(tmp);
tmpB = RemoveOutliers(tmpA);
tmpC = RemoveOutliers(tmpB);
tmpD = RemoveOutliers(tmpC);
tmpE = RemoveOutliers(tmpD);
tmpF = RemoveOutliers(tmpE);
tmpG = RemoveOutliers(tmpF);
tmpH = RemoveOutliers(tmpG);
tmpI = RemoveOutliers(tmpH);
tmpJ = RemoveOutliers(tmpI);
tmpK = RemoveOutliers(tmpJ);
tmpL = RemoveOutliers(tmpK);
tmpM = RemoveOutliers(tmpL);
tmpN = RemoveOutliers(tmpM);

tmpFinal = DataM_noRA;

DataM_nn_feat = tmpFinal(:, 4:end);

DataM_nn_respA = tmpFinal(:, 3);
% tmp1 = tmpM(:, 1);
% tmp2 = 15 * ones(size(tmp1));
% DataM_nn_respB = sign(tmp1 - tmp2);
DataM_nn_respB = sign(tmpFinal(:,1));
DataM_nn_respB(DataM_nn_respB < 0) = 0;

DataM_nn_respC = tmpFinal(:, 2);

DataM_ml = horzcat(...
    DataM_nn_respA,...
    DataM_nn_respB,...
    DataM_nn_respC,...
    DataM_nn_feat);

% 4-15: Comm
% 16-27: ResMan
% 28-39: Track
%
% col - start_col - 1 = Feature
% Feature #:
% 1: Mean
% 2: Median
% 3: Min
% 4: Max
% 5: Std Dev
% 6: Trend "Slope"


% V1: not z-scored, no outliers removed
% save('../DataExportMATLAB/MachineLearningData_v1_2016_03_23.mat',...
% V2: z-scored, outliers (std dev > 3) removed
% save('../DataExportMATLAB/MachineLearningData_v2_2016_03_23.mat',...
% V3: z-score, outliers removed (more carefully), newly calculated detrended
% features
save('../DataExportMATLAB/MachineLearningData_v3_2016_03_24.mat',...
    'DataM_nn_feat',...
    'DataM_nn_respA',...
    'DataM_nn_respB',...
    'DataM_nn_respC',...
    'DataM_ml');
% V4: z-scored, HP features + Physiological feature, no outliers removed.
save('../DataExportMATLAB/MachineLearningData_v4_2016_03_29.mat',...
    'DataM_nn_feat',...
    'DataM_nn_respA',...
    'DataM_nn_respB',...
    'DataM_nn_respC',...
    'DataM_ml');


