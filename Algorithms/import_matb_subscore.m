function [ matb_ts_array ] = import_matb_subscore(Data, Run, Scoretype)
%import_matb_subscore Imports MATB subscore for all participants in wide
%format for a given Run (1=Room Air, 2=Sea Level/non-hypoxic, 3=15k
%ft/hypoxic)
%   
    
%     Variable Def'n for Testing Purposes
%         Data = matb_ts_pec;
%         Run = 2;
%         RunStr = num2str(Run,1);
%         Scoretype = 'Comm';

%     addpath(...
%         '~/Box Sync/Nasa Flight Data/DataAnalysis_Matt/NASA-PEC-MATLAB/');
%     
%     % call to import pec_data
%     % call to import matb_ts
%     load pec_data;
%     load matb_ts;
% 
%     % Join tables and select numerical values
%     pec_data.Session = categorical(pec_data.Session);
%     matb_ts_pec = innerjoin(...
%         pec_data(pec_data.Session == 'MATB', [1:10 100:104]), ...
%         matb_ts,...
%         'Keys', {'Subject', 'Run'});
    
    
    % Select only:
    % (1) necessary columns 
    % (2) desired run
    % (3) Score Column
    % (4) 
    % Subject (PartNumber: 1-49), Run (TypeOfRun 1-3), Score Column (Comm,
    % ResMan, Track)
    
    Data = Data(Data.TypeofRun == Run,...
        {'Time' 'PartNumber' Scoretype});
%         {'PartNumber' Scoretype});
    
    % Unstack does not behave as unstack in R
    % Times are out of order and then appended to the end
    Data.Time = floor(Data.Time);
    
    % Unstack to make it a long table
    matb_ts_pec_wide = unstack(Data, Scoretype, 'PartNumber');
   
    % Convert to numerical array
    % but ignore the "time column" (column 1)
    matb_ts_array = table2array(matb_ts_pec_wide(:,2:end));

%     MATBRA_Track
%     MATBSL_Track
%     MATB15k_Track
% 
% 
% 
%     MATBRA = {CommRA, ResManRA, TrackingRA};
%     MATBSL = {CommSL, ResManSL, TrackingSL};
%     MATB15k = {Comm15k, ResMan15k, Tracking15k};
% 
%     Perform{3} = {MATBRA, MATBSL, MATB15k};
end