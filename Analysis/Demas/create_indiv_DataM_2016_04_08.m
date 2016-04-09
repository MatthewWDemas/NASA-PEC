DataM_matb_nora = DataM(DataM(:,40) == 3 & DataM(:, 38) ~= 1, :);

% FeatArr_indiv = DataM_matb_nora;
% 
% selected_features = [1:34 36 42:78 84:108];
% 
% i = 3;
% j = 2;
% 
% tmp = FeatArr_indiv(FeatArr_indiv(:,39) == i & FeatArr_indiv(:,38) == j,...
%             [39 38 37 selected_features]);

% Individualize Features y1 diff (DataB)
DataM_indivB = IndividualizeFeatures(DataM_matb_nora, [1:34 36 42:78 85:108], 1, 3);

figure;
subplot(1,2,1)
image(DataM_indivB)
title('Method B')
subplot(1,2,2)
image(DataM_indivC)
title('Method C')

figure;
histogram(DataM_indivC(:,205))

% Individualize Features lag diff (DataC)
DataM_indivC = IndividualizeFeatures(DataM_matb_nora, [1:34 36 42:78 85:108], 2, 3);

DataM_indiv = horzcat(DataM_indivB, DataM_indivC(:,109:end));

DataM_3_feat_version = DataM_indiv;

save('./Data/DataMatrixSeta_ZScoreFullTime_M3_indiv_2016_04_08.mat', 'DataM_3_feat_version', 'DataM_indivB', 'DataM_indivC')
save('../SharedDataExport/DataMatrixSeta_ZScoreFullTime_M3_indiv_2016_04_08.mat', 'DataM_3_feat_version')