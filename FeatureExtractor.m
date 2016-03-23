function [ FeatureM ] = FeatureExtractor(Data,Fs,Timing,RunHTnH,Subject,Study,Proto)
%---------------------------------------------
% Input Variable 
%----------------------------------------------
% Timing: The segmentation of Time Series Data 
% RunHTnH: The type of run that occured ( Training, NonHypoxic,Hypoxic,)
% Subject: the particapte number related to the subject 
% Proto: The order of the experiments (Protocols after D are Labeled 2, otherwise they are labeled 1)
%---------------------------------------------
% Data: Col1=EKG, Col2=Respiration, Col3=O2Cont
%---------------------------------------------
% OUTPUT Variable
%---------------------------------------------
    % Column Labels: Col1=AveHR, Col2=SampEn, Col3=RespirVolEnt Col4=O2 ,
    % Col5= TimeInstance
    % Row is Timing Instance 
FeatureM=zeros(length(Timing)-1,5); 
M_HR=2;
M_Resp=2;
%-------------------------------------------------
% Calculate R-R Intervals Prior 
[hrv, R_t,~, R_index, S_t,~]  = rpeakdetectNapoli(Data(:,1),Fs);
%--------------------------------------------------      
        
        for i=1:length(Timing)-1
        % Timing Relative to EKG
            [Pt1,~]=min(find(R_t>=Timing(i)));
            [Pt2,~]=max(find(R_t<=Timing(i+1)));
        %----------- EKG Data------------------------
                %------ AverageHR----------
                 TL=(Timing(i+1)-Timing(i))/60; 
                 FeatureM(i,1)=(Pt2-Pt1)/TL;
                %------ Sample Entropy R-R -----
                Temp=zscore(diff(R_t(Pt1:Pt2)));
                FeatureM(i,2)=SampEn(M_HR,.2,Temp);
                %------ Sample Entropy R-S -----
                Temp=zscore((R_t(Pt1:Pt2)-S_t(Pt1:Pt2)));
                FeatureM(i,3)=SampEn(M_HR,.2,Temp);
                %------ Sample Entropy S-S -----
               Temp=zscore(diff(S_t(Pt1:Pt2)));
                FeatureM(i,4)=SampEn(M_HR,.2,Temp);
                %------ P and T Wave Complexity----
                % Feature 5 
        %----------- Respiration --------------------
             % Respiration Vol Complexity
                Temp=zscore(Data(R_index(Pt1:Pt2),2)); 
                FeatureM(i,6)=SampEn(M_Resp,.2,Temp);
              % Respiration Rate Complexity 
                % Feature 7  
        %----------- Galvanic Skin Response ---------
                % Feature 8 
        %----------- O2 Recordings ------------------
                %-- O2 Concentration ---
                Temp=Data(R_index(Pt1:Pt2),3); 
                FeatureM(i,9)=mean(Temp(~(Temp==0))); 
                %---02 Saturation ------
                Temp=Data(R_index(Pt1:Pt2),4); 
                FeatureM(i,10)=mean(Temp(~(Temp==0)));
        %---------- Time Instance -------------------
                FeatureM(i,11)=i; 
        %---------- Type of Run (Train,NonHypoxic, Hypoxic)------------------
                FeatureM(i,12)=RunHTnH; 
        %---------- Subject Number ------------------------------
                FeatureM(i,13)=Subject; 
        %---------- Study (CFT,MATB,SIM) ---------------------------------------
                FeatureM(i,14)=Study; 
        %----------- Protocol -------------------------------
                FeatureM(i,15)=Proto;
        end 
end


