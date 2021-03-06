clear all 
close all 
clc 


%============== Initialize Data Set =============================
% MATT: It seems like we are gonna have a problem if we don't have the same
% extension. Just use your extension below mine and you will just receive a
% warning for mine. Likewise I will receive a warning for yours.
% Set the path here based on what type of computer, and then use it to add
% the path and then later to set the import string.
if strcmp (computer('arch'),'maci64') 
    pec_data_path2 = '~/Box Sync/Nasa Flight Data/PEC Study data/'
else
    pec_data_path2 = 'C:\Users\Nick1Nap\Box Sync\Nasa Flight Data\PEC Study data\'
end
addpath(pec_data_path2);

            %======Additional Paths 
            addpath('../SharedDataExport/');
            addpath('Data')
            addpath('Algorithms')

%-------------------------------------------------------------------------
% Loading Mat Files 
%-------------------------------------------------------------------------
 load DemoFinal;  % Demographic Data
 load TimeStampsIn; 
 load PerformanceCFTMATB; % CFT/MATB Performance Scores
 
 %----Filter Design for the EKG Signals-----------------------------------
  Fs=256;
  LP = designfilt('lowpassfir', 'FilterOrder', 100, 'CutoffFrequency', 30, 'StopbandAttenuation', 80, 'SampleRate', Fs);
  HP = designfilt('highpassfir', 'FilterOrder', 250, 'CutoffFrequency', 5.5, 'StopbandAttenuation', 90, 'SampleRate', Fs);
%-------------------------------------------------------------------------\
% Cell Structure [CFT, COGS, MATB, SIM] % Note: No data for cogs and sim
% IN each cell {RA,SL,15k}
%--------------------------------------------------------'04' '05' '06' '07' '08' '09' '10' '11' '12' '13' '15' '16' ...
SubL= {'04' '05' '06' '07' '08' '09' '10' '11' '12' '13' '15' '16' ...
      '17' '18' '19' '20' '21' '22' '23' '24' ...
      '25' '26' '27' '28' '29' '30' '31' '32' '33' '34' '35' '36' '38' ...
      '40' '41' '42' '44' '45' '46' '47' '48' '50' '51' '52' '53' '54' ...
      '55' '56' '57'};
        %---------- Initializing Error Counter ---------------------
                    ErrorT=zeros(49,3)*nan;
                    ErrorNH=zeros(49,3)*nan;  
                    ErrorH=zeros(49,3)*nan; 
       %-------------- Timing --------------------------------------
       Timing=0:120:600;
       % Data Matrix Holdern
       TimeNum=length(Timing)-1;
       DATAM_WIDTH = 126;
       DataM=zeros(TimeNum*49*3*3,DATAM_WIDTH)*nan;
       
% ================================================================
% ============= R-R Intervals ====================================
A=zeros(49,2); 
Sz=size(A); 
Hypoxic=cell(Sz);
NonHypoxic=cell(Sz);
Train=cell(Sz);

STUDY={'CFT','MATB','SIM'};

