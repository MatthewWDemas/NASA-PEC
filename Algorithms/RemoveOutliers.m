function [ no_outliers, i] = RemoveOutliers( input_array )
%RemoveOutliers removes rows of an array that have a std deviation greater
%than 3.
%   z-scores  each column of an array and then removes rows with z-score
%   greater than +/- 3.
% Output: Array of z-scored values.

% tmp = zscore(input_array);
% tmp_len = length(find(abs(tmp) > 3));
% i = 0;
% 
% while tmp_len > 0
    tmp = zscore(input_array);
    [outlier_row, ~] = find(abs(tmp) > 3);
    tmp(outlier_row, :) = [];
    no_outliers = tmp;
%     tmp_len = length(find(abs(zscore(no_outliers)) > 3));
%     i = i + 1;
% end
end

