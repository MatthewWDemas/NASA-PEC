% Using RA data removed scores (outliers...?)
% Product 2 HP...Version 3 (HP Product 2 + Physio)
% DataM

load('../DataExportMATLAB/DataMatrixSeta_ZScoreFullTime_M3_2016_03_24.mat');

DataM_noRA = DataM(DataM(:,38) ~= 1 & DataM(:,40) == 3, :);

ttestpval = zeros(36);
ttestsignif = zeros(36);
hp_count = 0;

% Selection for all derivative-based features except: (1) standard 
% deviation (always positive), (2) Min Tracking (always negative), (3) Max
% Tracking (always positive).
% Comm (y)    43-48
% Comm (y')   49-54
% ResMan (y)  55-60
% ResMan (y') 61-66
% Track (y)   67-72
% Track (y')  73-78

hp_deriv = [49 50 54 61 62 66 73 74 78]; 

% Go through the HP features
for hp_feat = 43:78
%     hp_feat = 75; % Test Code
    hp_count = hp_count + 1;
    phys_count = 0;
% Go through the physio vars
    for phys_feat = [1:34 36 42]
%         phys_feat = 1; % Test Code
        phys_count = phys_count + 1;
        tmp = DataM_noRA(:, [phys_feat hp_feat]);
        tmp(any(isnan(tmp),2),:) = [];
        % Check if feature is in list of derivatives
        if any(abs(hp_feat - hp_deriv) < 1e-10)
            tmpz = tmp;
        else
            tmpz = zscore(tmp);
        end
        tmpz(:,3) = sign(tmpz(:,2));
        tmpAbove = tmpz(tmpz(:,3) > 0,:);
        tmpBelow = tmpz(tmpz(:,3) <= 0,:);
        [ttestsignif(phys_count, hp_count), ...
            ttestpval(phys_count, hp_count)] = ...
            ttest2(tmpAbove(:,1), tmpBelow(:,1));
    end
end

% V1: Derivatives z-scored, Ordered as in Machine Learning output dataset.
% save('../DataExportMATLAB/PreliminaryTTestResults_rows_physio_cols_hp_feat.mat',...
% V2: Derivatives not z-scored, features ordered as in FeatureExtractorFull
save('../DataExportMATLAB/PreliminaryTTestResults_rows_physio_cols_hp_feat_v2.mat',...
    'ttestsignif',...
    'ttestpval');

figure
b = bar3(1 - ttestpval)
ylabel('Physio Features')
xlabel('HP Features')
title('Plot of 1 - p-Value of t-Tests')
colorbar

for k = 1:length(b)
    zdata = b(k).ZData;
    b(k).CData = zdata;
    b(k).FaceColor = 'interp';
end

% Hard to tell which are below 0.05
% Convert into three classes (1 >> less than 0.05, 2 >> between 0.05 and 1,
% 3 greater than 1.
ttestpval_classes = ttestpval;
ttestpval_classes(ttestpval_classes <= 0.05) = 3;
ttestpval_classes(ttestpval_classes <= 0.1 & ...
    ttestpval_classes > 0.05) = 2;
ttestpval_classes(ttestpval_classes > 0.1 & ...
    ttestpval_classes < 1.0 | isnan(ttestpval_classes)) = 0;
ttestpval_classes_total = sum(ttestpval_classes);
ttestpval_classes = vertcat(ttestpval_classes, ttestpval_classes_total);

figure
b = bar3(ttestpval_classes)
ylabel('Physio Features')
xlabel('HP Features')
title('Plot of Classed p-Values of t-Tests')
colorbar

for k = 1:length(b)
    zdata = b(k).ZData;
    b(k).CData = zdata;
    b(k).FaceColor = 'interp';
end

[xcol, ycol] = find(ttestpval_classes == 3);
signif_pairings = horzcat(xcol + 42, ycol);

figure
b = bar3(ttestsignif)
ylabel('Physio Features')
xlabel('HP Features')
colorbar

for k = 1:length(b)
    zdata = b(k).ZData;
    b(k).CData = zdata;
    b(k).FaceColor = 'interp';
end

% -------------------- TEST CODE ---------------------
ttestsignif(any(isnan(ttestsignif),2),:) = [];
sum(ttestsignif)
figure;
plot(sum(ttestsignif.'))
title('Physio Feature with Number of Positive T-Tests')
% Get z-score
% Get signed value
% Split data array into 2 (based on pos/neg HP signed z-scored features)
% Conduct t-test
% store p-value in matrix (below diagonal missing)
