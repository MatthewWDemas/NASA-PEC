clear all 
close all 
clc 

%-----------------------------------------------------------------
  LP = designfilt('lowpassfir', 'FilterOrder', 100, 'CutoffFrequency', 30, 'StopbandAttenuation', 80, 'SampleRate', 256);
  HP = designfilt('highpassfir', 'FilterOrder', 250, 'CutoffFrequency', 5.5, 'StopbandAttenuation', 90, 'SampleRate', 256);
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

STUDY={'CFT','MATB','SIM'};

njn=1;
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

                if j==1 
                    
                    if S==7 
                        break
                    end 
                    
                end 
                TempName=Files(i).name;
                Protocol=TempName(10);
                Run= str2num(TempName(16)); % Baseline, Run1 , Run 3 Run2, 1
               
                % PROCESS THE DATA;
                B=['load  ' TempName]; 
                eval(B) 
                Data=ans'; clear ans;
                [~,Ni]=findpeaks(Data(:,35));
                
               
                    if ~isempty(Ni)
                        Ni=Ni(1); 
                    else 
                        Ni=floor((length(Data(:,1))-(10*250*60))/2);
                    end 
              
               
             %figure; plot(Data(2000:15000,7)); title(TempName)
                if (Protocol<='D')

                    if Run==1 % TRAIN
                         O2PointTrain(S,j)=mean(Data(Ni:Ni+250,31));  
                    elseif Run==2;  % NON HYPOXIC 
                         O2PointNonHyp(S,j)=mean(Data(Ni:Ni+250,31));  
                    elseif Run==3;  % HYPOXIC
                         O2PointHyp(S,j)=mean(Data(Ni:Ni+250,31));    
                    end 
                elseif (Protocol>'D')
                   
                    if Run==1 % TRAIN
                             O2PointTrain(S,j)=mean(Data(Ni:Ni+250,31));  
                    elseif Run==2;  % HYPOXIC 
                         O2PointHyp(S,j)=mean(Data(Ni:Ni+250,31));
                    elseif Run==3;   %Non HYPOXIC 
                        O2PointNonHyp(S,j)=mean(Data(Ni:Ni+250,31));  
                    end         
                           
                end 
             
        end 
    end 
end 
save('QualityTestO2Concentration','O2PointNonHyp','O2PointHyp','O2PointTrain')