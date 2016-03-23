% load Data
% 
% Remove RA trials
% 
% Separate into:
%     1) Neural Net: array (HP features) and vector (responses)
%     2) Machine Learning: Array (HP Features + Responses)
%     
% Features:
%     A) Scores (Comm, ResMan, Tracking)
%     B) Features (Mean, Median, Min, Max, Std Dev, Trend Slope)
%     C) Manipulations (Raw, 1st order derivative)
% 
% Responses:
%     A) Trial Hypoxic/Non-Hypoxic
%     B) O2 Concentration (Hypoxic/Non-Hypoxic)
%     C) O2 Saturation (Hypoxic Stable/Non-Hypoxic)
% 
% INPUT:
%     DataM: array of features + responses
% 
% OUTPUT:
%     For Machine Learning Toolbox:
%         DataM_ml: Array of features + responses
%     For Neural Net Toolbox:
%         DataM_nn_feat: Array of HP features
%         DataM_nn_respA: Vector of Trial
%         DataM_nn_respB: Vector of O2 Concentrations (22% or 11%)
%         DataM_nn_respC: Vector of O2 Saturations (Stable High or Low)

load('../DataExportMATLAB/DataM_2016_03_23.mat')

