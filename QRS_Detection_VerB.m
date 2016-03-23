clear all 
close all 
clc 



%============== Initialize Data Set =============================
addpath('C:\Users\Nick1Nap\Box Sync\Nasa Flight Data\PEC Study data')
Fs=256;

SubL= {'04' '05' '06' '07' '08' '09' '10' '11' '12' '13' '15' '16' ...
      '17' '18' '19' '20' '21' '22' '23' '24' '25' ...
      '26' '27' '28' '29' '30' '31' '32' '34' '35' '36' '38' '40' ...
      '41' '42' '44' '45' '46' '47' '48' '50' '51' '52' '53' '54' '55' '56' '57'};

% ================================================================
% ============= R-R Intervals ====================================
Hypoxic=[];
NonHypoxic=[];
Train=[]; 

STUDY={'MATB','SIM'};


for j=1:length(STUDY)
    for S=1:length(SubL);
    B=['' 'C:\Users\Nick1Nap\Box Sync\Nasa Flight Data\PEC Study data\*' SubL{S} '*' STUDY{1} '*' '']
    Files=dir(B);
        
        for i=1: length(Files)

                TempName=Files(i).name;
                Protocol=TempName(10);
                Run= str2num(TempName(16)); % Baseline, Run1 , Run 3 Run2, 1
               
                % PROCESS THE DATA;
                B=['load  ' TempName]; 
                eval(B) 
                Data=ans'; clear ans;
                [hrv, R_t, R_amp, R_index, S_t, S_amp]  = rpeakdetect(Data(2000:end-500,7),Fs);
               
             %figure; plot(Data(2000:15000,7)); title(TempName)
                if (Protocol<='D')

                    if Run==1 % TRAIN
                         Train{S,j}=hrv;
                    elseif Run==2;  % NON HYPOXIC 
                        NonHypoxic{S,j}=hrv;
                    elseif Run==3;   % HYPOXIC 
                        Hypoxic{S,j}=hrv;
                    end 

                elseif (Protocol>'D')
                   
                       if Run==1 % TRAIN
                           Train{S,j}=hrv;
                    elseif Run==2;  % HYPOXIC 
                         Hypoxic{S,j}=hrv;
                    elseif Run==3;   %Non HYPOXIC 
                        NonHypoxic{S,j}=hrv;
                    end          
                           
                end 




             
        end 
    end 
end 
save HRV_SubMATB_SIM_Groups