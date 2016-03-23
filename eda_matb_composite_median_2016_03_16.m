DataM_MATB = DataM(DataM(:,40) == 3,:);
DataM_MATB = DataM(DataM_MATB(:,38) ~= 1,:);


DataM_MATB(isnan(DataM_MATB(:,44)), [39 38 37])

DataM_MATB(find(isnan(DataM_MATB(:,44))),:) = [];

mean(DataM_MATB(:,44))
median(DataM_MATB(:,44))
skewness(DataM_MATB(:,44))
kurtosis(DataM_MATB(:,44))
std(DataM_MATB(:,44))

p = 0.:0.25:1;
y = quantile(DataM_MATB(:,44),p)

figure
plot(p,y)

Z = zscore(DataM_MATB(:,44));
outliers = find(abs(Z) > 2.9);
DataM_MATB(find(abs(Z) > 2.9),[39 38 37])

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

figure
h = histfit(DataM_MATB(:,44));
h(1).FaceColor = [0.9 0.9 0.9];
title('Histogram of Median MATB Composite Score in 2 min Intervals with Normal Overlay')

figure
n = normplot(DataM_MATB(:,44))
title('Histogram of Median MATB Composite Score in 2 min Intervals with Normal Overlay')


figure
b = boxplot(DataM_MATB(:,44))