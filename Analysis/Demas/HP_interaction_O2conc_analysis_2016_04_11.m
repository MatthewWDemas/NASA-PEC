% Script to Calculate t-tests of HP feature interactions split on 
% O2 Concentration.

load('./Data/InputOutput_v3_4_11_16.mat')

% Define Interactions
% Between scores of each sub-task only (Comm, ResMan, Tracking)
% Calculate Interactions

% Split Variables based on O2 Conc value
low_o2 = (Data(:,35) < 16);
high_o2 = (Data(:,35) >= 16);

zHP_B = zscore(HP_B);

%% HPA Interactions
% 2 Significant t-tests, 19 and 7 (Mean ResMan' and Mean Comm') and 30 and
% 14 (Tracking Trend Slope and Median ResMan).

% Put Interactions into a new array
hp_a_int = nan*ones(length(HP_A(:,1)), 630);
pval_arr = nan*ones(36);
k = 0;
for i = 1:36
    for j = i:36
        k = k + 1;
        % Calculate Interaction Term
        hp_a_int(:, k) = HP_A(:,i) .* HP_A(:,j);
        % Conduct t-test -- Save p-value result
        [~, pval_arr(i,j)] = ttest2(hp_a_int(low_o2,k),...
        hp_a_int(high_o2,k));
    end
end

figure;
image(pval_vec, 'CDataMapping', 'scaled')
caxis manual
caxis([0,0.05])
colormap('hot')
colorbar
% colormap(flipud(colormap))
title('P-values between HP_A Interactions')


%% HPB Interactions
% There are too many to write here. 

% Put Interactions into a new array
hp_b_int = nan*ones(length(HP_B(:,1)), 630);
hp_b_tens = nan*ones(length(HP_B(:,1)),36,36);
pval_hpb_arr = nan*ones(36);
k = 0;
figure;
for i = 1:36
    for j = i:36
        k = k + 1;
        % Calculate Interaction Term
        hp_b_int(:, k) = HP_B(:,i) .* HP_B(:,j);
        hp_b_tens(:,i,j) = hp_b_int(:, k);
        % Conduct t-test -- Save p-value result
        [~, pval_hpb_arr(i,j)] = ttest2(hp_b_int(low_o2,k),...
            hp_b_int(high_o2,k));

    end
end

% Image plot of all p-values for interaction terms
figure;
image(pval_hpb_arr, 'CDataMapping', 'scaled')
caxis manual
caxis([0,0.05])
colormap('hot')
colorbar
% colormap(flipud(colormap))
title('P-values between HP_B Interactions')


% Histograms of Strong T-test values
low_o2_dist = hp_b_tens(low_o2,1,32);
high_o2_dist = hp_b_tens(high_o2,1,32);
plot_title = 'Tracking Deriv Median x Comm Mean';
figure;
histogram(low_o2_dist)
hold on
histogram(high_o2_dist)
legend('Hypoxic', 'non-Hypoxic', 'location', 'best')
title(plot_title)

low_o2_dist = hp_b_tens(low_o2,1,36);
high_o2_dist = hp_b_tens(high_o2,1,36);
plot_title = 'Tracking Deriv Trend Slope x Comm Mean';
figure;
histogram(low_o2_dist)
hold on
histogram(high_o2_dist)
legend('Hypoxic', 'non-Hypoxic', 'location', 'best')
title(plot_title)

low_o2_dist = hp_b_tens(low_o2,19,30);
high_o2_dist = hp_b_tens(high_o2,19,30);
plot_title = 'Tracking Trend Slope x Mean ResMan Deriv';
figure;
histogram(low_o2_dist)
hold on
histogram(high_o2_dist)
legend('Hypoxic', 'non-Hypoxic', 'location', 'best')
title(plot_title)


low_o2_dist = hp_b_tens(low_o2,28,30);
high_o2_dist = hp_b_tens(high_o2,28,30);
plot_title = 'Tracking Trend Slope x Max Tracking';
figure;
histogram(low_o2_dist)
hold on
histogram(high_o2_dist)
legend('Hypoxic', 'non-Hypoxic', 'location', 'best')
title(plot_title)






%% HPC Interactions
% There are too many to write here. 

% Put Interactions into a new array
hp_c_int = nan*ones(length(HP_C(:,1)), 630);
pval_hpc_arr = nan*ones(36);
k = 0;
for i = 1:36
    for j = i:36
        k = k + 1;
        % Calculate Interaction Term
        hp_c_int(:, k) = HP_C(:,i) .* HP_C(:,j);
        % Conduct t-test -- Save p-value result
        [~, pval_hpc_arr(i,j)] = ttest2(hp_c_int(low_o2,k),...
        hp_c_int(high_o2,k));
    end
