function [ FeatArr_indiv ] = IndividualizeFeatures( FeatArr, selected_features, diff_method, indiv_method )
%IndividualizeFeatures Function to individualize features.
% Function takes in array of features calculated from
% DataMatrixTimingFeatureExtraction_VerB.m and scales HP features based on
% their value during the first time instance.
% INPUT: 
%   DataM numerical array  
%   columns of interest 
%   difference version (1 = y1 difference; 2 = lagged difference)
%   scaling version (1 = ratio, 2 = percent change; 3 = subtraction)
% OUPUT: DataM_scaled numerical array

% -------------------- Set Case Statements Here: -------------------------
% 
% Should use test mode (values set outside of loop)?
% test_mode = 0;
% Should differences be taken only with the first time instance (case 1) or
% with the previous time instance (case 2)?
% diff_method = 2;
% Should use which method of individual scaling (1, 2, 3)?
% indiv_method = 3;
% Which version of the code should be used?
% version_num = 3;

% switch test_mode
%     case 1
%         i = 8;
%         j = 3;
% end
% 
% % Loading the most recent DataM array from saved .mat file
% load('../DataExportMATLAB/DataMatrixSeta_ZScoreFullTime_M3_2016_03_24.mat');

% Get only MATB and non-Room Air trials call it FeatArr (FeatureArray)
% FeatArr = DataM(DataM(:,38) ~= 1 & DataM(:,40) == 3,:);
[prev_num_rows, prev_num_cols] = size(FeatArr);

% Script adds scaled versions of all features which will be appended to
% the FeatArr
% selected_features = [43:78]; % only HP features
% Select all features (both Physio and HP)
% selected_features = [1:34 36 42:78];
[num_obs, num_feat] = size(FeatArr(:,...
    selected_features)) % should be 490 for MATB at 2min intervals and 72
FeatArr_indiv = horzcat(FeatArr, nan*zeros([num_obs num_feat]));

% Cycle through each participant
for i = 1:49
    % Cycle through each run type (non-hypoxic/hypoxic)
    for j = 2:3
        % Select rows containing participant #, trial type, time instance
        % and HP features associated with participant i and trial j
        tmp = FeatArr_indiv(FeatArr_indiv(:,39) == i & FeatArr_indiv(:,38) == j,...
            [39 38 37 selected_features]);
        % Select the Subject (39), Trial Type (38), and Time Instance (37)
        % cols to be used to find correct rows for replacement.
        tmp_subj = tmp(:,1:3);
        % Select the HP feature cols for calculation of scaled features.
        tmp_hp = tmp(:,4:end);
        switch diff_method
            case 1
                % Save values of the HP features in the first time instance (row 1)
                % for participant i, trial j by creating a matrix of the same size
                % as the original block, but constructed of the first row.
                tmp_1 = repmat(tmp_hp(1,:), 5, 1);
            case 2
                % Save values of the HP features in the previous time instance
                % for participant i, trial j by creating a matrix of the same size
                % as the original block, but constructed of a shifted
                % matrix.
                tmp_1 = vertcat(zeros(1,num_feat),tmp_hp(1:4,:));
        end
        % Scale array block of HP features (43:78) according to the
        % methods listed at end of this file.
        switch indiv_method
            case 1
                B = tmp_hp./tmp_1;
            case 2
                B = (tmp_hp - tmp_1)./tmp_1;
            case 3
                B = tmp_hp - tmp_1;
        end
        % Get rows that correspond to the Subject, Trial Type and Time
        % Instance.
        TF = ismember(FeatArr_indiv(:,[39 38 37]),tmp_subj, 'rows');
        % Check to ensure that only 5 rows have been selected 
        if sum(TF) > 5
            B = NaN;
            sum(TF)
        end
        % Insert the newly calculated scaled features (B) into the
        % predefined FeatArr block AFTER the unscaled features (i.e. into
        % cols 79 through the end).
        FeatArr_indiv(TF, (prev_num_cols+1):(prev_num_cols+num_feat)) = B;
    end
end


% -------- DESCRIPTION OF SCALING METHODS ---------------------------------
%
% Method 1: Each trial's time instances are scaled by the first time
% instance.
% y(1) = y(1)/y(1) = 1;
% y(2) = y(2)/y(1);
% ...  = ...
% y(5) = y(5)/y(1);
%
% Method 2: Each trial's score is the percent difference from the first
% time instance
% y(1) = (y(1) - y(1)) / y(1) = 1;
% y(2) = (y(2) - y(1)) / y(1);
% ...  = ...
% y(5) = (y(5) - y(1)) / y(1);
%
% Method 3: Each trials score is the raw difference from the first time
% instance.
% y(1) = y(1) - y(1) = 1;
% y(2) = y(2) - y(1);
% ...  = ...
% y(5) = y(5) - y(1);

% --------------------------- TO DO: -------------------------------------
%
% - Adapt code to work for Physio features also
% - Adapt code to work for time instances of lengths besides 2min intervals
% - Add check to make sure that Time Instances are in order (1,...,N)
% - Adapt code to work for differing numbers of features.

end

