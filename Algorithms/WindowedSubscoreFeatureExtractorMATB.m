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
Temp=Temp(~isnan(Temp));
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
            % This is a hack right now...the GetTrend
            % function requires x-values for plotting
            % functionality only. It returns the
            % difference between the
            x_vals = Temp(IndexTime(i)+1:IndexTime(i+1));
            y_vals = Temp(IndexTime(i)+1:IndexTime(i+1));
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
                x_vals = Temp(IndexTime(i)+1:end);
                y_vals = Temp(IndexTime(i)+1:end);
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
            else
                x_vals = Temp(IndexTime(i)+1:IndexTime(i+1));
                y_vals = Temp(IndexTime(i)+1:IndexTime(i+1));
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
        end
        
    end
else
    output=output;
end
end

