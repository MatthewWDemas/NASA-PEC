DataM_MATB = DataM(DataM(:,40) == 3,:);
DataM_MATB = DataM(DataM(:,38) ~= 1,:);

matb_comb_median_fig = figure;
for i = 1:49
%     i = 15
    subj_scores = DataM_MATB(DataM_MATB(:,39) == i, :);
    subj_scores_nh = subj_scores(subj_scores(:,38) == 2, :);
    subj_scores_h = subj_scores(subj_scores(:,38) == 3, :); 
    
    subjtitle = strcat('Composite Score Median vs. Time Instance -- ', num2str(i));
    
    subplot(7,7,i)
    
    plot(subj_scores_nh(:,37),...
        subj_scores_nh(:,44))
    hold on
    plot(subj_scores_h(:,37),...
        subj_scores_h(:,44))
    legend('Non-Hypoxic', 'Hypoxic', 'location', 'best')
    title(subjtitle)
%     ylim([-2 2])
    hold off
end
PrintFigPDF(matb_comb_median_fig, ...
    '~/Box Sync/Nasa Flight Data/DataAnalysis_Matt/Export/PostLaRC_2016-02-22/matb_ts_composite_score_median_2016_03_15.pdf')
% fig = matb_comb_median_fig;
% fig.PaperUnits = 'inches';
% fig.PaperSize = [22 17];
% fig.PaperPosition = [0 0 22 17];
% fig.PaperPositionMode = 'manual';
% %fig.PaperOrientation = 'landscape';
% print(fig, '~/Box Sync/Nasa Flight Data/DataAnalysis_Matt/Export/PostLaRC_2016-02-22/matb_ts_composite_score_median_2016_03_15.pdf',...
%     '-dpdf', '-r600')

%----------- Composite Score Minimum ------------------
matb_comb_min_fig = figure;
for i = 1:49
%     i = 15
    subj_scores = DataM_MATB(DataM_MATB(:,39) == i, :);
    subj_scores_nh = subj_scores(subj_scores(:,38) == 2, :);
    subj_scores_h = subj_scores(subj_scores(:,38) == 3, :); 
    
    subjtitle = strcat('Composite Score Min vs. Time Instance -- ', num2str(i));
    
    subplot(7,7,i)
    
    plot(subj_scores_nh(:,37),...
        subj_scores_nh(:,45))
    hold on
    plot(subj_scores_h(:,37),...
        subj_scores_h(:,45))
    legend('Non-Hypoxic', 'Hypoxic', 'location', 'best')
    title(subjtitle)
%     ylim([-2 2])
    hold off
end
PrintFigPDF(matb_comb_min_fig, ...
    '~/Box Sync/Nasa Flight Data/DataAnalysis_Matt/Export/PostLaRC_2016-02-22/matb_ts_composite_score_min_2016_03_15.pdf')

%----------- Composite Score Maximum ------------------
matb_comb_max_fig = figure;
for i = 1:49
%     i = 15
    subj_scores = DataM_MATB(DataM_MATB(:,39) == i, :);
    subj_scores_nh = subj_scores(subj_scores(:,38) == 2, :);
    subj_scores_h = subj_scores(subj_scores(:,38) == 3, :); 
    
    subjtitle = strcat('Composite Score Max vs. Time Instance -- ', num2str(i));
    
    subplot(7,7,i)
    
    plot(subj_scores_nh(:,37),...
        subj_scores_nh(:,46))
    hold on
    plot(subj_scores_h(:,37),...
        subj_scores_h(:,46))
    legend('Non-Hypoxic', 'Hypoxic', 'location', 'best')
    title(subjtitle)
%     ylim([-2 2])
    hold off
end

