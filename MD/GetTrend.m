function [trend, trend_slope] = GetTrend(x_values, y_values, plot_vals)
%GetTrend
% Simple function that takes in a list of values, detrends the values, and
% then returns the trend.
    if nargin < 3
        plot_vals = 0
    end
    detrended_values = detrend(y_values);
    trend = y_values - detrended_values;
%     trend_slope = (trend(2) - trend(1))/(x_values(2) - x_values(1));
    trend_slope = (trend(2) - trend(1));
    
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