end


figure;
image(pval_hpc_arr, 'CDataMapping', 'scaled')
caxis manual
caxis([0,0.05])
colormap('hot')
colorbar
% colormap(flipud(colormap))
title('P-values between HP_C Interactions')


%% z-scored HP B Interactions
% ...

% Put Interactions into a new array
zhp_b_int = nan*ones(length(zHP_B(:,1)), 630);
zhp_b_tens = nan*ones(length(zHP_B(:,1)),36,36);
zpval_hpb_arr = nan*ones(36);
k = 0;
figure;
for i = 1:36
    for j = i:36
        k = k + 1;
        % Calculate Interaction Term
        zhp_b_int(:, k) = zHP_B(:,i) .* zHP_B(:,j);
        zhp_b_tens(:,i,j) = zhp_b_int(:, k);
        % Conduct t-test -- Save p-value result
        [~, pval_zhpb_arr(i,j)] = ttest2(zhp_b_int(low_o2,k),...
            zhp_b_int(high_o2,k));

    end
end


figure;
image(pval_zhpb_arr, 'CDataMapping', 'scaled')
caxis manual
caxis([0,0.05])
colormap('hot')
colorbar
% colormap(flipud(colormap))
title('P-values between z-scored HP_B Interactions')

low_o2_dist = zhp_b_tens(low_o2,19,30);
high_o2_dist = zhp_b_tens(high_o2,19,30);
plot_title = 'z-scored Tracking Trend Slope x Mean ResMan Deriv';
figure;
histogram(low_o2_dist)
hold on
histogram(high_o2_dist)
legend('Hypoxic', 'non-Hypoxic', 'location', 'best')
title(plot_title)

% Scatter Plot Matrices
figure;
subplot(3,2,1)
gscatter(zhp_b_tens(:, 28,30), zhp_b_tens(:, 19,30), high_o2)
subplot(3,2,2)
gscatter(zhp_b_tens(:, 28,30), zhp_b_tens(:, 1,36), high_o2)
subplot(3,2,3)
gscatter(zhp_b_tens(:, 28,30), zhp_b_tens(:, 1,32), high_o2)
subplot(3,2,4)
gscatter(zhp_b_tens(:, 19,30), zhp_b_tens(:, 1,36), high_o2)
subplot(3,2,4)
gscatter(zhp_b_tens(:, 19,30), zhp_b_tens(:, 1,32), high_o2)
subplot(3,2,5)
gscatter(zhp_b_tens(:, 1,36), zhp_b_tens(:, 1,32), high_o2)

% Obs 54 is an outlier
plot_pts_f1 = ~(Data(:,39) == 7);
plot_pts = plot_pts_f1;
figure;
subplot(3,2,1)
gscatter(zhp_b_tens(plot_pts, 28,30), zhp_b_tens(plot_pts, 19,30), high_o2(plot_pts))
subplot(3,2,2)
gscatter(zhp_b_tens(plot_pts, 28,30), zhp_b_tens(plot_pts, 1,36), high_o2(plot_pts))
subplot(3,2,3)
gscatter(zhp_b_tens(plot_pts, 28,30), zhp_b_tens(plot_pts, 1,32), high_o2(plot_pts))
subplot(3,2,4)
gscatter(zhp_b_tens(plot_pts, 19,30), zhp_b_tens(plot_pts, 1,36), high_o2(plot_pts))
subplot(3,2,4)
gscatter(zhp_b_tens(plot_pts, 19,30), zhp_b_tens(plot_pts, 1,32), high_o2(plot_pts))
subplot(3,2,5)
gscatter(zhp_b_tens(plot_pts, 1,36), zhp_b_tens(plot_pts, 1,32), high_o2(plot_pts))

% Obs 76 and 42 are outliers
Data_f1 = Data(plot_pts_f1, :);
Data_f1(76,39) % part no. = 11
Data_f1(42,39) % part no. = 6
plot_pts_f2 = ~(Data(:,39) == 7 | Data(:,39) == 11 | Data(:,39) == 6);
Data_f2 = Data(plot_pts_f2,:);
plot_pts = plot_pts_f2;

plotlim = [-1 1];

