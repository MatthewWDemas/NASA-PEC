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

load('../DataExportMATLAB/DataM_2016_03_23.mat')

% Remove RA trials
DataM_noRA = zscore(DataM(DataM(:,38) ~= 1 & DataM(:,40) == 3, [35 36 38 43:78]));

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

DataM_nn_feat = tmpM(:, 4:end);

DataM_nn_respA = tmpM(:, 3);
% tmp1 = tmpM(:, 1);
% tmp2 = 15 * ones(size(tmp1));
% DataM_nn_respB = sign(tmp1 - tmp2);
DataM_nn_respB = sign(tmpM(:,1));
DataM_nn_respC = tmpM(:, 2);

DataM_ml = horzcat(...
    DataM_nn_respA,...
    DataM_nn_respB,...
    DataM_nn_respC,...
    DataM_nn_feat);

% not z-scored, no outliers removed
%save('../DataExportMATLAB/MachineLearningData_v1_2016_03_23.mat',...
% z-scored, outliers (std dev > 3) removed
save('../DataExportMATLAB/MachineLearningData_v2_2016_03_23.mat',...
    'DataM_nn_feat',...
    'DataM_nn_respA',...
    'DataM_nn_respB',...
    'DataM_nn_respC',...
    'DataM_ml');



