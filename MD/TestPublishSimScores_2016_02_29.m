%% Executive Summary
% 
% * Analyses of note.
% * Outliers.
% * Implications for further analysis.


%% Data Preparation
% Remove the room air trials.
hpdatav4.Run = categorical(hpdatav4.Run);

p = 0:0.25:1
y = quantile(hpdatav4.SIM_Altitude, p);
z = [p;y]

%% Simulator Score Box Plots
% There are no outliers for altitude scores. There are two outliers for
% heading scores. There are several speed score outliers, one of which is
% very extreme.

%%
% 
% * Data has a "fat" left tail and is slightly skewed right.

figure
histfit(hpdatav4.SIM_Altitude)
title('Histogram with Normal Distribution Overlay for Simulator Altitude Scores')
xlabel('RMS Altitude Deviation')
figure
boxplot(hpdatav4.SIM_Altitude, 'notch', 'on')
title('Simulator Altitude Scores')
ylabel('RMS Altitude Deviation')

%%
% 
% * Deviations in tails of normal distribution plot.
% * Strong performers (smaller scores) deviate beyond the 25th percentile.
% * Weak performers (larger scores) deviate (almost exactly) at the 75th
% percentile.
figure
normplot(hpdatav4.SIM_Altitude)
title('Normal Distribution Plot Simulator Altitude Scores')



figure
boxplot(hpdatav4.SIM_Heading, 'notch', 'on')
title('Simulator Heading Scores')
ylabel('RMS Heading Deviation')

figure
boxplot(hpdatav4.SIM_Speed, 'notch', 'on')
title('Simulator Speed Scores')
ylabel('RMS Speed Deviation')


%% Histogram
% DESCRIPTIVE TEXT



%%
% 
% * Data is slightly skewed right.

figure
histfit(hpdatav4.SIM_Heading)
title('Histogram with Normal Distribution Overlay for Simulator Heading Scores')
xlabel('RMS Heading Deviation')

%%
% 
% * Data is highly skewed right.

figure
histfit(hpdatav4.SIM_Speed)
title('Histogram with Normal Distribution Overlay for Simulator Speed Scores')
xlabel('RMS Speed Deviation')


%% Simulator Score Normal Distribution Plots
% The data appear to be broken into three categories (excellent, average,
% and poor) based on performance.




%%
% 
% * There are some slight deviations from normality just above the 75th
% percentile. However, the values return to follow the normal curve beyond
% the "blip".
% * There are two points that are clearly outliers.
% 

figure
normplot(hpdatav4.SIM_Heading)
title('Normal Distribution Plot Simulator Heading Scores')

%%
% 
% * A subset of the scores are normally distributed (closely aligning with
% data between 25th and 75th percentiles.
% * There is a severe deviation in those with poor scores (higher values).
% These values appear to fall roughly along a line.
% * There are also those that perform well (lower values). These also
% roughly fall along a line.

figure
normplot(hpdatav4.SIM_Speed)
title('Normal Distribution Plot Simulator Speed Scores')

%% Issue Fixed
% 
% * The speed and heading plots look too similar. They are the same. There
% was an error in my import script. Speed was imported from the "Heading"
% Data file.
% 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Conditioned on Run
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%


figure
boxplot(sim_altitude_exp, run_exp)
title('Simulator Altitude Scores by Run')

figure
boxplot(sim_heading_exp, run_exp)
title('Simulator Heading Scores by Run')

figure
boxplot(sim_speed_exp, run_exp)
title('Simulator Speed Scores by Run')
