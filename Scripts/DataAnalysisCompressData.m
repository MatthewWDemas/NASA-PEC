clear all 
close all 
clc 

%load DataM_3_feat_version_v1_2016_04_04
% load('../SharedDataExport/DataMatrixSeta_ZScoreFullTime_M3_indiv_2016_04_08.mat')
% load('../SharedDataExport/DataMatrixSeta_ZScoreFullTime_M3_indiv_2016_05_02.mat')
% load('../SharedDataExport/DataMatrixSeta_ZScoreFullTime_M3_indiv_2016_05_03.mat')
load('../SharedDataExport/DataMatrixSeta_ZScoreFullTime_M3_indiv_2016_05_05.mat')


Data=DataM_3_feat_version; 
clear DataM_3_feat_version; 

%-------------------------------------
% Subject , Protocol , Task(Matb,sim,Cft), Hypoxic, Time,
% 
% ------------- 109: Comm: Time Index Offset
% ------------- 110: Comm: Num Missing Values per time interval
% ------------- 111: ResMan: Time Index Offset
% ------------- 112: ResMan: Num Missing Values per time interval
% ------------- 113: Tracking: Time Index Offset
% ------------- 114: Tracking: Num Missing Values per time interval
% ------------- 115: The Task Form Number from filename
% ------------- 116: Number of Comm Events Directed at Pilot
% ------------- 117: Number of Comm Events Directed at Other Ships
% ------------- 118: Number of ResMan Failures
% ------------- 119: Total Number of Events (col116+col117+col118)

% New Physio Interactions push the MATB Meta-Data Fields up by 6 positions
% Indictors=Data(:,[39,41,40,38,37,35,109:119]);  
Indictors=Data(:,[39,41,40,38,37,35,115:125]);  
%----- Removing the first minute ------
TimeRem=~(Indictors(:,5)==1);  % Indictor for first minute
AntiData=Data(~TimeRem,:);
Data=Data(TimeRem,:);
Indictors=Indictors(TimeRem,:); % Reform Indictors 
% ----- Removal of Subjects ----------
TimeRem=~(Indictors(:,1)==12);  % Indictor Subject 16 ..Participate 12
Data=Data(TimeRem,:);
AntiData=[AntiData;Data(~TimeRem,:)];
%-------------------------------------
% Removing Inf ,-Inf and NaN 
InfData=~( (sum(Data==Inf,2))+ (sum(Data==-Inf,2)) + sum(isnan(Data'))' );   %indictor for infinity
Data=Data(InfData,:);  % Remove All Infinity
AntiData=[AntiData;Data(~InfData,:)];
%-------------------------------------
% What was removed 
%-------------------------------------


% Data Ranges prior to addition of 11 new features
%
% PhysioA=Data(:,[1:34,36,42,79:84,85:108])+.0001; 
% PhysioB=Data(:,[109:144,79:84,181:204])+.0001;
% PhysioC=Data(:,[205:240,79:84,277:300])+.0001;
% 
% HP_A=Data(:,43:78)+.0001;
% HP_B=Data(:,145:180)+.0001;
% HP_C=Data(:,241:276)+.0001;
%
% PhysioA=Data(:,[1:34,36,42,79:84,85:108])+.0001; 
PhysioA=Data(:,[1:34,36,42,79:84,85:114])+.0001; 
% New Physio Interactions push the MATB Meta-Data Fields up by 6 positions
% (11 to 17)
% rangePhysioB = [109:144,79:84,181:204] + 11;
rangePhysioB = [109:144,79:84,181:204] + 17;
PhysioB=Data(:,rangePhysioB)+.0001;
% New Physio Interactions push the MATB Meta-Data Fields up by 6 positions
% (11 to 17)
% rangePhysioC = [205:240,79:84,277:300] + 11;
rangePhysioC = [205:240,79:84,277:300] + 17;
PhysioC=Data(:,rangePhysioC)+.0001;

HP_A=Data(:,43:78)+.0001;
% New Physio Interactions push the MATB Meta-Data Fields up by 6 positions
% (11 to 17)
% rangeHP_B = [145:180] + 11;
rangeHP_B = [145:180] + 17;
HP_B=Data(:,rangeHP_B)+.0001;
% New Physio Interactions push the MATB Meta-Data Fields up by 6 positions
% (11 to 17)
% rangeHP_C = [241:276] + 11;
rangeHP_C = [241:276] + 17;
HP_C=Data(:,rangeHP_C)+.0001;






% save('InputOutput_v3_4_11_16')
% save('../SharedDataExport/InputOutput_v4_5_2_16')
% save('../SharedDataExport/InputOutput_v5_5_3_16')
save('../SharedDataExport/InputOutput_v6_5_5_16')
% 
% % 
% % Metric=21;
% % %----------- -----------------------
% % for i=1:length(PhysioC(1,:))
% %     figure 
% % scatter(HP_B(:,Metric),PhysioC(:,i))
% % end 
% 
% 
% for Metric=1:34
% %Metric=30;
% %Output=abs(log(HP_A(:,Metric).*HP_A(:,Metric+1).*HP_A(:,Metric+3)));
% Output=((HP_A(:,Metric).*HP_A(:,Metric+2)));
% 
% %-----------Quantile Normalization -----------------------
% NN=zscore(([(PhysioA),Output])); 
% 
%     for i=1:length(PhysioA(1,:))
%   %   figure 
%    %  scatter(NN(:,end),NN(:,i))
%     II=zscore(NN(:,end))<0;
%     p(i,Metric)=ttest2(NN(~II,i),NN(II,i));
%     CC(i,Metric)=corr(NN(:,end),NN(:,i));
%     end 
% end
% 
%  Output=zscore(Output<0);
% NewData=quantilenorm([PhysioA,Output]);
% 
% % Output=kmeans([HP_A(:,25).*HP_A(:,26),HP_A(:,30)],3,'Replicates',400);
% % NewData=([PhysioA(:,[51,53,56:58]),Output]);
% % 
% % figure; 
% % hist(Output)
% 
% % % Number of Significant Data Sets
% % figure;
% % plot(sum(p))
% % title('Number of Significant Data Sets')
% % xlabel('Metrics')
% % ylabel('Number of Significant P Values')
% % 
% % % Correlations Over Metrics
% figure;
% plot(CC,'DisplayName','CC')
% title('Correlations Over Metrics (each trend is a metric)')
% ylabel('Correlations Coefficients')
% xlabel('Physiological Varibles')
% max(CC(:,:))
% min(CC(:,:))
% 
% 
% 
% 
% % %% Output=zscore(HP_A(:,Metric))<0;
% % Output=kmeans([HP_A(:,25).*HP_A(:,26),HP_A(:,30)],4,'Replicates',400);
% % NewData=([PhysioA,Output]);
