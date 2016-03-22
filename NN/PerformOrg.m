function [ output] = PerformOrg(Data,Test,S,Time,Offset)
% addpath('~/Box Sync/Nasa Flight Data/DataAnalysis_Matt/NASA-PEC-MATLAB/')

% Data = 

Offset=-1*Offset;
output=zeros(length(Time)-1,12)*nan;
switch Test
%---------------- SIM ------------------------------
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
        Composite
        Comm
        ResMan
        Track
%---------------- SIM ------------------------------
    case 4
        output=output;
end
end

