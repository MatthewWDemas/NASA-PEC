% Function to individualize features
% Function takes in array of features calculated from
% DataMatrixTimingFeatureExtraction_VerB.m and scales HP features based on
% their value during the first time instance.
% INPUT: DataM numerical array
% OUPUT: DataM_scaled numerical array

load('../DataExportMATLAB/DataMatrixSeta_ZScoreFullTime_M3_2016_03_24.mat');
% Get only MATB and non-Room Air trials


% Cycle through each participant
for i = 1:49
    % Select rows associated with participant i
    tmp = 
    % Cycle through each run type (non-hypoxic/hypoxic)
    for j = 2:3
        % Select rows associated with participant i and trial j
        % Save value of the first time instance for participant i, trial j
        % Change array block of HP features (43:78) according to the
        % methods listed below.
        switch method
            case 1
                
%         % Cycle through each time instance
%         for k = 1:5
%             
%         end
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