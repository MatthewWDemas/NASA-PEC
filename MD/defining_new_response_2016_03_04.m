pec_data.Session = categorical(pec_data.Session);
pec_data.Subject = categorical(pec_data.Subject);
pec_data.Run = categorical(pec_data.Run);

%% Examination of TLX Scores
% Preparation for Two-Class Machine Learning Algorithms
pec_data_tlx = pec_data(~isnan(pec_data.tlx_score),:);
pec_data_tlx.tlx_zscore = zscore(pec_data_tlx.tlx_score);
pec_data_tlx.tlx_2class = sign(pec_data_tlx.tlx_zscore);

figure
histogram(pec_data_tlx.tlx_zscore)
title('Histogram of TLX Composite z-score')

pec_data_tlx.tlx_zscore(abs(pec_data_tlx.tlx_zscore) > 2,:)

%% Examination of Simulator Scores
% Preparation for Two-Class Machine Learning Algorithms

pec_data_sim = pec_data(pec_data.Session == 'SIM' & ~isnan(pec_data.SIM_Altitude),:);
pec_data_sim.SIM_zAltitude = zscore(pec_data_sim.SIM_Altitude);
pec_data_sim.SIM_Altitude_2class = sign(pec_data_sim.SIM_zAltitude);

%% Histogram with Normal Overlay
% Distribution is reasonably symmetric with some rightward skew (skewness=0.0019)
% and a concentrated peak (kurtosis=2.2)

figure
histfit(pec_data_sim.SIM_zAltitude)
title('Histogram of Altitude z-scores with Normal Overlay')

sim_zaltitude_locate = [mean(pec_data_sim.SIM_zAltitude)...
    median(pec_data_sim.SIM_zAltitude)...
    skewness(pec_data_sim.SIM_zAltitude)...
    kurtosis(pec_data_sim.SIM_zAltitude)]


%% Normal Probability Plot
% There are deviations from normality at the tails.

figure
probplot('normal', pec_data_sim.SIM_zAltitude)
title('Normal Probability Plot for Altitude z-scores')


%% Box Plot of Altitude Scores
% There are no outliers present in the Box plot or outside of 3 standard
% deviations.

figure
boxplot(pec_data_sim.SIM_zAltitude)
title('Box Plot of Altitude z-scores')

pec_data_sim.SIM_zAltitude(abs(pec_data_sim.SIM_zAltitude) > 2.9,:)


%% Scatter Plot Matrix Below/Above Average
%
pec_data_sim_arr = table2array(pec_data_sim(:,[63:95 99 107]));
figure
gplotmatrix(pec_data_sim_arr(:,1:34),...
    pec_data_sim_arr(:,1:34),...
    pec_data_sim_arr(:,end))
title('Scatter Plot Matrix of Physiological Variables with Altitude 2 Class')
lengend('Location', 'best')
fig = gcf;
fig.PaperUnits = 'inches';
fig.PaperSize = [44 34];
fig.PaperPosition = [0 0 44 34];
fig.PaperPositionMode = 'manual';
%fig.PaperOrientation = 'landscape';
print(fig, '~/Box Sync/Nasa Flight Data/DataAnalysis_Matt/Export/PostLaRC_2016-02-22/physio_sim_altitude_2class_2016-03-04.pdf',...
    '-dpdf', '-r600')



pec_data_sim_arr = table2array(pec_data_sim(:,[63:95 99]))
pec_data_sim_arr(isinf(pec_data_sim_arr))


%% Poor Performances
%
grpstats(pec_data_sim, 'SIM_Altitude_2class', {'count', 'mean'},...
    'DataVars', 'X1')
size(pec_data_sim.SIM_Altitude_2class(pec_data_sim.SIM_Altitude_2class > 0))
size(pec_data_sim.SIM_Altitude_2class(pec_data_sim.SIM_Altitude_2class < 0))
size(pec_data_sim.SIM_Altitude_2class(pec_data_sim.SIM_Altitude_2class == 0))