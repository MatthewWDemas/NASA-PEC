function [ output] = PerformOrg(Data,Test,S,Time,Offset)
% addpath('~/Box Sync/Nasa Flight Data/DataAnalysis_Matt/NASA-PEC-MATLAB/')

% Data = Perform{3}{2};
% Test = 3;
% S = 48;
% Time = ;
% Offset = ;

Offset=-1*Offset;
input_output=zeros(length(Time)-1,12)*nan;
output=zeros(length(Time)-1,36)*nan;

switch Test
    %---------------- CFT ------------------------------
    case 1
        output(:,1)=Data(2:end,S);
    %---------------- CogScreen ------------------------
    case 2
        output=output;
    %---------------- MATB -----------------------------
    case 3
        % Construct output vectors for each subscore measure
        % Use WindowedSubscoreFeatureExtractorMATB
        % INPUT: Data, S (Subject), Time, Offset
        % OUTPUT: 5 rows of vector of length 12 that represent the 6
        % features extracted for both the HP measure value and the
        % derivative of the measure value.
        % EXCLUDED: Composite and Room Air Trials
        % Comm 
        output_comm = WindowedSubscoreFeatureExtractorMATB(...
            Data{1}, S, Time, Offset, input_output);
        % ResMan
        output_resman = WindowedSubscoreFeatureExtractorMATB(...
            Data{2}, S, Time, Offset, input_output);
        % Track
        output_track = WindowedSubscoreFeatureExtractorMATB(...
            Data{3}, S, Time, Offset, input_output);
        
        output = horzcat(output_comm, output_resman, output_track);
    %---------------- SIM ------------------------------
    case 4
        output=output;
end
end

