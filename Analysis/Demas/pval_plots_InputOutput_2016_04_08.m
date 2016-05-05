clear all
close all
clc

% load('../SharedDataExport/InputOutput_4_8_16.mat');
% load('../SharedDataExport/InputOutput_v4_5_2_16.mat');
load('../SharedDataExport/InputOutput_v5_5_3_16.mat');

%% Physio A and HP A

pa_hpa = horzcat(PhysioA, HP_A);
hp_deriv = [49 50 54 61 62 66 73 74 78];
hp_deriv = hp_deriv + 67;
[~, pval_pa_hpa] = ...
    FeatTTestMatrix(pa_hpa , ...
    1:66, 67:102, 1, hp_deriv);

figure;
image(pval_pa_hpa, 'CDataMapping', 'scaled')
caxis manual
caxis([0,0.05])
colormap('hot')
colorbar
% colormap(flipud(colormap))
title('P-values between Physio (A) and Detrended HP Features (A)')

%% Physio A and HP B

pa_hpb = horzcat(PhysioA, HP_B);
% hp_deriv = [49 50 54 61 62 66 73 74 78];
hp_deriv = hp_deriv + 67;
[~, pval_pa_hpb] = ...
    FeatTTestMatrix(pa_hpb , ...
    1:66, 67:102, 0, []);

figure;
image(pval_pa_hpb, 'CDataMapping', 'scaled')
caxis manual
caxis([0,0.05])
colormap('hot')
colorbar
% colormap(flipud(colormap))
title('P-values between Physio (A) and Detrended HP Features (B)')

%% Physio A and HP C

pa_hpc = horzcat(PhysioA, HP_C);
% hp_deriv = [49 50 54 61 62 66 73 74 78];
hp_deriv = hp_deriv + 67;
[~, pval_pa_hpc] = ...
    FeatTTestMatrix(pa_hpc , ...
    1:66, 67:102, 0, []);

figure;
image(pval_pa_hpc, 'CDataMapping', 'scaled')
caxis manual
caxis([0,0.05])
colormap('hot')
colorbar
% colormap(flipud(colormap))
title('P-values between Physio (A) and Detrended HP Features (C)')

%% Physio B and HP A

pb_hpa = horzcat(PhysioB, HP_A);
hp_deriv = [49 50 54 61 62 66 73 74 78];
hp_deriv = hp_deriv + 67;
[~, pval_pb_hpa] = ...
    FeatTTestMatrix(pb_hpa , ...
    1:66, 67:102, 1, hp_deriv);

figure;
image(pval_pb_hpa, 'CDataMapping', 'scaled')
caxis manual
caxis([0,0.05])
colormap('hot')
colorbar
% colormap(flipud(colormap))
title('P-values between Physio (B) and Detrended HP Features (A)')

%% Physio B and HP B

pb_hpb = horzcat(PhysioB, HP_B);
hp_deriv = [49 50 54 61 62 66 73 74 78];
hp_deriv = hp_deriv + 67;
[~, pval_pb_hpb] = ...
    FeatTTestMatrix(pb_hpb , ...
    1:66, 67:102, 0, []);

figure;
image(pval_pb_hpb, 'CDataMapping', 'scaled')
caxis manual
caxis([0,0.05])
colormap('hot')
colorbar
% colormap(flipud(colormap))
title('P-values between Physio (B) and Detrended HP Features (B)')

%% Physio B and HP C

pb_hpc = horzcat(PhysioB, HP_C);
hp_deriv = [49 50 54 61 62 66 73 74 78];
hp_deriv = hp_deriv + 67;
[~, pval_pb_hpc] = ...
    FeatTTestMatrix(pb_hpc , ...
    1:66, 67:102, 0, []);

figure;
image(pval_pb_hpc, 'CDataMapping', 'scaled')
caxis manual
caxis([0,0.05])
colormap('hot')
colorbar
% colormap(flipud(colormap))
title('P-values between Physio (B) and Detrended HP Features (C)')

%% Physio C and HP A

pc_hpa = horzcat(PhysioC, HP_A);
hp_deriv = [49 50 54 61 62 66 73 74 78];
hp_deriv = hp_deriv + 67;
[~, pval_pc_hpa] = ...
    FeatTTestMatrix(pc_hpa , ...
    1:66, 67:102, 1, hp_deriv);

