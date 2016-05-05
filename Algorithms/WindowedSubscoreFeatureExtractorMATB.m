function [ output ] = WindowedSubscoreFeatureExtractorMATB( Data, S, ...
    Time, Offset, output)
%WindowedSubscoreFeatureExtractorMATB Calculates features from given MATB
%subscore.
%   INPUT: Data, S (Subject), Time, Offset
%   OUTPUT: 5 rows of vector of length 12 that represent the 6
%   features extracted for both the HP measure value and the
%   derivative of the measure value.

%   Original data contained a header row, new data does not.
% Temp=Data(2:end,S);
Temp=Data(:,S);
% Temp=Temp(~isnan(Temp));
if ~isempty(Temp)
    % Sampling at 5 seconds: This is the time interval.
    DT=length(Temp)*5;
    % if there is no experimental marker we assume 60 seconds
    if isnan(Offset)
        Offset=60;
    end
    TDiff=DT-(Time(end)+Offset); % Time Difference;
    if TDiff>0
        OffsetIndex=ceil(Offset/5);
        if OffsetIndex<1
            OffsetIndex=1;
        end
        Data=Data(OffsetIndex:end);
        IndexTime=Time/5;
        for i=1:length(IndexTime)-1

            % Get the data within the given time instance.
            score_values = Temp(IndexTime(i)+1:IndexTime(i+1));
%             x_vals = Temp(IndexTime(i)+1:IndexTime(i+1));
%             y_vals = Temp(IndexTime(i)+1:IndexTime(i+1));
            % Remove the NaNs from the current time instance.
            score_values_nonan = score_values(~isnan(score_values));
            % Print the Subject, Time Instance, and Number of Removed NaNs
            [S i sum(isnan(score_values)) TDiff DT OffsetIndex]
            
            % Set y-score values to the NaN removed data.
            x_vals = score_values_nonan; % This is a hack right now...the GetTrend
            % function requires x-values for plotting
            % functionality only. It returns the
            % difference between the y values at the start/end of a given
            % time instance for the "slope".
            y_vals = score_values_nonan; 
            % If all values in score_values are NaNs...replace output
            % with NaNs.
            if isempty(score_values_nonan)
                output = nan * ones(i, 14);
            else
                % Get Trend and Remove for Calculation of Derviative-based
                % Features
                [~, ~, y_vals_detrend] = GetTrend(x_vals, y_vals);
                dy_val_dt = diff(y_vals_detrend);
                % Calculate features
                [output(i,1), output(i,2), output(i,3), ...
                    output(i,4), output(i,5), ~, ...
                    output(i,6)] = ...
                    FeaturesTS(x_vals, y_vals);
                [output(i,7), output(i,8), output(i,9), ...
                    output(i,10), output(i,11), ~, ...
                    output(i,12)] = ...
                    FeaturesTS(dy_val_dt, dy_val_dt);
            end
            % Add Information for Offset Index selected and number of
            % Nan values.
            output(i,13) = OffsetIndex;
            output(i,14) = sum(isnan(score_values));
        end
    else
        OffsetIndex=floor(Offset+TDiff)/5;
        if OffsetIndex<1
            OffsetIndex=1;
        end
        Data = Data(OffsetIndex:end);
        IndexTime = Time/5;
        % This forloop does the time segment increments
        for i=1:length(IndexTime)-1
            if i==(length(IndexTime)-1)
                % Get the data within the given time instance.
                score_values = Temp(IndexTime(i)+1:end);
%                 x_vals = Temp(IndexTime(i)+1:end);
%                 y_vals = Temp(IndexTime(i)+1:end);
                % Remove the NaNs from the current time instance.
                score_values_nonan = score_values(~isnan(score_values));
                % Print the Subject, Time Instance, and Number of Removed NaNs
                [S i sum(isnan(score_values)) TDiff DT OffsetIndex]
                % Set score values to the NaN removed data.
                x_vals = score_values_nonan;
                y_vals = score_values_nonan;
                % If all values in score_values are NaNs...replace output
                % with NaNs.
                if isempty(score_values_nonan)
                    output = nan * ones(i, 14);
                else
                    [~, ~, y_vals_detrend] = GetTrend(x_vals, y_vals);
                    dy_val_dt = diff(y_vals_detrend);
                    [output(i,1), output(i,2), output(i,3), ...
                        output(i,4), output(i,5), ~, ...
                        output(i,6)] = ...
                        FeaturesTS(x_vals, y_vals);
                    [output(i,7), output(i,8), output(i,9), ...
                        output(i,10), output(i,11), ~, ...
                        output(i,12)] = ...
                        FeaturesTS(dy_val_dt, dy_val_dt);
                end
                % Add Information for Offset Index selected and number of
                % Nan values.
                output(i,13) = OffsetIndex;
                output(i,14) = sum(isnan(score_values));
            else
                % Get the data within the given time instance.
                score_values = Temp(IndexTime(i)+1:IndexTime(i+1));
%                 x_vals = Temp(IndexTime(i)+1:IndexTime(i+1));
%                 y_vals = Temp(IndexTime(i)+1:IndexTime(i+1));
                % Remove the NaNs from the current time instance.
                score_values_nonan = score_values(~isnan(score_values));
                % Print the Subject, Time Instance, and Number of Removed NaNs
                [S i sum(isnan(score_values)) TDiff DT OffsetIndex]
                % Set score values to the NaN removed data.
                x_vals = score_values_nonan;
                y_vals = score_values_nonan;
                % If all values in score_values are NaNs...replace output
                % with NaNs.
                if isempty(score_values_nonan)
                    output = nan * ones(i, 14);
                else
                    [~, ~, y_vals_detrend] = GetTrend(x_vals, y_vals);
                    dy_val_dt = diff(y_vals_detrend);
                    [output(i,1), output(i,2), output(i,3),...
                        output(i,4), output(i,5), ~,...
                        output(i,6)] = ...
                        FeaturesTS(x_vals, y_vals);
                    [output(i,7), output(i,8), output(i,9), ...
                        output(i,10), output(i,11), ~, ...
                        output(i,12)] = ...
                        FeaturesTS(dy_val_dt, dy_val_dt);
                end
                % Add Information for Offset Index selected and number of
                % Nan values.
                output(i,13) = OffsetIndex;
                output(i,14) = sum(isnan(score_values));
            end
        end
        
    end
else
    output=output;
end
end


% TO DO:
% - Implement confidence measure based on the number of NaNs in a given
% Time Instance.
