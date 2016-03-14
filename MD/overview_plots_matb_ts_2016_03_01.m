

% Convert Run to Categorical
matb_ts.Run = categorical(matb_ts.Run);
% Remove Room Air Trials and get the last 10 minutes of data (minus the
% last point, which appears to drop suddenly for some participants)
matb_ts2 = matb_ts(matb_ts.Time >= 60 & matb_ts.Run ~= 'RA' & matb_ts.Time < 660, :);
matb_ts2.Subject = categorical(matb_ts2.Subject);
% matb_ts2.Run = categorical(matb_ts2.Run);


% Get list of subjects to filter by
subjects = unique(matb_ts2.Subject);

%% Overview of MATB Tracking Performances
% It is difficult to tell from the data, but some subjects appear to be
% better at maintaining the tracking task than others.


tracking_fig = figure;
for subj = 1:49

matb_ts2_subj = matb_ts2(matb_ts2.Subject == subjects(subj),:);

matb_ts2_subj.Run = categorical(matb_ts2_subj.Run);

%nhtitle = strcat(num2str(subj), ' Tracking Performance in Non-Hypoxic Trial')
%subjtitle = strcat(num2str(subj), ' Tracking Performance in Hypoxic Trial')
subjtitle = strcat(num2str(subj), ' Tracking Performance');



subplot(7,7,subj)
plot(matb_ts2_subj.Time(matb_ts2_subj.Run == 'SL',:), matb_ts2_subj.Track(matb_ts2_subj.Run == 'SL',:))

title(subjtitle)
xlabel('Time (in seconds)')
ylabel('Tracking Score')
hold on
plot(matb_ts2_subj.Time(matb_ts2_subj.Run == '15k',:),...
    matb_ts2_subj.Track(matb_ts2_subj.Run == '15k',:))
legend('SL', '15k', 'location', 'best')
hold off
end

fig = tracking_fig;
fig.PaperUnits = 'inches';
fig.PaperSize = [22 17];
fig.PaperPosition = [0 0 22 17];
fig.PaperPositionMode = 'manual';
%fig.PaperOrientation = 'landscape';
print(fig, '~/Box Sync/Nasa Flight Data/DataAnalysis_Matt/Export/PostLaRC_2016-02-22/matb_ts_tracking_2016_03_01.pdf',...
    '-dpdf', '-r600')


%% Overview of MATB ResMan Performances
% It is difficult to tell from the data, but some subjects appear to be
% better at maintaining the tracking task than others.

resman_fig = figure;
for subj = 1:49

matb_ts2_subj = matb_ts2(matb_ts2.Subject == subjects(subj),:);

subjtitle = strcat(num2str(subj), ' ResMan Performance');

subplot(7,7,subj)
plot(matb_ts2_subj.Time(matb_ts2_subj.Run == 'SL',:),...
    matb_ts2_subj.ResMan(matb_ts2_subj.Run == 'SL',:))

title(subjtitle)
xlabel('Time (in seconds)')
ylabel('ResMan Score')
hold on
plot(matb_ts2_subj.Time(matb_ts2_subj.Run == '15k',:),...
    matb_ts2_subj.ResMan(matb_ts2_subj.Run == '15k',:))
legend('SL', '15k', 'location', 'best')
hold off
end
fig = resman_fig;
fig.PaperUnits = 'inches';
fig.PaperSize = [22 17];
fig.PaperPosition = [0 0 22 17];
fig.PaperPositionMode = 'manual';
%fig.PaperOrientation = 'landscape';
print(fig, '~/Box Sync/Nasa Flight Data/DataAnalysis_Matt/Export/PostLaRC_2016-02-22/matb_ts_resman_2016_03_01.pdf',...
    '-dpdf', '-r600')

%% Overview of Derivative of MATB Tracking Performances
% 


tracking_diff_fig = figure;
for subj = 1:49

matb_ts2_subj = matb_ts2(matb_ts2.Subject == subjects(subj),:);

