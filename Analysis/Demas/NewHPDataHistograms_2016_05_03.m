clear all
close all
clc

% load('../SharedDataExport/InputOutput_4_8_16.mat');
% 
% performanceArray = HP_B;
% performanceArray(isnan(performanceArray)) = -1;
% 
% figure
% for iPerfFeature = 1:36
%     subplot(6,6,iPerfFeature)
%     histfit(performanceArray(:,iPerfFeature))
%     title(strcat('Wrong Data -- Feature ', num2str(iPerfFeature)));
% end
% 
% clear all
% 
% load('../SharedDataExport/InputOutput_v4_5_2_16.mat');
% 
% %% There are no NaNs in this data set.
% sum(isnan(HP_A), 1)
% sum(isnan(HP_B), 1)
% sum(isnan(HP_C), 1)
% 
% performanceArray = HP_A;
% titleDataSet = 'HP set A';
% figure
% for iPerfFeature = 1:36
%     subplot(6,6,iPerfFeature)
%     histfit(performanceArray(:,iPerfFeature))
%     title(strcat('New Data -- ', titleDataSet, ' -- Feature ',...
%         num2str(iPerfFeature)));
% end
% 
% performanceArray = HP_B;
% titleDataSet = 'HP set B';
% figure
% for iPerfFeature = 1:36
%     subplot(6,6,iPerfFeature)
%     histfit(performanceArray(:,iPerfFeature))
%     title(strcat('New Data -- ', titleDataSet, ' -- Feature ',...
%         num2str(iPerfFeature)));
% end
% 
% performanceArray = HP_C;
% titleDataSet = 'HP set C';
% figure
% for iPerfFeature = 1:36
%     subplot(6,6,iPerfFeature)
%     histfit(performanceArray(:,iPerfFeature))
%     title(strcat('New Data -- ', titleDataSet, ' -- Feature ',...
%         num2str(iPerfFeature)));
% end

%% Data Fixed: range for individualization adjusted.
clear all

load('../SharedDataExport/InputOutput_v5_5_3_16.mat');
sum(isnan(HP_A), 1)
sum(isnan(HP_B), 1)
sum(isnan(HP_C), 1)

performanceArray = HP_A;                          
titleDataSet = 'HP set A';
figure
for iPerfFeature = 1:36
    subplot(6,6,iPerfFeature)
    histfit(performanceArray(:,iPerfFeature))
    title(strcat('New Data -- ', titleDataSet, ' -- Feature ',...
        num2str(iPerfFeature)));
end

performanceArray = HP_B;
titleDataSet = 'HP set B';
figure
for iPerfFeature = 1:36
    subplot(6,6,iPerfFeature)
    histfit(performanceArray(:,iPerfFeature))
    title(strcat('New Data -- ', titleDataSet, ' -- Feature ',...
        num2str(iPerfFeature)));
end

performanceArray = HP_C;
titleDataSet = 'HP set C';
figure
for iPerfFeature = 1:36
    subplot(6,6,iPerfFeature)
    histfit(performanceArray(:,iPerfFeature))
    title(strcat('New Data -- ', titleDataSet, ' -- Feature ',...
        num2str(iPerfFeature)));
end


%% QQ Normal Plots

performanceArray = HP_A;                          
titleDataSet = 'HP set A';
figure
for iPerfFeature = 1:36
    subplot(6,6,iPerfFeature)
    normplot(performanceArray(:,iPerfFeature))
    title(strcat('New Data -- ', titleDataSet, ' -- Feature ',...
        num2str(iPerfFeature)));
end