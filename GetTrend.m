function [trend, trend_slope, detrended_values] = GetTrend(x_values, ...
    y_values, plot_vals)
%GetTrend returns the trend, trend_slop, and detrended values.
% INPUT: t, y(t), and binary value whether to plot y(t) and TREND(y(t)).
% OUTPUT: 
%   - trend: trend line at each input time step.
%   - trend_slope: the difference in starting and ending points of trend
%   - detrended_values: y(t) with trend removed

    if nargin < 3
        plot_vals = 0;
    end
    detrended_values = detrend(y_values);
    trend = y_values - detrended_values;
%     trend_slope = (trend(end) - trend(1))/(x_values(end) - x_values(1));
    trend_slope = (trend(end) - trend(1));
    
    if plot_vals == 1
        figure;
        plot(x_values, y_values)
        hold on
        %plot(matb_subj_sl.Time, trend, ':r')
        plot(x_values, trend, ':r')
        plot(x_values, detrended_values, 'm')
        plot(x_values, zeros(size(x_values)), ':k')
        legend('Original Tracking Score', 'Trend', 'Detrended Tracking Score',...
            'Mean of Detrended Data', 'Location', 'best')
        xlabel('Time (in seconds)')
        ylabel('Tracking Score (unit-less)')
    end
end

% TODO:
%  - Return slope of trend instead of difference in y-values.