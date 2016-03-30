% Using RA data removed scores (outliers...?)
% Product 2 HP...Version 3 (HP Product 2 + Physio)
% DataM

load('../DataExportMATLAB/DataMatrixSeta_ZScoreFullTime_M3_2016_03_24.mat');

DataM_noRA = DataM(DataM(:,38) ~= 1 & DataM(:,40) == 3, :);

ttestpval = zeros(36);
ttestsignif = zeros(36);
hp_count = 0;

hp_deriv = [49:54 61:66 73:78];


% Go through the HP features
for hp_feat = 43:78
    hp_feat = 77; % Test Code
    hp_count = hp_count + 1;
    phys_count = 0;
% Go through the physio vars
    for phys_feat = [1:34 36 42]
        phys_feat = 1; % Test Code
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
b = bar3(ttestpval)
ylabel('Physio Features')
xlabel('HP Features')
colorbar

for k = 1:length(b)
    zdata = b(k).ZData;
    b(k).CData = zdata;
    b(k).FaceColor = 'interp';
end


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
