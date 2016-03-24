function [ts_mean, ts_med, ts_min, ts_max, ts_std, ts_trend,...
    ts_trend_slope] = FeaturesTS(x_values, y_values)
%FeaturesTS Given x and y values, the function returns a series of features
%of interest.
%   INPUT: x- (time stamps) and y-values (scores)
%   OUTPUT: Mean, Median, Min, Max, Variance, Trend Array, Trend Slope

    % Get mean
    ts_mean = mean(y_values);
    
%     % Get median
%     ts_med = median(y_values);
%     
%     % Get min
%     ts_min = min(y_values);
%     
%     % Get max
%     ts_max = max(y_values);
%     
%     % Get std dev
%     ts_std = std(y_values);
    
    % Get trend
    [ts_trend, ts_trend_slope, ts_detrended_y] =...
        GetTrend(y_values, y_values);
%     GetTrend(x_values, y_values);

    % Get detrended + mean added median
    ts_med = median(ts_detrended_y);
    
    % Get detrended + mean added min
    ts_min = min(ts_detrended_y);
    
    % Get detrended + mean added max
    ts_max = max(ts_detrended_y);

    % Get detrended + mean added std dev
    ts_std = std(ts_detrended_y);
end

% TODO:
% Fix input to GetTrend to accept x-values (currently MATB input does not
%provide a timestamp on input (calculated with assumptions of continuity
%(no time steps missing).
