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

% ================================================================
% ============= R-R Intervals ====================================
A=zeros(49,2); 
Sz=size(A); 
Hypoxic=cell(Sz);
NonHypoxic=cell(Sz);
Train=cell(Sz);

STUDY={'CFT','MATB','SIM'};
%STUDY={'SIM'};

njn=1;
for j=1:length(STUDY)
    for S=1:length(SubL);
                   
        % This if state is only here to adjust for the Cog and CTF 
                if j==1 
                    
                    B=['' 'C:\Users\Nick1Nap\Box Sync\Nasa Flight Data\PEC Study data\*' SubL{S} '*' STUDY{j} '*' ''];
                    Files=dir(B);
                          if isempty(Files)
                             B=['' 'C:\Users\Nick1Nap\Box Sync\Nasa Flight Data\PEC Study data\*' SubL{S} '*'  'Cog*' ''];
                             Files=dir(B);
                          end 
                else
                     B=['' 'C:\Users\Nick1Nap\Box Sync\Nasa Flight Data\PEC Study data\*' SubL{S} '*' STUDY{j} '*' ''];
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
                TempEKG = filtfilt(HP,Data(:,7));
                Data(:,7)= filtfilt(LP,TempEKG);
                Offset=Data(1,27);
                
               
                if (Protocol<='D')

                    if Run==1 % TRAIN
                         %---------- Data Preprocess -------------------
                             %----- Start Point --------
                             Stamps=TrainS{S,j+1};
                             [~,PtLoc1]=min(abs(Stamps(1)-Data(:,27)));
                             %----- Ending Point -------
                             [~,PtLoc2]=min(abs(Stamps(2)-Data(:,27)));
                             %------ Validation ---------
                             ErrorT{S,j}=PtLoc2-(PtLoc1+floor(Stamps(3)*Fs));
                             %---------------------------
                         Temp=Data(PtLoc1:PtLoc2,7);
                         %----------------------------------------------
                         [hrv, R_t, R_amp, R_index, S_t, S_amp]  = rpeakdetectNapoli(Temp,Fs); 
                         Train{S,j}=[[hrv,nan];R_t;R_amp;R_index];
                    elseif Run==2;  % NON HYPOXIC 
                         %---------- Data Preprocess -------------------
                             %----- Start Point --------
                              Stamps=NonHypoxiaS{S,j+1};
                              [~,PtLoc1]=min(abs(Stamps(1)-Data(:,27)));
                             %----- Ending Point -------
                             [~,PtLoc2]=min(abs(Stamps(2)-Data(:,27)));
                             %------ Validation ---------
                             ErrorNH{S,j}=PtLoc2-(PtLoc1+floor(Stamps(3)*Fs));
                             %---------------------------
                             Temp=Data(PtLoc1:PtLoc2,7);
                         %----------------------------------------------                        
                         [hrv, R_t, R_amp, R_index, S_t, S_amp]  = rpeakdetectNapoli(Temp,Fs); 
                         NonHypoxic{S,j}=[[hrv,nan];R_t;R_amp;R_index];
                    elseif Run==3;  % HYPOXIC
                        %---------- Data Preprocess -------------------
                             %----- Start Point --------
                              Stamps=HypoxiaS{S,j+1};
                              [~,PtLoc1]=min(abs(Stamps(1)-Data(:,27)));
                             %----- Ending Point -------
                             [~,PtLoc2]=min(abs(Stamps(2)-Data(:,27)));
                             %------ Validation ---------
                             ErrorH{S,j}=PtLoc2-(PtLoc1+floor(Stamps(3)*Fs));
                             %---------------------------
                             Temp=Data(PtLoc1:PtLoc2,7);
                         %----------------------------------------------                
                         [hrv, R_t, R_amp, R_index, S_t, S_amp]  = rpeakdetectNapoli(Temp,Fs); 
                         Hypoxic{S,j}=[[hrv,nan];R_t;R_amp;R_index];                         
                    end 

                elseif (Protocol>'D')
                   
                    if Run==1 % TRAIN
                          %---------- Data Preprocess -------------------\
                             %---- Starting Point 
                             Stamps=TrainS{S,j+1};
                             [~,PtLoc1]=min(abs(Stamps(1)-Data(:,27)));
                             %----- Ending Point -------
                             [~,PtLoc2]=min(abs(Stamps(2)-Data(:,27)));
                             %------ Validation ---------
                             ErrorT{S,j}=PtLoc2-(PtLoc1+floor(Stamps(3)*Fs));
                             %---------------------------
                             Temp=Data(PtLoc1:PtLoc2,7);
                         %----------------------------------------------
                          [hrv, R_t, R_amp, R_index, S_t, S_amp]  = rpeakdetectNapoli(Temp,Fs); 
                          Train{S,j}=[[hrv,nan];R_t;R_amp;R_index];
                    elseif Run==2;  % HYPOXIC 
                        %---------- Data Preprocess -------------------
                             %----- Start Point --------
                              Stamps=HypoxiaS{S,j+1};
                              [~,PtLoc1]=min(abs(Stamps(1)-Data(:,27)));
                             %----- Ending Point -------
                             [~,PtLoc2]=min(abs(Stamps(2)-Data(:,27)));
                             %------ Validation ---------
                             ErrorH{S,j}=PtLoc2-(PtLoc1+floor(Stamps(3)*Fs));
                             %---------------------------
                             Temp=Data(PtLoc1:PtLoc2,7);
                         %---------------------------------------------- 
                         [hrv, R_t, R_amp, R_index, S_t, S_amp]  = rpeakdetectNapoli(Temp,Fs); 
                         Hypoxic{S,j}=[[hrv,nan];R_t;R_amp;R_index];              
                    elseif Run==3;   %Non HYPOXIC 
                        %---------- Data Preprocess -------------------
                             %----- Start Point --------
                              Stamps=NonHypoxiaS{S,j+1};
                              [~,PtLoc1]=min(abs(Stamps(1)-Data(:,27)));
                             %----- Ending Point -------
                             [~,PtLoc2]=min(abs(Stamps(2)-Data(:,27)));
                             %------ Validation ---------
                             ErrorNH{S,j}=PtLoc2-(PtLoc1+floor(Stamps(3)*Fs));
                             %---------------------------
                             Temp=Data(PtLoc1:PtLoc2,7);
                         %----------------------------------------------  
                         [hrv, R_t, R_amp, R_index, S_t, S_amp]  = rpeakdetectNapoli(Temp,Fs); 
                         NonHypoxic{S,j}=[[hrv,nan];R_t;R_amp;R_index];
                    end         
                           
                end 
             
        end 
    end 
end 
save('HRV_SubMATB_SIM_Groups_Total_StarStopTimeB','Train','Hypoxic','NonHypoxic','ErrorNH','ErrorH','ErrorT')