figure;
image(pval_pc_hpa, 'CDataMapping', 'scaled')
caxis manual
caxis([0,0.05])
colormap('hot')
colorbar
% colormap(flipud(colormap))
title('P-values between Physio (C) and Detrended HP Features (A)')

%% Physio C and HP B

pc_hpb = horzcat(PhysioC, HP_B);
hp_deriv = [49 50 54 61 62 66 73 74 78];
hp_deriv = hp_deriv + 67;
[~, pval_pc_hpb] = ...
    FeatTTestMatrix(pc_hpb , ...
    1:66, 67:102, 0, []);

figure;
image(pval_pc_hpb, 'CDataMapping', 'scaled')
caxis manual
caxis([0,0.05])
colormap('hot')
colorbar
% colormap(flipud(colormap))
title('P-values between Physio (C) and Detrended HP Features (B)')

%% Physio C and HP C

pc_hpc = horzcat(PhysioC, HP_C);
hp_deriv = [49 50 54 61 62 66 73 74 78];
hp_deriv = hp_deriv + 67;
[~, pval_pc_hpc] = ...
    FeatTTestMatrix(pc_hpc , ...
    1:66, 67:102, 0, []);

figure;
image(pval_pc_hpc, 'CDataMapping', 'scaled')
caxis manual
caxis([0,0.05])
colormap('hot')
colorbar
% colormap(flipud(colormap))
title('P-values between Physio (C) and Detrended HP Features (C)')




%% Generate a Large Plot Containing All Subplots

pa_hpa = horzcat(PhysioA, HP_A);
hp_deriv = [49 50 54 61 62 66 73 74 78];
hp_deriv = hp_deriv + 67;
[sig_raw_raw, pval_raw_raw] = ...
    FeatTTestMatrix(pa_hpa , ...
    1:66, 67:102, 1, hp_deriv);

figure;
subplot(3,3,1)
image(pval_raw_raw, 'CDataMapping', 'scaled')
caxis manual
caxis([0,0.05])
colormap('hot')
colorbar
% colormap(flipud(colormap))
title('P-values between Physio (A) and Detrended HP Features (A)')

subplot(3,3,2)
image(pval_pa_hpb, 'CDataMapping', 'scaled')
caxis manual
caxis([0,0.05])
colormap('hot')
colorbar
% colormap(flipud(colormap))
title('P-values between Physio (A) and Detrended HP Features (B)')

subplot(3,3,3)
image(pval_pa_hpc, 'CDataMapping', 'scaled')
caxis manual
caxis([0,0.05])
colormap('hot')
colorbar
% colormap(flipud(colormap))
title('P-values between Physio (A) and Detrended HP Features (C)')

subplot(3,3,4)
image(pval_pb_hpa, 'CDataMapping', 'scaled')
caxis manual
caxis([0,0.05])
colormap('hot')
colorbar
% colormap(flipud(colormap))
title('P-values between Physio (B) and Detrended HP Features (A)')

subplot(3,3,5)
image(pval_pb_hpb, 'CDataMapping', 'scaled')
caxis manual
caxis([0,0.05])
colormap('hot')
colorbar
% colormap(flipud(colormap))
title('P-values between Physio (B) and Detrended HP Features (B)')

subplot(3,3,6)
image(pval_pb_hpc, 'CDataMapping', 'scaled')
caxis manual
caxis([0,0.05])
colormap('hot')
colorbar
% colormap(flipud(colormap))
title('P-values between Physio (B) and Detrended HP Features (C)')

subplot(3,3,7)
image(pval_pc_hpa, 'CDataMapping', 'scaled')
caxis manual
caxis([0,0.05])
colormap('hot')
colorbar
% colormap(flipud(colormap))
title('P-values between Physio (C) and Detrended HP Features (A)')

subplot(3,3,8)
image(pval_pc_hpb, 'CDataMapping', 'scaled')
caxis manual
caxis([0,0.05])
colormap('hot')
colorbar
% colormap(flipud(colormap))
title('P-values between Physio (C) and Detrended HP Features (B)')


subplot(3,3,9)
image(pval_pc_hpc, 'CDataMapping', 'scaled')
caxis manual
caxis([0,0.05])
colormap('hot')
colorbar
% colormap(flipud(colormap))
title('P-values between Physio (C) and Detrended HP Features (C)')