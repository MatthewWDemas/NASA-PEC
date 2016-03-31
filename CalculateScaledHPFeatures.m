% Function to individualize features
% Function takes in array of features calculated from
% DataMatrixTimingFeatureExtraction_VerB.m and scales HP features based on
% their value during the first time instance.
% INPUT: DataM numerical array
% OUPUT: DataM_scaled numerical array

% Loading the most recent DataM array from saved .mat file
load('../DataExportMATLAB/DataMatrixSeta_ZScoreFullTime_M3_2016_03_24.mat');

% Get only MATB and non-Room Air trials call it FeatArr (FeatureArray)
FeatArr = DataM(DataM(:,38) ~= 1 & DataM(:,40) == 3,:);
% Script adds scaled versions of all HP features which will be appended to
% the FeatArr
FeatArr = horzcat(FeatArr, nan*ones(size(FeatArr(:, 43:78))));

% -------------------- Set Case Statements Here: -------------------------
% 
% Should use test mode (values set outside of loop)?
test_mode = 0;
% Should use which method of individual scaling (1, 2, 3)?
use_method = 3;

switch test_mode
    case 1
        i = 8;
        j = 3;
end
        
% Cycle through each participant
for i = 1:49
    % Cycle through each run type (non-hypoxic/hypoxic)
    for j = 2:3
        % Select rows associated with participant i and trial j
        tmp = FeatArr(FeatArr(:,39) == i & FeatArr(:,38) == j, 43:78);
        % Save values of the HP features in the first time instance (row 1)
        % for participant i, trial j by creating a matrix of the same size
        % as the original block, but constructed of the first row.
        tmp_1 = repmat(tmp(1,:), 5, 1);
        % Scale array block of HP features (43:78) according to the
        % methods listed below.
        switch use_method
            case 1
                B = tmp./tmp_1;
            case 2
                B = (tmp - tmp_1)./tmp_1;
            case 3
                B = tmp - tmp_1;
        end
        % Get rows that 
        TF = ismember(FeatArr(:,43:78),tmp, 'rows') ;
%         if sum(TF) > 5
%             return
%         end
        FeatArr(TF, 79:114) = B;
    end
end


% Method 1: Each trial's time instances are scaled by the first time
% instance.
% y(1) = y(1)/y(1) = 1;
% y(2) = y(2)/y(1);
% ...  = ...
% y(5) = y(5)/y(1);

% Method 2: Each trial's score is the percent difference from the first
% time instance
% y(1) = (y(1) - y(1)) / y(1) = 1;
% y(2) = (y(2) - y(1)) / y(1);
% ...  = ...
% y(5) = (y(5) - y(1)) / y(1);

% Method 3: Each trials score is the raw difference from the first time
% instance.
% y(1) = y(1) - y(1) = 1;
% y(2) = y(2) - y(1);
% ...  = ...
% y(5) = y(5) - y(1);

% TO DO:
% - Adapt code to work for Physio features also
% - Adapt code to work for time instances of lengths besides 2min intervals