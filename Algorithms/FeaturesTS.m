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
    [ts_trend, ts_trend_slope, y_values_detrended] =...
        GetTrend(y_values, y_values);
%     GetTrend(x_values, y_values);

    % Get detrended median
    ts_med = median(y_values_detrended);
    
    % Get detrended min
    ts_min = min(y_values_detrended);
    
    % Get detrended max
    ts_max = max(y_values_detrended);
    
    % Get detrended std dev
    ts_std = std(y_values_detrended);
end

