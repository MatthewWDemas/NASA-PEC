
load('../DataExportMATLAB/IndividualizedFeatures_vPrelim_2016_03_30.mat');

figure; 
histogram(FeatArr(FeatArr(:,37) ~= 1,79)); 
hold on; 
histogram(FeatArr(:,79)); 
legend('Time Instance 1 Removed', 'No Time Instances Removed')
title('Histogram of Comm Mean Scores')

figure; 
histogram(zscore(FeatArr(FeatArr(:,37) ~= 1,79))); 
hold on; 
histogram(zscore(FeatArr(:,79))); 
legend('Time Instance 1 Removed', 'No Time Instances Removed')
title('Histogram of Z-Scored Comm Mean Scores')

FeatArr_qn = quantilenorm(FeatArr);