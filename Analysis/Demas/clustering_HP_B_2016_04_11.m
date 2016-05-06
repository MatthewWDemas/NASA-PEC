
%% Load the data
% Prepare data from 

load('./Data/InputOutput_v3_4_11_16.mat')



%% Model 4
% Filter 0
% out_f3 = [86 70 46 112 62 88 34 164 82 30 38 92 66 58];
% part_rem_f3 = Data_f2(out_f3,39);

% filt3 = ~(Data_f2(:,39) == 13 | Data_f2(:,39) == 10 | Data_f2(:,39) == 7 |...
%     Data_f2(:,39) == 17 | Data_f2(:,39) == 9 | Data_f2(:,39) == 14 | ...
%     Data_f2(:,39) == 5 | Data_f2(:,39) == 25 | Data_f2(:,39) == 4 );
% Data_f3 = Data(filt3,:);
% 
% zhp_b_int_f3 = zhp_b_int_f2(filt3,:);

% Conduct PCA on HP DataB
[wcoef, score, latent, tsquared, explained] = pca(HP_B);

% Plot First 2 Principal Components
figure()
plot(score(:,1), score(:,2), '+')
xlabel('1st Principal Component')
ylabel('2st Principal Component')

figure()
plot(score(:,2), score(:,3), '+')
xlabel('2nd Principal Component')
ylabel('3rd Principal Component')

figure
pareto(explained)
xlabel('Principal Component')
ylabel('Variance Explained (%)')
title('Variance Explained vs. PCA Component Number')

% There appear to be be three clusters in PCA1 vs PCA2.
% K-means groups these well (at least by visual inspection).
k3 = kmeans(score(:, 1:3), 3);

% Plot to verify (use PCA1-4)
figure()
subplot(3,2,1)
gscatter(score(:,1), score(:,2), k3)
xlabel('Principal Component 1')
ylabel('Principal Component 2')

subplot(3,2,2)
gscatter(score(:,1), score(:,3), k3)
xlabel('Principal Component 1')
ylabel('Principal Component 3')

subplot(3,2,3)
gscatter(score(:,1), score(:,4), k3)
xlabel('Principal Component 1')
ylabel('Principal Component 4')

subplot(3,2,4)
gscatter(score(:,2), score(:,3), k3)
xlabel('Principal Component 2')
ylabel('Principal Component 3')

subplot(3,2,5)
gscatter(score(:,2), score(:,4), k3)
xlabel('Principal Component 2')
ylabel('Principal Component 4')

subplot(3,2,6)
gscatter(score(:,3), score(:,4), k3)
xlabel('Principal Component 3')
ylabel('Principal Component 4')

coefforth = inv(diag(std(HP_B)))*wcoef;
c3 = wcoef(:,1:3)

A = cell(36, 1);
A{1,1} = '1 Comm Y Mean';
A{2,1} = '2 Comm Y Median';
A{3,1} = '3 Comm Y Min';
A{4,1} = '4 Comm Y Max';
A{5,1} = '5 Comm Y StdDev';
A{6,1} = '6 Comm Y TrendSlope';
A{7,1} = '7 Comm  dYdt Mean';
A{8,1} = '8 Comm  dYdt Median';
A{9,1} = '9 Comm  dYdt Min';
A{10,1} = '10 Comm  dYdt Max';
A{11,1} = '11 Comm  dYdt StdDev';
A{12,1} = '12 Comm  dYdt TrendSlope';
A{13,1} = '13 ResMan Y Mean';
A{14,1} = '14 ResMan Y Median';
A{15,1} = '15 ResMan Y Min';
A{16,1} = '16 ResMan Y Max';
A{17,1} = '17 ResMan Y StdDev';
A{18,1} = '18 ResMan Y TrendSlope';
A{19,1} = '19 ResMan  dYdt Mean';
A{20,1} = '20 ResMan  dYdt Median';
A{21,1} = '21 ResMan  dYdt Min';
A{22,1} = '22 ResMan  dYdt Max';
A{23,1} = '23 ResMan  dYdt StdDev';
A{24,1} = '24 ResMan  dYdt TrendSlope';
A{25,1} = '25 Track Y Mean';
A{26,1} = '26 Track Y Median';
A{27,1} = '27 Track Y Min';
A{28,1} = '28 Track Y Max';
A{29,1} = '29 Track Y StdDev';
A{30,1} = '30 Track Y TrendSlope';
A{31,1} = '31 Track  dYdt Mean';
A{32,1} = '32 Track  dYdt Median';
A{33,1} = '33 Track  dYdt Min';
A{34,1} = '34 Track  dYdt Max';
A{35,1} = '35 Track  dYdt StdDev';
A{36,1} = '36 Track  dYdt TrendSlope';

