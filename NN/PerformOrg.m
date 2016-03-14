function [ output] = PerformOrg(Data,Test,S,Time,Offset)

Offset=-1*Offset; 
output=zeros(length(Time)-1,2)*nan;
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
        DT=length(Temp)*5;   % Sampling at 5 seconds: This is the time interval
                 if isnan(Offset)  % if there is no experimental marker we assume 60 seconds
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
                                % OUTPUT of the Peformance 
                                    % Mean Value 
                                output(i,1)=mean(Temp(IndexTime(i)+1:IndexTime(i+1)));
                                    % Max Value 
                                output(i,2)=max(Temp(IndexTime(i)+1:IndexTime(i+1)));
                                

                            end 
                     else 
                         OffsetIndex=floor(Offset+TDiff)/5;
                         if OffsetIndex<1
                             OffsetIndex=1;
                         end 
                         Data=Data(OffsetIndex:end);
                         IndexTime=Time/5;
                            for i=1:length(IndexTime)-1 % This forloop does the time segment increments 
                                if i==(length(IndexTime)-1)
                                % OUTPUT of the Peformance 
                                output(i,1)=mean(Temp(IndexTime(i)+1:end));
                                     % Max Value 
                                output(i,2)=mean(Temp(IndexTime(i)+1:end));
                                else
                                % OUTPUT of the Peformance 
                                output(i,1)=mean(Temp(IndexTime(i)+1:IndexTime(i+1)));
                                     % Max Val                                
                                output(i,2)=max(Temp(IndexTime(i)+1:IndexTime(i+1)));
                                
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