%nhtitle = strcat(num2str(subj), ' Tracking Performance in Non-Hypoxic Trial')
%subjtitle = strcat(num2str(subj), ' Tracking Performance in Hypoxic Trial')
subjtitle = strcat(num2str(subj), ' Tracking Performance Derivative');



subplot(7,7,subj)
plot(...%matb_ts2_subj.Time(matb_ts2_subj.Run == 'SL',2:end),...
    diff(matb_ts2_subj.Track(matb_ts2_subj.Run == 'SL',:)))

title(subjtitle)
% xlabel('Time (in seconds)')
xlabel('Time Step (in 5 second steps)')
ylabel('Tracking Score Derivative')
ylim([-20 20])
hold on
plot(...%matb_ts2_subj.Time(matb_ts2_subj.Run == '15k',2:end),...
    diff(matb_ts2_subj.Track(matb_ts2_subj.Run == '15k',:)))
legend('SL', '15k', 'location', 'best')
hold off
end
fig = tracking_diff_fig;
fig.PaperUnits = 'inches';
fig.PaperSize = [22 17];
fig.PaperPosition = [0 0 22 17];
fig.PaperPositionMode = 'manual';
%fig.PaperOrientation = 'landscape';
print(fig, '~/Box Sync/Nasa Flight Data/DataAnalysis_Matt/Export/PostLaRC_2016-02-22/matb_ts_tracking_derivative_2016_03_01.pdf',...
    '-dpdf', '-r600')
%% Overview of Derivative of MATB ResMan Performances
% 


resman_diff_fig = figure;
for subj = 1:49

matb_ts2_subj = matb_ts2(matb_ts2.Subject == subjects(subj),:);

%nhtitle = strcat(num2str(subj), ' Tracking Performance in Non-Hypoxic Trial')
%subjtitle = strcat(num2str(subj), ' Tracking Performance in Hypoxic Trial')
subjtitle = strcat(num2str(subj), ' Tracking Performance Derivative');



subplot(7,7,subj)
plot(...%matb_ts2_subj.Time(matb_ts2_subj.Run == 'SL',2:end),...
    diff(matb_ts2_subj.ResMan(matb_ts2_subj.Run == 'SL',:)))

title(subjtitle)
% xlabel('Time (in seconds)')
xlabel('Time Step (in 5 second steps)')
ylabel('ResMan Score Derivative')
ylim([-6 6])
hold on
plot(...%matb_ts2_subj.Time(matb_ts2_subj.Run == '15k',2:end),...
    diff(matb_ts2_subj.ResMan(matb_ts2_subj.Run == '15k',:)))
legend('SL', '15k', 'location', 'best')
hold off
end
% saveas(gcf, '~/Box Sync/Nasa Flight Data/DataAnalysis_Matt/Export/PostLaRC_2016-02-22/matb_ts_resman_derivative_2016_03_01.svg')
set(resman_diff_fig, 'PaperPositionMode', 'manual',...
    'PaperSize', [17 22],...
    'PaperOrientation', 'landscape')
fig = resman_diff_fig;
fig.PaperUnits = 'inches';
fig.PaperSize = [22 17];
fig.PaperPosition = [0 0 22 17];
fig.PaperPositionMode = 'manual';
fig.PaperOrientation = 'landscape';
print(fig, '~/Box Sync/Nasa Flight Data/DataAnalysis_Matt/Export/PostLaRC_2016-02-22/matb_ts_resman_derivative_2016_03_01.pdf',...
    '-dpdf', '-r600')
% tmp = fft(diff(matb_ts2_subj.Track(matb_ts2_subj.Run == 'SL',:)));
% tmp2 = fft(diff(matb_ts2_subj.Track(matb_ts2_subj.Run == '15k',:)));
% 
% figure
% plot(abs(tmp))
% xlim([0 60])
% hold on
% plot(abs(tmp2))
% 
% figure
% plot(real(tmp), imag(tmp))
% hold on
% plot(real(tmp2), imag(tmp2))