figure
subplot(1,2,1)
biplot(coefforth(:,1:2),'scores',score(:,1:2), 'varlabels', A);
subplot(1,2,2)
biplot(coefforth(:,2:3),'scores',score(:,2:3), 'varlabels', A);

%% Prepare Model 4, Group 1
% * Response (binary O2 Concentration during 2min segment
% * Features (PCs #'s 1-4)
group1 = (k3 == 1);

high_o2 = (Data(:,35) >= 16);

model4_g1_feat = score(group1,1:4);
model4_g1_resp = high_o2(group1); 
model4_g1 = horzcat(model4_g1_feat, model4_g1_resp);

figure()
subplot(3,2,1)
gscatter(model4_g1_feat(:,1), model4_g1_feat(:,2), model4_g1_resp)
xlabel('Principal Component 1')
ylabel('Principal Component 2')
title('Group 1: PCA Colored by Hypoxic (0) and Non-Hypoxic (1)')
legend('Hypoxic', 'Non-Hypoxic')

subplot(3,2,2)
gscatter(model4_g1_feat(:,1), model4_g1_feat(:,3), model4_g1_resp)
xlabel('Principal Component 1')
ylabel('Principal Component 3')
title('Group 1: PCA Colored by Hypoxic (0) and Non-Hypoxic (1)')
legend('Hypoxic', 'Non-Hypoxic')

subplot(3,2,3)
gscatter(model4_g1_feat(:,1), model4_g1_feat(:,4), model4_g1_resp)
xlabel('Principal Component 1')
ylabel('Principal Component 4')
title('Group 1: PCA Colored by Hypoxic (0) and Non-Hypoxic (1)')
legend('Hypoxic', 'Non-Hypoxic')

subplot(3,2,4)
gscatter(model4_g1_feat(:,2), model4_g1_feat(:,3), model4_g1_resp)
xlabel('Principal Component 2')
ylabel('Principal Component 3')
title('Group 1: PCA Colored by Hypoxic (0) and Non-Hypoxic (1)')
legend('Hypoxic', 'Non-Hypoxic')

subplot(3,2,5)
gscatter(model4_g1_feat(:,2), model4_g1_feat(:,4), model4_g1_resp)
xlabel('Principal Component 2')
ylabel('Principal Component 4')
title('Group 1: PCA Colored by Hypoxic (0) and Non-Hypoxic (1)')
legend('Hypoxic', 'Non-Hypoxic')

subplot(3,2,6)
gscatter(model4_g1_feat(:,3), model4_g1_feat(:,4), model4_g1_resp)
xlabel('Principal Component 3')
ylabel('Principal Component 4')
title('Group 1: PCA Colored by Hypoxic (0) and Non-Hypoxic (1)')
legend('Hypoxic', 'Non-Hypoxic')


%% Prepare Model 4, Group 1, A (physio)
% * Response (binary O2 Concentration during 2min segment
% * Features (PCs #'s 1-4)
group1 = (k3 == 1);

high_o2 = (Data(:,35) >= 16);

model4_g1_A = score(group1,1:4);
model4_g1_resp = high_o2(group1); 
model4_g1 = horzcat(model4_g1_feat, model4_g1_resp);

%% Model 5
% z-score of HP_B Data
zHP_B = zscore(HP_B);

[m5wcoef, m5score, m5latent, m5tsquared, m5explained] = pca(zHP_B);

figure()
plot(m5score(:,1), m5score(:,2), '+')
xlabel('1st Principal Component')
ylabel('2st Principal Component')

figure()
plot(m5score(:,1), m5score(:,3), '+')
xlabel('1st Principal Component')
ylabel('3rd Principal Component')

figure
pareto(m5explained)
xlabel('Principal Component')
ylabel('Variance Explained (%)')
title('Variance Explained vs. PCA Component Number')

% K-means k=5
m5k3 = kmeans(m5score(:, 1:10), 3);

figure
k=0
for i=1:10
    for j = i+1:10
        k=k+1;
        subplot(9,5,k)
        gscatter(m5score(:,i), m5score(:,j), m5k3)
        xlab = strcat('Principal Component', num2str(i));
        ylab = strcat('Principal Component', num2str(j));
        plot_title = 'K-means Cluster (k=3)';
        xlabel(xlab);
        ylabel(ylab);
        title(plot_title);
    end
end

% K-means k=5
m5k5 = kmeans(m5score(:, 1:10), 5);

figure
k=0
for i=1:10
    for j = i+1:10
        k=k+1;
        subplot(9,5,k)
        gscatter(m5score(:,i), m5score(:,j), m5k5)
        xlab = strcat('Principal Component', num2str(i));
        ylab = strcat('Principal Component', num2str(j));
        plot_title = 'K-means Cluster (k=5)';
        xlabel(xlab);
        ylabel(ylab);
        title(plot_title);
    end
end