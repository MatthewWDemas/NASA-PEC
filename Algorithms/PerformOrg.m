function [ output] = PerformOrg(Data,Test,S,Time,Offset)

Offset=-1*Offset;
input_output=zeros(length(Time)-1,14)*nan;
output=zeros(length(Time)-1,42)*nan;

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
        % OUTPUT: N rows (currently 5, depending on number of time 
        % intervals specified of vector of length M (currently 12) that 
        % represents the 6 features extracted for both the HP measure 
        % value and the derivative of the measure value.
        % EXCLUDED: Composite and Room Air Trials
        %
        % Comm 
        output_comm = WindowedSubscoreFeatureExtractorMATB(...
            Data{1}, S, Time, Offset, input_output);
        % ResMan
        output_resman = WindowedSubscoreFeatureExtractorMATB(...
            Data{2}, S, Time, Offset, input_output);
        % Track
        output_track = WindowedSubscoreFeatureExtractorMATB(...
            Data{3}, S, Time, Offset, input_output);
        
        output = horzcat(output_comm(:,1:12), output_resman(:,1:12),...
            output_track(:,1:12), output_comm(:,13:14), output_resman(:,13:14),...
            output_track(:,13:14));
    %---------------- SIM ------------------------------
    case 4
        output=output;
end
end

