

load('../DataExportMATLAB/mod_DataM_array_indiv_hp_feat_mthd_3.mat')
FeatArr_ml = DataM;

selected_feature = 3;
print_plots = 0;

switch selected_feature
    case 1 % Comm Trend Slope
        FeatArr_ml(:, 115) = sign(zscore(FeatArr(:,84)));
    case 2 % Resman Std Deviation
        % 17 + 78 = 95
%         FeatArr_ml(:, 115) = sign(zscore(FeatArr(:,95)));
        FeatArr_ml(:, 115) = sign(FeatArr(:,95));
        FeatArr_ml(any(FeatArr_ml(:,37) == 1,2), :) = [];
    case 3
        FeatArr_ml(:, 115) = sign(FeatArr(:,79));
        FeatArr_ml(FeatArr_ml(:, 115) == 0,115) = 1;
end

FeatArr_ml = FeatArr_ml(:, [1:34 36 42 115]);
FeatArr_ml(any(isinf(FeatArr_ml),2),:) = [];

FeatArr_nn_feat = FeatArr_ml(:, 1:(end-1));
FeatArr_nn_resp = FeatArr_ml(:, end);
FeatArr_nn_resp(FeatArr_nn_resp < 0) = 0;


switch print_plots
    case 1
        figure; histogram(FeatArr_nn_resp)
        figure; 
        histogram(FeatArr(:,95)); hold on;
        histogram(FeatArr(FeatArr(:,95) ~= 0,95))

        figure; histogram(zscore(FeatArr(:,95)))
end