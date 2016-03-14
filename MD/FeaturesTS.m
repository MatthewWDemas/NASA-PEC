function [ts_mean, ts_med, ts_min, ts_max, ts_var, ts_trend,...
    ts_trend_slope] = FeaturesTS(x_values, y_values)
%FeaturesTS Given x and y values, the function returns a series of features
%of interest.
%   INPUT: x- (time stamps) and y-values (scores)
%   OUTPUT: Mean, Median, Min, Max, Variance, Trend Array, Trend Slope

    % Get mean
    ts_mean = mean(y_values);
    
    % Get median
    ts_med = median(y_values);
    
    % Get min
    ts_min = min(y_values);
    
    % Get max
    ts_max = max(y_values);
    
    % Get var
    ts_var = var(y_values);
    
    % Get trend
    [ts_trend, ts_trend_slope] =...
        GetTrend(x_values, y_values);

end

