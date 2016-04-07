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

Groups={'T' , '1' ,'2'}
% ================================================================
% ============= R-R Intervals ====================================

for i=1: length(SubL)
    
    for j=1:length(Groups)
        
        %--------------------------
        % Pull Random Lettering 
        B=['C:\Users\Nick1Nap\Box Sync\Nasa Flight Data\PEC Study data\PEC_S' SubL{i} '*'] ;
        d = dir(B);
        RandL=d(1).name(10);
        % ----
        B=['load PEC_S' SubL{i} '_P' RandL '_S1_R' num2str(j) '_CFT' Groups{j} '']; 
        eval(B) 
        Data=ans'; clear ans;
        [hrv, R_t, R_amp, R_index, S_t, S_amp]  = rpeakdetect(Data(:,7),Fs);
        HRV_Sub_CFT{i}{j}=[R_t;R_amp;R_index];
    end 
end 

save HRV_SubCFT_Groups