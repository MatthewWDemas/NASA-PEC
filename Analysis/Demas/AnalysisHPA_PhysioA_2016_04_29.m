%% Visualize Data After Major Changes

clear all 
close all 
clc 

load('./Data/DataMatrixSeta_ZScoreFullTime_M3_2016_04_29_v5.mat', 'DataM')

% Select only Session 3 (col 40) and no room air trials (col 38)
DataM_matb = DataM(DataM(:,40) == 3 & DataM(:,38) ~= 1, :);

%% Physio A and HP A

hp_deriv = [49 50 54 61 62 66 73 74 78];
% hp_deriv = hp_deriv + 67;
[sig_raw_raw, pval_raw_raw] = ...
    FeatTTestMatrix(DataM_matb, ...
    [1:34 36 42 79:108], 43:78, 1, hp_deriv);

figure;
image(pval_raw_raw, 'CDataMapping', 'scaled')
caxis manual
caxis([0,0.05])
colormap('hot')
colorbar
% colormap(flipud(colormap))
title('P-values between Physio (A) and Detrended HP Features (A)')




%% Physio A and HP A (no Time Instance 1)
%
% Select only Session 3 (col 40) and no room air trials (col 38) and no
% Time Instance 1
DataM_matb = DataM(DataM(:,40) == 3 & DataM(:,38) ~= 1 & DataM(:,37) ~= 1, :);

hp_deriv = [49 50 54 61 62 66 73 74 78];
% hp_deriv = hp_deriv + 67;
[sig_raw_raw, pval_raw_raw] = ...
    FeatTTestMatrix(DataM_matb, ...
    [1:34 36 42 79:108], 43:78, 1, hp_deriv);

figure;
image(pval_raw_raw, 'CDataMapping', 'scaled')
caxis manual
caxis([0,0.05])
colormap('hot')
colorbar
% colormap(flipud(colormap))
title('P-values between Physio (A) and Detrended HP Features (A) (No Time Instance 1)')

%% Prepare for Model Building
PhysioA = DataM_matb(:, [1:34 36 42 79:108]);
HP_A = DataM_matb(:, [43:78 109:114]);

% Tracking Mean
model1_col = [1 4 7 12 34 37 38 39 40 45 46 50 51 52 53 54 55 61 61 63 64];
model1_feat = zscore(PhysioA(:, model1_col));
model1_resp_raw = zscore(HP_A(:, 25));
model1_resp = sign(zscore(HP_A(:, 25)));
model1_resp_nn = model1_resp > 0;
model1 = horzcat(model1_feat, model1_resp);
tabulate(model1_resp)

%% Identify Performance Outliers
figure
gscatter(HP_A(:,25), HP_A(:,30), DataM_matb(:,39))
xlabel('Tracking Mean')
ylabel('Tracking Std Dev')
title('Color by Participant Number')
legend('off')