njn=1;
tic 
% for j=1:length(STUDY)
for j=2:2 % MATB Only for the moment
    for S=1:length(SubL);
                   
        % This if state is only here to adjust for the Cog and CTF 
                if j==1 
                    
                    B=[pec_data_path2 '*' SubL{S} '*' STUDY{j} '*' '']
                    Files=dir(B);
                    Test=1;
                          if isempty(Files)
                             B=[pec_data_path2 '*' SubL{S} '*'  'Cog*' '']
                             Files=dir(B);
                             Test=2; 
                          end 
                else
                     B=[pec_data_path2 '*' SubL{S} '*' STUDY{j} '*' '']
                    Files=dir(B);
                    Test=j+1;
                end 
        for i=1: length(Files)
                TempName=Files(i).name;
                Protocol=TempName(10);
                Run= str2num(TempName(16)); % Baseline, Run1 , Run 3 Run2, 1
                taskForm = TempName(end-4);
                if taskForm == 'T'
                    taskFormNumber = 0;
                elseif taskForm == '1'
                    taskFormNumber = 1;
                elseif taskForm == '2'
                    taskFormNumber = 2;
                elseif taskForm == '3'
                    taskFormNumber = 1;
                else
                    taskFormNumber = -1;
                end
                    
                %============ Interruption ==================
                if j==1 
                    if (S==7 && Run==1)
                        break
                 
                    end 
                end 
                %============================================
                % PROCESS THE DATA;
                B=['load  ' TempName]; 
                eval(B) 
                Data=ans'; clear ans;
                Data(:,36)=Data(:,7);
                TempEKG = filtfilt(HP,Data(:,7));
                Data(:,7)= filtfilt(LP,TempEKG);
                DemoTemp=Demo(S,[2,6,7,8,9,10]); % Age, Total Flight Hours, Total Flight Years, HRMax,BMI, Gender (f=1,m=2);
                
                if (Protocol<='D')
                   Proto=1;
                    if Run==1 % TRAIN
                         %---------- Data Preprocess -------------------
                         [PtLoc1,PtLoc2,ErrorI] = PreprocessingPoints(TrainS{S,j+1},Data(:,27),Fs);
                         %------ Validation ----------------------------
                         ErrorT(S,j)=ErrorI;
                         LocationsT(S,(j*2)-1:j*2)=[PtLoc1,PtLoc2];
                         [~,TLoc]=findpeaks(Data(:,35));
                          if ~isempty(TLoc)
                              TAdjust_T(S,j)=(TLoc(1)-PtLoc1)/256;
                          else
                               TAdjust_T(S,j)=nan;
                          end 
                         %------ Preformance ------------------------------
                         CompPerform=PerformOrg(Perform{Test}{Run},Test,S,Timing,TAdjust_T(S,j)); % MatB data for 
                         
                         %------- Feature Extraction -------------------
                         % EKG=7, Respiration=8 OxygenCon=31,
                         % Run:(Train=1,NonHypoxic=2,Hypoxic=3),
                         % Subject:S, Study: j (Cft=1,Matb=2,SIM=3)
                         [ FeatVect] = FeatureExtractorFull(Data(PtLoc1:PtLoc2,[7,8,31,33,36]),DemoTemp,CompPerform,Fs,Timing,Run,S,Test,Proto,taskFormNumber);
                         %----------------------------------------------
                    elseif Run==2;  % NON HYPOXIC 
                         %---------- Data Preprocess -------------------
                         [PtLoc1,PtLoc2,ErrorI] = PreprocessingPoints(NonHypoxiaS{S,j+1},Data(:,27),Fs); 
                         %------ Validation ---------
                         ErrorNH(S,j)=ErrorI;
                         LocationsNH(S,(j*2)-1:j*2)=[PtLoc1,PtLoc2];
                         % Time Delta 
                         [~,TLoc]=findpeaks(Data(:,35));
                          if ~isempty(TLoc)
                              TAdjust_NH(S,j)=(TLoc(1)-PtLoc1)/256;
                          else 
                             TAdjust_NH(S,j)=nan; 
                          end 
                         %------ Preformance ------------------------------
                         CompPerform=PerformOrg(Perform{Test}{Run},Test,S,Timing,TAdjust_NH(S,j)); 
                         %------- Feature Extraction -------------------
                         % EKG=7, Respiration=8 OxygenCon=31,
                          % Run:(Train=1,NonHypoxic=2,Hypoxic=3),
                         % Subject:S, Study: j (Cft=1,Matb=2,SIM=3)
                         [ FeatVect] = FeatureExtractorFull(Data(PtLoc1:PtLoc2,[7,8,31,33,36]),DemoTemp,CompPerform,Fs,Timing,Run,S,Test,Proto,taskFormNumber);
                    elseif Run==3;  % HYPOXIC
                         %---------- Data Preprocess -------------------
                         [PtLoc1,PtLoc2,ErrorI] = PreprocessingPoints(HypoxiaS{S,j+1},Data(:,27),Fs);
                         %------ Validation ---------
                         ErrorH(S,j)=ErrorI;
                         LocationsH(S,(j*2)-1:j*2)=[PtLoc1,PtLoc2];
                         % Time Delta 
                         [~,TLoc]=findpeaks(Data(:,35));
                          if ~isempty(TLoc)
                              TAdjust_H(S,j)=(TLoc(1)-PtLoc1)/256;
                          else 
                              TAdjust_H(S,j)=nan; 
                          end 
                         %------ Preformance ------------------------------
                         CompPerform=PerformOrg(Perform{Test}{Run},Test,S,Timing,TAdjust_H(S,j));  
                         %------- Feature Extraction -------------------
                         % EKG=7, Respiration=8 OxygenCon=31,
                          % Run:(Train=1,NonHypoxic=2,Hypoxic=3),
                         % Subject:S, Study: j (Cft=1,Matb=2,SIM=3)
                         [ FeatVect] = FeatureExtractorFull(Data(PtLoc1:PtLoc2,[7,8,31,33,36]),DemoTemp,CompPerform,Fs,Timing,Run,S,Test,Proto,taskFormNumber);                      
                    end 

                elseif (Protocol>'D')
                    Proto=2;
                    if Run==1 % TRAIN
                        %---------- Data Preprocess -------------------
                        [PtLoc1,PtLoc2,ErrorI] = PreprocessingPoints(TrainS{S,j+1},Data(:,27),Fs);
                        %----------- Validation ------------------------
                         ErrorT(S,j)=ErrorI;
                         LocationsT(S,(j*2)-1:j*2)=[PtLoc1,PtLoc2];
                         [~,TLoc]=findpeaks(Data(:,35));
                          if ~isempty(TLoc)
                              TAdjust_T(S,j)=(TLoc(1)-PtLoc1)/256;
                          else
                               TAdjust_T(S,j)=nan;
                          end 
                         %------ Preformance ------------------------------
                         CompPerform=PerformOrg(Perform{Test}{Run},Test,S,Timing,TAdjust_T(S,j));  
                         %---------------------------------------------
                         %------- Feature Extraction -------------------
                         % EKG=7, Respiration=8 OxygenCon=31,
                         % Run:(Train=1,NonHypoxic=2,Hypoxic=3),
                         % Subject:S, Study: j (Cft=1,Matb=2,SIM=3)
                         [ FeatVect] = FeatureExtractorFull(Data(PtLoc1:PtLoc2,[7,8,31,33,36]),DemoTemp,CompPerform,Fs,Timing,Run,S,Test,Proto,taskFormNumber);
                    elseif Run==2;  % HYPOXIC 
                       %---------- Data Preprocess -------------------
                       [PtLoc1,PtLoc2,ErrorI] = PreprocessingPoints(HypoxiaS{S,j+1},Data(:,27),Fs);
                       %------ Validation ---------
                       ErrorH(S,j)=ErrorI;
                       LocationsH(S,(j*2)-1:j*2)=[PtLoc1,PtLoc2];
                          % Time Delta 
                         [~,TLoc]=findpeaks(Data(:,35));
                          if ~isempty(TLoc)
                              TAdjust_H(S,j)=(TLoc(1)-PtLoc1)/256;
                          else 
                              TAdjust_H(S,j)=nan; 
                          end
                          %------ Performance ------------------------------
                         CompPerform=PerformOrg(Perform{Test}{Run+1},Test,S,Timing,TAdjust_H(S,j));  
                         %------- Feature Extraction -------------------
                         % EKG=7, Respiration=8 OxygenCon=31,
                          % Run:(Train=1,NonHypoxic=2,Hypoxic=3),
                         % Subject:S, Study: j (Cft=1,Matb=2,SIM=3)
                         [ FeatVect] = FeatureExtractorFull(Data(PtLoc1:PtLoc2,[7,8,31,33,36]),DemoTemp,CompPerform,Fs,Timing,(Run+1),S,Test,Proto,taskFormNumber);          
                    elseif Run==3;   %Non HYPOXIC 
                       %---------- Data Preprocess -------------------                       
                       [PtLoc1,PtLoc2,ErrorI] = PreprocessingPoints(NonHypoxiaS{S,j+1},Data(:,27),Fs);
                       %------ Validation ---------
                       ErrorNH(S,j)=ErrorI;
                        LocationsNH(S,(j*2)-1:j*2)=[PtLoc1,PtLoc2];
                          % Time Delta 
                         [~,TLoc]=findpeaks(Data(:,35));
                          if  ~isempty(TLoc)
                              TAdjust_NH(S,j)=(TLoc(1)-PtLoc1)/256;
                          else 
                              TAdjust_NH(S,j)=nan; 
                          end 
                         %------ Performance ------------------------------
                         CompPerform=PerformOrg(Perform{Test}{Run-1},Test,S,Timing,TAdjust_NH(S,j));   
                         %------- Feature Extraction -------------------
                         % EKG=7, Respiration=8 OxygenCon=31,
                         % Run:(Train=1,NonHypoxic=2,Hypoxic=3),
                         % Subject:S, Study: j (Cft=1,Matb=2,SIM=3)
                         [ FeatVect] = FeatureExtractorFull(Data(PtLoc1:PtLoc2,[7,8,31,33,36]),DemoTemp,CompPerform,Fs,Timing,(Run-1),S,Test,Proto,taskFormNumber);
                    end         
                           
                end 
                %--------- Feature Input ---------------
                DataM(1+((njn-1)*TimeNum):(njn)*TimeNum,:) = FeatVect; 
                njn=njn+1;
        end              
    end 
end


  
toc 
% save('./Data/DataMatrixSeta_ZScoreFullTime_M3_2016_04_08_v2.mat')
% save('./Data/DataMatrixSeta_ZScoreFullTime_M3_2016_04_28_v3.mat')
% save('./Data/DataMatrixSeta_ZScoreFullTime_M3_2016_04_29_v4.mat')
% v5: NaNs removed on Time Instance Level, Unstacking Error Corrected
% save('./Data/DataMatrixSeta_ZScoreFullTime_M3_2016_04_29_v5.mat')
% v6: v5 + Form Number Included for MATB event count feature
% save('./Data/DataMatrixSeta_ZScoreFullTime_M3_2016_05_02_v6.mat')
% v7: v6 with new physio interactions interspersed in positions 109 to 114
% save('./Data/DataMatrixSeta_ZScoreFullTime_M3_2016_05_05_v7.mat')
% v8: v7 with column positions corrected
save('./Data/DataMatrixSeta_ZScoreFullTime_M3_2016_05_25_v8.mat')


