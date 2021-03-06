
% load('../SharedDataExport/InputOutput_4_8_16.mat')
load('../SharedDataExport/InputOutput_4_8_16_v2.mat')

Indicators = Data(:, [39 41 40 38 37]);




%% Model 1
% Tracking Mean
model1_col = [40 45 46 47 48 56 57 58];
model1_feat = zscore(PhysioA(:, model1_col));
model1_resp_raw = zscore(HP_A(:, 25));
model1_resp = sign(zscore(HP_A(:, 25)));
model1_resp_nn = model1_resp > 0;
model1 = horzcat(model1_feat, model1_resp);
tabulate(model1_resp)

figure
k = 0;
for i = 1:8
    for j = i+1:8
        k = k + 1;
        subplot(7,4,k)
        gscatter(model1_feat(:,i), model1_feat(:,j), model1_resp)
        plot_title = strcat(num2str(i), '--', num2str(j));
        title(plot_title)
    end
end

figure
k = 0;
for i = 1:8
    for j = i+1:8
        k = k + 1;
        subplot(7,4,k)
        gscatter(model1_feat(:,i), model1_feat(:,j), Indicators(:,1))
        plot_title = strcat('By Subject:', num2str(j), ' vs. ', num2str(i));
        title(plot_title)
        legend off
    end
end

figure
k = 0;
for i = 1:8
        k = k + 1;
        subplot(4,2,k)
        gscatter(model1_resp_raw, model1_feat(:,i), Indicators(:,1))
        plot_title = strcat('By Subject:', 'Mean Tracking vs. ', num2str(model1_col(i)));
        title(plot_title)
        legend off
end

%% Model 1 Filter 1
% 
% * There are a few clusters of participants (22 and 23) that are clearly
% not part of the main cluster in the scatter plots (for physiological
% variables)
% * There are number of disperse performances (22, 23, 7, 31, 11, 48)
% 
good_subj1 = ~(Indicators(:,1) == 22 | Indicators(:,1) == 23);

model1_feat_f1 = PhysioA(good_subj1, model1_col);
figure
k = 0;
for i = 1:8
    for j = i+1:8
        k = k + 1;
        subplot(7,4,k)
        gscatter(model1_feat_f1(:,i), model1_feat_f1(:,j), Indicators(good_subj1,1))
        plot_title = strcat('By Subject:', num2str(j), ' vs. ', num2str(i));
        title(plot_title)
        legend off
    end
end


%% Model 1, Filter 2
% 
% * There are a few data points of participants (2, 33 and 45) that are
% seemingly out of place.
% 
good_subj2 = ~(Indicators(:,1) == 22 | Indicators(:,1) == 23 | ...
    Indicators(:,1) == 2 | Indicators(:,1) == 33 |...
    Indicators(:,1) == 45);

model1_feat_f2 = PhysioA(good_subj2, model1_col);
model1_resp_f2 = sign(zscore(HP_A(good_subj2, 25))) >= 0;
model1_f2 = horzcat(model1_feat_f2, model1_resp_f2);

figure
k = 0;
for i = 1:8
    for j = i+1:8
        k = k + 1;
        subplot(7,4,k)
        gscatter(model1_feat_f2(:,i), model1_feat_f2(:,j), Indicators(good_subj2,1))
        plot_title = strcat('By Subject:', num2str(j), ' vs. ', num2str(i));
        title(plot_title)
        colormap('colorcube')
        legend off
    end
end

figure
k = 0;
for i = 1:8
    for j = i+1:8
        k = k + 1;
        subplot(7,4,k)
        gscatter(model1_feat_f2(:,i), model1_feat_f2(:,j), model1_resp_f2)
        plot_title = strcat('By Response Class:', num2str(j), ' vs. ', num2str(i));
        title(plot_title)
        colormap('colorcube')
    end
end

%% Model 1, Filter 3
% 
% * There are a few data points of participants (2, 33 and 45) that are
% seemingly out of place.
% 
good_subj3 = ~(Indicators(:,1) == 22 | Indicators(:,1) == 23 | ...
    Indicators(:,1) == 2 | Indicators(:,1) == 33 |...
    Indicators(:,1) == 45 | Indicators(:,1) == 7 | Indicators(:,1) == 11 |...
    Indicators(:,1) == 48);

model1_col = [40 45 46 47 48 56 57 58];
model1_feat_f3 = zscore(PhysioA(good_subj3, model1_col));
model1_resp_raw_f3 = zscore(HP_A(good_subj3, 25));
model1_resp_f3 = sign(zscore(HP_A(good_subj3, 25)));
model1_resp_nn_f3 = model1_resp_f3 > 0;
model1_f3 = horzcat(model1_feat, model1_resp);

tabulate(model1_resp_f3)

figure
k = 0;
for i = 1:8
    for j = i+1:8
        k = k + 1;
        subplot(7,4,k)
        gscatter(model1_feat_f3(:,i), model1_feat_f3(:,j), model1_resp_nn_f3)
        plot_title = strcat(num2str(model1_col(i)), '--', num2str((model1_col(j))));
        title(plot_title)
    end
end

figure
k = 0;
for i = 1:8
        k = k + 1;
        subplot(4,2,k)
        gscatter(model1_resp_raw_f3, model1_feat_f3(:,i), Indicators(good_subj3,1))
        plot_title = strcat('By Subject:', 'Mean Tracking vs. ', num2str(model1_col(i)));
        title(plot_title)
        legend off
end


%% Model 2
% Tracking Mean

model2_feat = zscore(PhysioA(:, [40 45 46 47 48 56 57 58]));
model2_resp = zscore(HP_A(:, 25));
model2 = horzcat(model2_feat, model2_resp);

tabulate(model2_resp)


%% Model 2a
Remove
model2_feat = zscore(PhysioA(:, [40 45 46 47 48 56 57 58]));
model2_resp = zscore(HP_A(:, 25));
model2 = horzcat(model2_feat, model2_resp);
tabulate(model2_resp)