figure;
subplot(5,1,1)
gscatter(zhp_b_tens(plot_pts, 28,30), zhp_b_tens(plot_pts, 19,30), high_o2(plot_pts))
xlim(plotlim)
ylim(plotlim)
title('Track T.S. x ResMan` Mean vs. Track T.S. x Track Max')
subplot(5,1,2)
gscatter(zhp_b_tens(plot_pts, 28,30), zhp_b_tens(plot_pts, 1,36), high_o2(plot_pts))
xlim(plotlim)
ylim(plotlim)
title('Track` T.S. x Comm Mean vs. Track T.S. x Track Max')
subplot(5,1,3)
gscatter(zhp_b_tens(plot_pts, 28,30), zhp_b_tens(plot_pts, 1,32), high_o2(plot_pts))
xlim(plotlim)
ylim(plotlim)
title('Track` Median x Comm Mean vs. Track T.S. x Track Max')
subplot(5,1,4)
gscatter(zhp_b_tens(plot_pts, 19,30), zhp_b_tens(plot_pts, 1,36), high_o2(plot_pts))
xlim(plotlim)
ylim(plotlim)
title('Track` T.S. x Comm Mean vs. Track T.S. x ResMan` Mean')
subplot(5,1,4)
gscatter(zhp_b_tens(plot_pts, 19,30), zhp_b_tens(plot_pts, 1,32), high_o2(plot_pts))
xlim(plotlim)
ylim(plotlim)
title('Track` Median x Comm Mean vs. Track T.S. x ResMan` Mean')
subplot(5,1,5)
gscatter(zhp_b_tens(plot_pts, 1,36), zhp_b_tens(plot_pts, 1,32), high_o2(plot_pts))
xlim(plotlim)
ylim(plotlim)
title('Track` Median x Comm Mean vs. Track` T.S. x Comm Mean')

%% Correlations between all HP B Values
%
figure
image(abs(corr(zhp_b_int,zhp_b_int)), 'CDataMapping', 'scaled')
caxis manual
caxis([0,1])
colormap('hot')
colorbar
% colormap(flipud(colormap))
title('Correlations between z-scored HP_B Interactions')

[wcoef, score, latent, tsquared, explained] = pca(zhp_b_int);

c3 = wcoef(:,1:3)

I = c3'*c3 % Components are orthonormal

figure()
plot(score(:,1), score(:,2), '+')
xlabel('1st Principal Component')
ylabel('2st Principal Component')

gname

% Filter 1
Data(42,39)

filt1 = ~(Data(:,39) == 6);
Data_f1 = Data(filt1,:);

zhp_b_int_f1 = zhp_b_int(filt1,:);

[wcoef, score, latent, tsquared, explained] = pca(zhp_b_int_f1);

figure()
plot(score(:,1), score(:,2), '+')
xlabel('1st Principal Component')
ylabel('2st Principal Component')

% Filter 2
Data_f1(46,39)

filt2 = ~(Data_f1(:,39) == 7);
Data_f2 = Data(filt2,:);

zhp_b_int_f2 = zhp_b_int_f1(filt2,:);
[wcoef, score, latent, tsquared, explained] = pca(zhp_b_int_f2);

figure()
plot(score(:,1), score(:,2), '+')
xlabel('1st Principal Component')
ylabel('2st Principal Component')

% Filter 3
out_f3 = [86 70 46 112 62 88 34 164 82 30 38 92 66 58];
part_rem_f3 = Data_f2(out_f3,39);

filt3 = ~(Data_f2(:,39) == 13 | Data_f2(:,39) == 10 | Data_f2(:,39) == 7 |...
    Data_f2(:,39) == 17 | Data_f2(:,39) == 9 | Data_f2(:,39) == 14 | ...
    Data_f2(:,39) == 5 | Data_f2(:,39) == 25 | Data_f2(:,39) == 4 );
Data_f3 = Data(filt3,:);

zhp_b_int_f3 = zhp_b_int_f2(filt3,:);
[wcoef, score, latent, tsquared, explained] = pca(zhp_b_int_f3);

figure()
plot(score(:,1), score(:,2), '+')
xlabel('1st Principal Component')
ylabel('2st Principal Component')

figure
pareto(explained)
xlabel('Principal Component')
ylabel('Variance Explained (%)')
title('Variance Explained vs. PCA Component Number')

% TEST CODE

%         low_o2_dist = hp_b_tens(low_o2,i,j);
%         high_o2_dist = hp_b_tens(high_o2,i,j);
%         plot_title = strcat(num2str(i), ' x ', num2str(j));
%         subplot(37,18,k)
%         histogram(low_o2_dist)
%         hold on
%         histogram(high_o2_dist)
%         legend('Hypoxic', 'non-Hypoxic', 'location', 'best')
%         title(plot_title)