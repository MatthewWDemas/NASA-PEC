%% Import data from spreadsheet
% Script for importing data from the following spreadsheet:
%
%    Workbook: /Users/demasma/Box Sync/Nasa Flight Data/DataAnalysis_Matt/NASA-PEC-R-Analysis/Data/matb_ts_v3_2016-03-02.xlsx
%    Worksheet: matb_ts_v2_2016-03-02
%
% To extend the code for use with different selected data or a different
% spreadsheet, generate a function instead of a script.

% Auto-generated by MATLAB on 2016/03/02 16:39:16

%% Import the data
[~, ~, raw] = xlsread('/Users/matt/Box Sync/Nasa Flight Data/DataAnalysis_Matt/NASA-PEC-R-Analysis/Data/matb_ts_v3_2016-03-02.xlsx','matb_ts_v2_2016-03-02');
raw = raw(2:end,:);
raw(cellfun(@(x) ~isempty(x) && isnumeric(x) && isnan(x),raw)) = {''};
cellVectors = raw(:,[1,2,3,4,5,6,7,8,10,11]);
raw = raw(:,[9,12,13,14,15]);

%% Replace non-numeric cells with NaN
R = cellfun(@(x) ~isnumeric(x) && ~islogical(x),raw); % Find non-numeric cells
raw(R) = {NaN}; % Replace non-numeric cells

%% Create output variable
data = reshape([raw{:}],size(raw));

%% Create table
matb_ts = table;

%% Allocate imported array to column variable names
matb_ts.Subject = cellVectors(:,1);
matb_ts.Runid = cellVectors(:,2);
matb_ts.Protocol = cellVectors(:,3);
matb_ts.Sessionid = cellVectors(:,4);
matb_ts.Task = cellVectors(:,5);
matb_ts.Run = cellVectors(:,6);
matb_ts.Trial = cellVectors(:,7);
matb_ts.Trialid = cellVectors(:,8);
matb_ts.SubjectTrial = data(:,1);
matb_ts.SessionOrder = cellVectors(:,9);
matb_ts.RunOrder = cellVectors(:,10);
matb_ts.Track = data(:,2);
matb_ts.Comm = data(:,3);
matb_ts.ResMan = data(:,4);
matb_ts.Time = data(:,5);

%% Clear temporary variables
clearvars data raw cellVectors R;

save matb_ts;