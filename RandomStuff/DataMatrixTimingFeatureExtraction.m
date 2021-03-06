clear all 
close all 
clc 

%-----------------------------------------------------------------
  LP = designfilt('lowpassfir', 'FilterOrder', 100, 'CutoffFrequency', 30, 'StopbandAttenuation', 80, 'SampleRate', 256);
  HP = designfilt('highpassfir', 'FilterOrder', 250, 'CutoffFrequency', 5.5, 'StopbandAttenuation', 90, 'SampleRate', 256);
%============== Initialize Data Set =============================
addpath('C:\Users\Nick1Nap\Box Sync\Nasa Flight Data\PEC Study data')
Fs=256;
load TimeStampsIn; 

SubL= {'04' '05' '06' '07' '08' '09' '10' '11' '12' '13' '15' '16' ...
      '17' '18' '19' '20' '21' '22' '23' '24' '25' ...
      '26' '27' '28' '29' '30' '31' '32' '33' '34' '35' '36' '38' '40' ...
      '41' '42' '44' '45' '46' '47' '48' '50' '51' '52' '53' '54' '55' '56' '57'};
        %---------- Initializing Error Counter ---------------------
                    ErrorT=zeros(49,3)*nan;
                    ErrorNH=zeros(49,3)*nan;  
                    ErrorH=zeros(49,3)*nan; 
       %-------------- Timing --------------------------------------
       Timing=0:120:600;
       % Data Matrix Holdern
       TimeNum=length(Timing)-1; 
       DataM=zeros(TimeNum*49*3*3,39)*nan;
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
for j=1:length(STUDY)
    for S=1:length(SubL);
                   
        % This if state is only here to adjust for the Cog and CTF 
                if j==1 
                    
                    B=['' 'C:\Users\Nick1Nap\Box Sync\Nasa Flight Data\PEC Study data\*' SubL{S} '*' STUDY{j} '*' '']
                    Files=dir(B);
                          if isempty(Files)
                             B=['' 'C:\Users\Nick1Nap\Box Sync\Nasa Flight Data\PEC Study data\*' SubL{S} '*'  'Cog*' '']
                             Files=dir(B);
                          end 
                else
                     B=['' 'C:\Users\Nick1Nap\Box Sync\Nasa Flight Data\PEC Study data\*' SubL{S} '*' STUDY{j} '*' '']
                    Files=dir(B);
                end 
        for i=1: length(Files)
                TempName=Files(i).name;
                Protocol=TempName(10);
                Run= str2num(TempName(16)); % Baseline, Run1 , Run 3 Run2, 1
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
                Data(:,36)=Data(:,27);
                TempEKG = filtfilt(HP,Data(:,7));
                Data(:,7)= filtfilt(LP,TempEKG);
                
                
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
                         %------- Feature Extraction -------------------
                         % EKG=7, Respiration=8 OxygenCon=31,
                         % Run:(Train=1,NonHypoxic=2,Hypoxic=3),
                         % Subject:S, Study: j (Cft=1,Matb=2,SIM=3)
                         [ FeatVect] = FeatureExtractorFull(Data(PtLoc1:PtLoc2,[7,8,31,33,36]),Fs,Timing,Run,S,j,Proto);
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
                         %------- Feature Extraction -------------------
                         % EKG=7, Respiration=8 OxygenCon=31,
                          % Run:(Train=1,NonHypoxic=2,Hypoxic=3),
                         % Subject:S, Study: j (Cft=1,Matb=2,SIM=3)
                         [ FeatVect] = FeatureExtractorFull(Data(PtLoc1:PtLoc2,[7,8,31,33,36]),Fs,Timing,Run,S,j,Proto);
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
                         %------- Feature Extraction -------------------
                         % EKG=7, Respiration=8 OxygenCon=31,
                          % Run:(Train=1,NonHypoxic=2,Hypoxic=3),
                         % Subject:S, Study: j (Cft=1,Matb=2,SIM=3)
                         [ FeatVect] = FeatureExtractorFull(Data(PtLoc1:PtLoc2,[7,8,31,33,36]),Fs,Timing,Run,S,j,Proto);                      
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
                         %---------------------------------------------
                         %------- Feature Extraction -------------------
                         % EKG=7, Respiration=8 OxygenCon=31,
                         % Run:(Train=1,NonHypoxic=2,Hypoxic=3),
                         % Subject:S, Study: j (Cft=1,Matb=2,SIM=3)
                         [ FeatVect] = FeatureExtractorFull(Data(PtLoc1:PtLoc2,[7,8,31,33,36]),Fs,Timing,Run,S,j,Proto);
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
                         %------- Feature Extraction -------------------
                         % EKG=7, Respiration=8 OxygenCon=31,
                          % Run:(Train=1,NonHypoxic=2,Hypoxic=3),
                         % Subject:S, Study: j (Cft=1,Matb=2,SIM=3)
                         [ FeatVect] = FeatureExtractorFull(Data(PtLoc1:PtLoc2,[7,8,31,33,36]),Fs,Timing,(Run+1),S,j,Proto);          
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
                         %------- Feature Extraction -------------------
                         % EKG=7, Respiration=8 OxygenCon=31,
                         % Run:(Train=1,NonHypoxic=2,Hypoxic=3),
                         % Subject:S, Study: j (Cft=1,Matb=2,SIM=3)
                         [ FeatVect] = FeatureExtractorFull(Data(PtLoc1:PtLoc2,[7,8,31,33,36]),Fs,Timing,(Run-1),S,j,Proto);
                    end         
                           
                end 
                %--------- Feature Input ---------------
                DataM(1+((njn-1)*TimeNum):(njn)*TimeNum,:)=FeatVect; 
                njn=njn+1;
        end 
    end 
end 
toc 
save('DataMatrixSeta_ZScoreFullTime_M2')