%----------- Composite Score Std Dev ------------------
matb_comb_stddev_fig = figure;
for i = 1:49
%     i = 15
    subj_scores = DataM_MATB(DataM_MATB(:,39) == i, :);
    subj_scores_nh = subj_scores(subj_scores(:,38) == 2, :);
    subj_scores_h = subj_scores(subj_scores(:,38) == 3, :); 
    
    subjtitle = strcat('Composite Score Std Dev vs. Time Instance -- ', num2str(i));
    
    subplot(7,7,i)
    
    plot(subj_scores_nh(:,37),...
        subj_scores_nh(:,47))
    hold on
    plot(subj_scores_h(:,37),...
        subj_scores_h(:,47))
    legend('Non-Hypoxic', 'Hypoxic', 'location', 'best')
    title(subjtitle)
%     ylim([-2 2])
    hold off
end

%----------- Composite Score Trend ------------------
matb_comb_stddev_fig = figure;
for i = 1:49
%     i = 15
    subj_scores = DataM_MATB(DataM_MATB(:,39) == i, :);
    subj_scores_nh = subj_scores(subj_scores(:,38) == 2, :);
    subj_scores_h = subj_scores(subj_scores(:,38) == 3, :); 
    
    subjtitle = strcat('Composite Score Trend vs. Time Instance -- ', num2str(i));
    
    subplot(7,7,i)
    
    plot(subj_scores_nh(:,37),...
        subj_scores_nh(:,48))
    hold on
    plot(subj_scores_h(:,37),...
        subj_scores_h(:,48))
    legend('Non-Hypoxic', 'Hypoxic', 'location', 'best')
    title(subjtitle)
%     ylim([-2 2])
    hold off
end

%----------- Composite Score dT/dt Mean ------------------
matb_comb_dT_fig = figure;
for i = 1:49
%     i = 15
    subj_scores = DataM_MATB(DataM_MATB(:,39) == i, :);
    subj_scores_nh = subj_scores(subj_scores(:,38) == 2, :);
    subj_scores_h = subj_scores(subj_scores(:,38) == 3, :); 
    
    subjtitle = strcat('Composite Score dT/dt Mean vs. Time Instance -- ', num2str(i));
    
    subplot(7,7,i)
    
    plot(subj_scores_nh(:,37),...
        subj_scores_nh(:,49))
    hold on
    plot(subj_scores_h(:,37),...
        subj_scores_h(:,49))
    legend('Non-Hypoxic', 'Hypoxic', 'location', 'best')
    title(subjtitle)
%     ylim([-2 2])
    hold off
end

%----------- Composite Score dT/dt Mean ------------------
matb_comb_dT_stddev_fig = figure;
for i = 1:49
%     i = 15
    subj_scores = DataM_MATB(DataM_MATB(:,39) == i, :);
    subj_scores_nh = subj_scores(subj_scores(:,38) == 2, :);
    subj_scores_h = subj_scores(subj_scores(:,38) == 3, :); 
    
    subjtitle = strcat('Composite Score dT/dt Std Dev vs. Time Instance -- ', num2str(i));
    
    subplot(7,7,i)
    
    plot(subj_scores_nh(:,37),...
        subj_scores_nh(:,53))
    hold on
    plot(subj_scores_h(:,37),...
        subj_scores_h(:,53))
    legend('Non-Hypoxic', 'Hypoxic', 'location', 'best')
    title(subjtitle)
%     ylim([-2 2])
    hold off
end

figure;
subplot(2,3,1)
histfit(DataM_MATB(:, 43))
title('Histogram with Normal Fit for Mean Composite MATB Score')

subplot(2,3,2)
histfit(DataM_MATB(:, 44))
title('Histogram with Normal Fit for Median Composite MATB Score')

subplot(2,3,3)
histfit(DataM_MATB(:, 45))
title('Histogram with Normal Fit for Min Composite MATB Score')

subplot(2,3,4)
histfit(DataM_MATB(:, 46))
title('Histogram with Normal Fit for Max Composite MATB Score')

subplot(2,3,5)
histfit(DataM_MATB(:, 47))
title('Histogram with Normal Fit for Std Dev Composite MATB Score')

