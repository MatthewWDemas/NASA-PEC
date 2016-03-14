% INPUT: 
%   Time window (10 s, 30 s, etc)
% OUPUT: 
%   Data Structure containing:
%       1) Subject
%       2) Run
%       3) Time Instance
%       4) Features
%
% METHOD:
%   1) go through subjects, runs
%   2) grab window from subject
%   3) compute the features** (mean, median, trend) x (score, score diff)
%   4) save features
%   5) move to next window and repeat
%   6) move to next subject, run and repeat
%
% TO DO:
%   1) Decide on list of features
%   2) Write code ;)
%   3) Make code work for both static and rolling windows

% Convert Run to Categorical
matb_ts.Run = categorical(matb_ts.Run);

% Remove Room Air Trials and get the last 10 minutes of data (minus the
% last point, which appears to drop suddenly for some participants)
matb_ts2 = matb_ts(matb_ts.Time >= 60 & matb_ts.Run ~= 'RA' & matb_ts.Time < 660, :);
matb_ts2.Subject = categorical(matb_ts2.Subject);

% Get list of subjects to filter by
subjects = unique(matb_ts2.Subject);

subj = 15;

feature_table = table(Subject, Run, TimeInstance, TrackMean, TrackMed,...
    TrackMin, TrackMax, TrackVar, TrackTrendSlope, ResManMean,...
    ResManMed,ResManMin, ResManMax, ResManVar, ResManTrendSlope, ...
    CommMean, CommMed, CommMin, CommMax, CommVar, CommTrendSlope);

for subj = 1:49
    % select a single subject
    matb_ts2_subj = matb_ts2(matb_ts2.Subject == subjects(subj),:);
    
    % Get SL trial from subject
    matb_subj_sl = matb_ts2_subj(matb_ts2_subj.Run == 'SL',:);
    
    % Look at smaller chunks in time
    % How many divisions? or How much time?
    % Specify Division Size (5)
    % http://uk.mathworks.com/matlabcentral/answers/74280-how-to-perform-a
    % -chunked-average-similar-to-a-rolling-average
    % Vectorized Version
    x_values = matb_subj_sl.Time;
    y_values = matb_subj_sl.Track;
    chunk_size = 5
    [lenx, ~] = size(x_values)
    % lenx/chunk_size
    numberOfRows = lenx/chunk_size;
    numberOfColumns = chunk_size;
    y_values_arr = reshape(y_values(:), [numberOfRows, numberOfColumns])
    
    for chunk = 1:numberOfColumns
        [track_mean, track_median, track_min, track_max, track_var,...
            track_trend, track_trend_slope] = FeaturesTS(...
            matb_subj_sl.Time, matb_subj_sl.Track);
        [resman_mean, resman_median, resman_min, resman_max, resman_var,...
            resman_trend, resman_trend_slope] = FeaturesTS(...
            matb_subj_sl.Time, matb_subj_sl.ResMan);
        [comm_mean, comm_median, comm_min, comm_max, comm_var,...
            comm_trend, comm_trend_slope] = FeaturesTS(...
            matb_subj_sl.Time, matb_subj_sl.Comm);
    tmp_struct = {'Subject', 'Run', 'TimeInstance', 'Mean', 'Median', ...
        'Min', 'Max', 'Var', 'TrendSlope', 'ResManMean', 'ResManMed',...
        'ResManMin', 'ResManMax', 'ResManVar', 'ResManTrendSlope',...
        'CommMean', 'CommMed', 'CommMin', 'CommMax', 'CommVar',...
        'CommTrendSlope';
        subjects(subj), 'SL', Chunk, track_mean, track_median, track_min,...
        track_max, track_var, track_trend_slope, resman_mean, ...
        resman_median, resman_min, resman_max, resman_var, ...
        resman_trend_slope, comm_mean, comm_median, comm_min, comm_max,...
        comm_var, comm_trend, comm_trend_slope};
    
    tmp_table = cell2table(tmp_struct(2:end,:));
    tmp_table.Properties.VariableNames = tmp_struct(1,:);
    feature_table = [feature_table, tmp_table];
%     % My Way
%     chunk_size = 5
%     [lenx, ~] = size(matb_subj_sl.Time)
%     lenx/chunk_size
% 
%     for chunk = 1:chunk_size
%         t_start = (chunk - 1) * 120 + 1;
%         t_end = chunk * 120;
%         [matb_subj_sl_mean, matb_subj_sl_median, matb_subj_sl_min,...
%         matb_subj_sl_max, matb_subj_sl_var, matb_subj_sl_trend,...
%         matb_subj_sl_trend_slope] = ...
%         FeaturesTS(matb_subj_sl.Time, matb_subj_sl.Track);
%     end
        
    
    % Get 15k trial from subject
    matb_subj_15k = matb_ts2_subj(matb_ts2_subj.Run == '15k',:);
    
    [matb_subj_sl_mean, matb_subj_sl_median, matb_subj_sl_min,...
        matb_subj_sl_max, matb_subj_sl_var, matb_subj_sl_trend,...
        matb_subj_sl_trend_slope] = ...
        FeaturesTS(matb_subj_sl.Time, matb_subj_sl.Track);
    
    [matb_subj_15k_mean, matb_subj_15k_median, matb_subj_15k_min,...
        matb_subj_15k_max, matb_subj_15k_var, matb_subj_15k_trend,...
        matb_subj_15k_trend_slope] =...
        FeaturesTS(matb_subj_15k.Time, matb_subj_15k.Track)

end

max(matb_ts2.Time) - min(matb_ts2.Time)

min(matb_subj_sl.Time)
max(matb_subj_sl.Time)