clear all
close all
clc

% load('../SharedDataExport/InputOutput_4_8_16.mat');
% load('../SharedDataExport/InputOutput_v4_5_2_16.mat');
load('../SharedDataExport/InputOutput_v5_5_3_16.mat');

Indicators = Data(:,[39,41,40,38,37,35,109:119]);

metaDataMATB = Indicators(:,7:17);

%RUN PVALUE CALCULATOR FIRST

resman13physiofeat = (pval_pa_hpa(:,13) < 0.001);
sum(resman13physiofeat)
0.0001 --  2
0.001  -- 12

model6 = 

%% Model 6
% ResMan Mean
model6_col = (pval_pa_hpa(:,13) < 0.001);
model6_feat = zscore(PhysioA(:, model6_col));
model6_resp_raw = zscore(HP_A(:, 13));
model6_resp = sign(zscore(HP_A(:, 13)));
model6_resp_nn = model6_resp > 0;
model6 = horzcat(model6_feat, model6_resp);
tabulate(model6_resp)

%% Model 7
% Tracking Mean
pa_hpa = horzcat(PhysioA, metaDataMATB, HP_A);
hp_deriv = [49 50 54 61 62 66 73 74 78];
hp_deriv = hp_deriv + 35;
[~, pval_pa_hpa] = ...
    FeatTTestMatrix(pa_hpa , ...
    1:77, 78:113, 1, hp_deriv);

model7_col = (pval_pa_hpa(:,25) < 0.000001);
find(model7_col)
model7_feat = zscore(PhysioA(:, model7_col));
model7_resp_raw = zscore(HP_A(:, 13));
model7_resp = sign(zscore(HP_A(:, 13)));
model7_resp_nn = model7_resp > 0;
model7 = horzcat(model7_feat, model7_resp);
tabulate(model7_resp)

% p-value cutoff and number of features
% 0.001   -- 16
% 0.0001  -- 15
% 0.00001 -- 14
% 0.00001 -- 14



%% Model 8 
pa_hpa = horzcat(PhysioA, metaDataMATB, HP_A);
pa_hpa(:,1:66) = pa_hpa(:,1:66) .* repmat(pa_hpa(:,77), 1, 66);
hp_deriv = [49 50 54 61 62 66 73 74 78];
hp_deriv = hp_deriv + 35;
[~, pval_pa_hpa] = ...
    FeatTTestMatrix(pa_hpa , ...
    1:66, 78:113, 1, hp_deriv);

figure;
image(pval_pa_hpa, 'CDataMapping', 'scaled')
caxis manual
caxis([0,0.05])
colormap('hot')
colorbar
% colormap(flipud(colormap))
title('P-values between Physio (A) and Detrended HP Features (A)')

removeNon12Offset = (Data(:,109) == 12);
model8ScaledFeatures = PhysioA(:,1:66) .* repmat(Indicators(:,17), 1, 66);

model8_col = (pval_pa_hpa(:,1) < 0.000001);
model8_feat = zscore(model8ScaledFeatures(removeNon12Offset, model8_col));
model8_resp_raw = zscore(HP_A(removeNon12Offset, 13));
model8_resp = sign(zscore(HP_A(removeNon12Offset, 13)));
model8_resp_nn = model8_resp > 0;
model8 = horzcat(model8_feat, model8_resp);
tabulate(model8_resp)
