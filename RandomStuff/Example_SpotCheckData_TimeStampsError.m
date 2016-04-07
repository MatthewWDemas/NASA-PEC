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
STUDY={'CFT','MATB','SIM'};
load ValidationErrors_Total_StarStopTime
% ================================================================
% ============= R-R Intervals ====================================
Hypoxic=[];
NonHypoxic=[];
Train=[]; 



R=2;       % What study you want to run % CTF, MATB , SIM
Sub=10;    % What subject you want to access 
F=2;      % What time we want to access % Train NOnhypoxic Hypoxic 
          % NOTE THAT F changes Depending on protocol .... 

% FAILURE TO RUN!!!  The series tooo short 
% R=1;       % What study you want to run % CTF, MATB , SIM
% Sub=7;    % What subject you want to access 
% F=2;      % What time we want to access % Train NOnhypoxic Hypoxic 

%---------------------
    B=['' 'C:\Users\Nick1Nap\Box Sync\Nasa Flight Data\PEC Study data\*' SubL{Sub} '*' STUDY{R} '*' '']
    Files=dir(B);
    TempName=Files(F).name;
     B=['load  ' TempName]; 
      eval(B) 
      Data=ans'; clear ans;
       SubL(Sub)  
       KILLME=[294.955	895.057	600.102];
      [PtLoc1,PtLoc2,ErrorI] = PreprocessingPoints(KILLME,Data(:,27),Fs)
      
   % Column  EKG=7 
   EKG=Data(:,7);
      
  [hrv, R_t, R_amp, R_index, S_t, S_amp]  = rpeakdetect(Data(1:end,7),Fs);
      
      
      