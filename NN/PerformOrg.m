function [ output] = PerformOrg(Data,Test,S,Time,Offset)
% addpath('~/Box Sync/Nasa Flight Data/DataAnalysis_Matt/NASA-PEC-MATLAB/')
Offset=-1*Offset; 
output=zeros(length(Time)-1,12)*nan;
switch Test

    %Case for CFT 
    case 1
        output(:,1)=Data(2:end,S);
    %Case for Cogn Screen 
    case 2
        output=output;
    %Case for Matb      
    case 3
        Temp=Data(2:end,S); 
        Temp=Temp(~isnan(Temp)); 
        if ~isempty(Temp)
        DT=length(Temp)*5;   % Sampling at 5 seconds: This is the time 
                             % interval
                 if isnan(Offset)  % if there is no experimental marker we 
                                   % assume 60 seconds
                     Offset=60; 
                 end 
        TDiff=DT-(Time(end)+Offset); % TIme Difference;
        
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
                                dy_val_dt = diff(y_vals);
%                                 % OUTPUT of the Peformance 
%                                     % Mean Value 
%                                 output(i,1)=mean(Temp(IndexTime(i)+1:...
%                                                  IndexTime(i+1)));
%                                     % Max Value 
%                                 output(i,2)=max(Temp(IndexTime(i)+1:...
%                                                 IndexTime(i+1)));

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
                         Data=Data(OffsetIndex:end);
                         IndexTime=Time/5;
                            for i=1:length(IndexTime)-1 % This forloop does 
                                                        % the time segment 
                                                        % increments 
                                IndexTime(i)
                                if i==(length(IndexTime)-1)
                                    x_vals = Temp(IndexTime(i)+1:end);
                                    y_vals = Temp(IndexTime(i)+1:end);
                                    dy_val_dt = diff(y_vals);
                                % OUTPUT of the Peformance 
%                                 output(i,1)=mean(Temp(IndexTime(i)+1:end));
%                                      % Max Value 
%                                 output(i,2)=mean(Temp(IndexTime(i)+1:end));
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
                                    dy_val_dt = diff(y_vals);
%                                 % OUTPUT of the Peformance 
%                                 output(i,1)=mean(Temp(IndexTime(i)+1:IndexTime(i+1)));
%                                      % Max Val                                
%                                 output(i,2)=max(Temp(IndexTime(i)+1:IndexTime(i+1)));
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
             
    %Case for SIM 
    case 4
        output=output;
end 



end

