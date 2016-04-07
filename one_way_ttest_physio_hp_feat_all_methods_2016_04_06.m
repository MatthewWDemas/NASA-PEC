% --------- FROM CASE 1 ------------------------------
load('../DataExportMATLAB/DataM_3_feat_version_v1_2016_04_04.mat')

DataM = DataM_3_feat_version;

%--------------- Raw Scores ------------------------------
DataM_noRA = DataM(DataM(:,38) ~= 1 & DataM(:,40) == 3, :);

% This is the list that specifies which raw features should not be z-scored
% and then split 
% raw features all derivative-based features except: (1) standard
% deviation (always positive), (2) Min Tracking (always negative), (3) Max
% Tracking (always positive).
hp_deriv = [49 50 54 61 62 66 73 74 78];

physio_raw = [1:34 36 42];
hp_raw = [43:78];
physio_y1diff = [79:114];
hp_y1diff = [115:150];
physio_lagdiff = [151:186];
hp_lagdiff = [187:222];

% Calculate t-test arrays between RAW physio features and each of the three
% HP feature scalings (raw, baseline difference, lagged difference).
[sig_raw_raw, pval_raw_raw] = ...
    FeatTTestMatrix(DataM_noRA, ...
    physio_raw, hp_raw, 1, hp_deriv);
[sig_raw_y1diff, pval_raw_y1diff] = ...
    FeatTTestMatrix(DataM_noRA(DataM_noRA(:,37) ~= 1,:), ...
    physio_raw, hp_y1diff, 0, []);
[sig_raw_lagdiff, pval_raw_lagdiff] = ...
    FeatTTestMatrix(DataM_noRA(DataM_noRA(:,37) ~= 1,:), ...
    physio_raw, hp_lagdiff, 0, []);

% Calculate t-test arrays between BASELINE difference physio features and 
% each of the three HP feature scalings (raw, baseline difference, lagged 
% difference).
[sig_y1dff_raw, pval_y1diff_raw] = ...
    FeatTTestMatrix(DataM_noRA(DataM_noRA(:,37) ~= 1,:), ...
    physio_y1diff, hp_raw, 1, hp_deriv);
[sig_y1dff_y1diff, pval_y1diff_y1diff] = ...
    FeatTTestMatrix(DataM_noRA(DataM_noRA(:,37) ~= 1,:), ...
    physio_y1diff, hp_y1diff, 0, []);
[sig_y1dff_lagdiff, pval_y1diff_lagdiff] = ...
    FeatTTestMatrix(DataM_noRA(DataM_noRA(:,37) ~= 1,:), ...
    physio_y1diff, hp_lagdiff, 0, []);

% Calculate t-test arrays between LAGGED difference physio features and 
% each of the three HP feature scalings (raw, baseline difference, lagged 
% difference).
[sig_lagdiff_raw, pval_lagdiff_raw] = ...    
    FeatTTestMatrix(DataM_noRA(DataM_noRA(:,37) ~= 1,:), ...
    physio_lagdiff, hp_raw, 1, hp_deriv);
[sig_lagdiff_y1diff, pval_lagdiff_y1diff] = ...
    FeatTTestMatrix(DataM_noRA(DataM_noRA(:,37) ~= 1,:), ...
    physio_lagdiff, hp_y1diff, 0, []);
[sig_lagdiff_lagdiff, pval_lagdiff_lagdiff] = ...
    FeatTTestMatrix(DataM_noRA(DataM_noRA(:,37) ~= 1,:), ...
    physio_lagdiff, hp_lagdiff, 0, []);

% Concatenate arrays
raw_physio = horzcat(pval_raw_raw, pval_raw_y1diff, pval_raw_lagdiff);
y1diff_physio = horzcat(pval_y1diff_raw, pval_y1diff_y1diff, pval_y1diff_lagdiff);
lagdiff_physio = horzcat(pval_lagdiff_raw, pval_lagdiff_y1diff, pval_lagdiff_lagdiff);
ttest_pval = vertcat(raw_physio, y1diff_physio, lagdiff_physio);

% Classify p-values according to level of significance
ttestpval_classes = ttest_pval;
ttestpval_classes(ttestpval_classes <= 0.0005) = 5;
ttestpval_classes(ttestpval_classes <= 0.005 & ...
    ttestpval_classes > 0.0005) = 4;
ttestpval_classes(ttestpval_classes <= 0.05 & ...
    ttestpval_classes > 0.005) = 3;
ttestpval_classes(ttestpval_classes <= 0.1 & ...
    ttestpval_classes > 0.05) = 2;
% ttestpval_classes(ttestpval_classes > 0.1 & ...
%     ttestpval_classes < 1.0 | isnan(ttestpval_classes)) = 0;
ttestpval_classes(ttestpval_classes > 0.1 & ...
    ttestpval_classes < 1.0) = 0;
ttestpval_classes(isnan(ttestpval_classes)) = 0.1;

% Set color map tailored for this data set.
matt_map = jet;
matt_map(1, :) = [1 1 1];
matt_map(2, :) = [1 0 1];

% Plot array as image
figure;
% b = bar3(ttestpval_classes)
b = image(ttestpval_classes, 'CDataMapping','scaled')
ylabel('Physio Features')
xlabel('HP Features')
title('Plot of classed p-value of t-tests')
% colormap('gray')
% colormap('jet')
colormap(matt_map)
% colormap(flipud(colormap))
%         caxis([0,5]);
colorbar
% set(b,'edgecolor', 'none');
% 
% for k = 1:length(b)
%     zdata = b(k).ZData;
%     b(k).CData = zdata;
%     b(k).FaceColor = 'interp';
% end

%  TEST CODE
% [sigrow, sigcol] = find(ttestpval_classes == 4 | ttestpval_classes == 5);
% matt_map_v1 = [0 0 0; 0.1 0.1 0.1; 0.5 0.5 0.5; 0.6 0.6 0.6; 0.7 0.7 0.7; 1.0 1.0 1.0];
% matt_map_v2 = [0 0 0; 0 0 0; 0.2 0.2 0.2; 0.4 0.4 0.4; 0.6 0.6 0.6; 1.0 1.0 1.0];
% matt_map_v3 = [0 0 0; 0 0 0; 0.1 0.1 0.1; 0.3 0.3 0.3; 0.5 0.5 0.5; 1.0 1.0 1.0];
% matt_map_v4 = [0 0 0; 0 0 0; 0.1 0.1 0.1; 0.3 0.3 0.3; 0.5 0.5 0.5; 1.0 1.0 1.0];