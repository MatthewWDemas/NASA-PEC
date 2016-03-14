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
STUDY={'MATB','SIM'};
% ================================================================
% ============= R-R Intervals ====================================
Hypoxic=[];
NonHypoxic=[];
Train=[]; 



R=2;       % What study you want to run 
Sub=29;    % What subject you want to access 
F=3 ;      % What time we want to access 

%---------------------
    B=['' 'C:\Users\Nick1Nap\Box Sync\Nasa Flight Data\PEC Study data\*' SubL{Sub} '*' STUDY{R} '*' '']
    Files=dir(B);
    TempName=Files(F).name;
     B=['load  ' TempName]; 
      eval(B) 
      Data=ans'; clear ans;
      
      
   % Column  EKG=7 
   EKG=Data(:,7);
      
  [hrv, R_t, R_amp, R_index, S_t, S_amp]  = rpeakdetect(Data(2000:end-500,7),Fs);
      
      
      