subplot(2,3,6)
histfit(DataM_MATB(:, 48))
title('Histogram with Normal Fit for Trend Composite MATB Score')

figure;
subplot(2,3,1)
h = histfit(DataM_MATB(:, 49))
h(1).FaceColor = [0.9 0.9 0.9];
    'FaceColor',...
    [0.941176474094391 0.941176474094391 0.941176474094391])
title('Histogram with Normal Fit for Mean Composite MATB Score')

subplot(2,3,2)
histfit(DataM_MATB(:, 50))
title('Histogram with Normal Fit for Median Composite MATB Score')

subplot(2,3,3)
histfit(DataM_MATB(:, 51))
title('Histogram with Normal Fit for Min Composite MATB Score')

subplot(2,3,4)
histfit(DataM_MATB(:, 52))
title('Histogram with Normal Fit for Max Composite MATB Score')

subplot(2,3,5)
histfit(DataM_MATB(:, 53))
title('Histogram with Normal Fit for Std Dev Composite MATB Score')

subplot(2,3,6)
histfit(DataM_MATB(:, 54))
title('Histogram with Normal Fit for Trend Composite MATB Score')

%------------- QQ Plot --------------------
figure;
subplot(2,3,1)
normplot( DataM_MATB(:, 43))
title('Q-Q Normal Plot for Mean Composite MATB Score')

subplot(2,3,2)
normplot( DataM_MATB(:, 44))
title('Q-Q Normal Plot for Median Composite MATB Score')

subplot(2,3,3)
normplot( DataM_MATB(:, 45))
title('Q-Q Normal Plot for Min Composite MATB Score')

subplot(2,3,4)
normplot( DataM_MATB(:, 46))
title('Q-Q Normal Plot for Max Composite MATB Score')

subplot(2,3,5)
normplot( DataM_MATB(:, 47))
title('Q-Q Normal Plot for Std Dev Composite MATB Score')

subplot(2,3,6)
normplot( DataM_MATB(:, 48))
title('Q-Q Normal Plot for Trend Composite MATB Score')

figure;
subplot(2,3,1)
normplot( DataM_MATB(:, 49))
title('Q-Q Normal Plot for Mean Composite MATB Score')

subplot(2,3,2)
normplot( DataM_MATB(:, 50))
title('Q-Q Normal Plot for Median Composite MATB Score')

subplot(2,3,3)
normplot( DataM_MATB(:, 51))
title('Q-Q Normal Plot for Min Composite MATB Score')

subplot(2,3,4)
normplot( DataM_MATB(:, 52))
title('Q-Q Normal Plot for Max Composite MATB Score')

subplot(2,3,5)
normplot( DataM_MATB(:, 53))
title('Q-Q Normal Plot for Std Dev Composite MATB Score')

subplot(2,3,6)
normplot( DataM_MATB(:, 54))
title('Q-Q Normal Plot for Trend Composite MATB Score')
PrintFigPDF(matb_comb_min_fig, ...
    '~/Box Sync/Nasa Flight Data/DataAnalysis_Matt/Export/PostLaRC_2016-02-22/matb_ts_composite_score_min_2016_03_15.pdf')




%     figure
%     plot(subj_scores_nh(:,37),...
%         subj_scores_nh(:,47))
%     hold on
%     plot(subj_scores_h(:,37),...
%         subj_scores_h(:,47))
%     legend('Non-Hypoxic', 'Hypoxic', 'location', 'best')
%     title('Plot of Std Dev versus Time Instance')
%     
%     figure
%     plot(subj_scores_nh(:,37),...
%         subj_scores_nh(:,48))
%     hold on
%     plot(subj_scores_h(:,37),...
%         subj_scores_h(:,48))
%     legend('Non-Hypoxic', 'Hypoxic', 'location', 'best')
%     title('Plot of Trend versus Time Instance')