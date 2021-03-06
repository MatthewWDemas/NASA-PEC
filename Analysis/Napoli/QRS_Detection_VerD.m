clear all 
close all 
clc 



%============== Initialize Data Set =============================
addpath('C:\Users\Nick1Nap\Box Sync\Nasa Flight Data\PEC Study data')
Fs=256;

SubL= {'04' '05' '06' '07' '08' '09' '10' '11' '12' '13' '15' '16' ...
      '17' '18' '19' '20' '21' '22' '23' '24' '25' ...
      '26' '27' '28' '29' '30' '31' '32' '33' '34' '35' '36' '38' '40' ...
      '41' '42' '44' '45' '46' '47' '48' '50' '51' '52' '53' '54' '55' '56' '57'};

% ================================================================
% ============= R-R Intervals ====================================
A=zeros(49,2); 
Sz=size(A); 
Hypoxic=cell(Sz);
NonHypoxic=cell(Sz);
Train=cell(Sz);

STUDY={'MATB','SIM'};

njn=1;
for j=1:length(STUDY)
    for S=1:length(SubL);
    B=['' 'C:\Users\Nick1Nap\Box Sync\Nasa Flight Data\PEC Study data\*' SubL{S} '*' STUDY{j} '*' '']
    Files=dir(B);
        
        for i=1: length(Files)

                TempName=Files(i).name;
                Protocol=TempName(10);
                Run= str2num(TempName(16)); % Baseline, Run1 , Run 3 Run2, 1
               
                % PROCESS THE DATA;
                B=['load  ' TempName]; 
                eval(B) 
                Data=ans'; clear ans;
                [~,Ni]=findpeaks(Data(:,35));
                
                
                    if ~isempty(Ni)
                        [hrv, R_t, R_amp, R_index, S_t, S_amp]  = rpeakdetect(Data(Ni:Ni+(10*250*60),7),Fs); 
                    else 
                        Ni=floor((length(Data(:,1))-(10*250*60))/2);
                        [hrv, R_t, R_amp, R_index, S_t, S_amp]  = rpeakdetect(Data(Ni:Ni+(10*250*60),7),Fs); 
                        HOLDER{njn}=B;
                        njn=njn+1; 
                    end 
              
               
             %figure; plot(Data(2000:15000,7)); title(TempName)
                if (Protocol<='D')

                    if Run==1 % TRAIN
                         Train{S,j}=[[hrv,nan];R_t;R_amp;R_index];
                         TTest(S,j)=mean(Data(Ni:Ni+250*600,31));  
                    elseif Run==2;  % NON HYPOXIC 
                        NonHypoxic{S,j}=[[hrv,nan];R_t;R_amp;R_index];
                        NHTest(S,j)=mean(Data(Ni:Ni+250*600,31));  
                    elseif Run==3;   % HYPOXIC
                             [~,RecTemp]=findpeaks(Data(Ni:end,31),'MinPeakHeight',60); 
                                    if isempty(RecTemp)
                                        RecTemp=Ni+250*600;
                                    end
                             HTest(S,j)=mean(Data(Ni:RecTemp(1),31));
                             [hrv, R_t, R_amp, R_index, S_t, S_amp]  = rpeakdetect(Data(Ni:RecTemp(1),7),Fs); 
                             Hypoxic{S,j}=[[hrv,nan];R_t;R_amp;R_index];
                             [hrv, R_t, R_amp, R_index, S_t, S_amp]  = rpeakdetect(Data(RecTemp(1):end,7),Fs); 
                             Recovery{S,j}=[[hrv,nan];R_t;R_amp;R_index];  
                             RTest(S,j)=mean(Data(RecTemp(1):end,31));
                    end 

                elseif (Protocol>'D')
                   
                       if Run==1 % TRAIN
                           Train{S,j}=[[hrv,nan];R_t;R_amp;R_index];
                            TTest(S,j)=mean(Data(Ni:Ni+250*600,31));  
                    elseif Run==2;  % HYPOXIC 
                          [~,RecTemp]=findpeaks(Data(Ni:end,31),'MinPeakHeight',60);   
                                    if isempty(RecTemp)
                                        RecTemp=Ni+250*600;
                                    end 
                                [hrv, R_t, R_amp, R_index, S_t, S_amp]  = rpeakdetect(Data(Ni:RecTemp(1),7),Fs); 
                                Hypoxic{S,j}=[[hrv,nan];R_t;R_amp;R_index];
                                [hrv, R_t, R_amp, R_index, S_t, S_amp]  = rpeakdetect(Data(RecTemp(1):end,7),Fs); 
                                Recovery{S,j}=[[hrv,nan];R_t;R_amp;R_index];  
                                HTest(S,j)=mean(Data(Ni:RecTemp(1),31));
                    elseif Run==3;   %Non HYPOXIC 
                        NonHypoxic{S,j}=[[hrv,nan];R_t;R_amp;R_index];
                        NHTest(S,j)=mean(Data(Ni:Ni+250*600,31));  
                    end         
                           
                end 
             
        end 
    end 
end 
save('HRV_SubMATB_SIM_Groups_Total','Train','Hypoxic','NonHypoxic','SubL')