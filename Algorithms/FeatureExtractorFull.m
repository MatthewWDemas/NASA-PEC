function [ FeatureM ] = FeatureExtractorFull(Data,DemoTemp,Perform,Fs,Timing,RunHTnH,Subject,Study,Proto,taskFormNumber)
%---------------------------------------------
% Input Variable 
%----------------------------------------------
% Timing: The segmentation of Time Series Data 
% RunHTnH: The type of run that occured ( Training, NonHypoxic,Hypoxic,)
% Subject: the particapte number related to the subject 
% Proto: The order of the experiments (Protocols after D are Labeled 2, otherwise they are labeled 1)
% taskFormNumber: The version of the task undertaken by subject:
%                 Training = 0;
%                 Version 1 = 1;
%                 Version 2 = 2;
%                 Error = -1;
%---------------------------------------------
% Data: Col1=EKG, Col2=Respiration, Col3=O2Cont
%---------------------------------------------
% OUTPUT Variable
%---------------------------------------------
    % Column Labels: Col1=AveHR, Col2=SampEn, Col3=RespirVolEnt Col4=O2 ,
    % Col5= TimeInstance
    % Row is Timing Instance 

load MATB_event_count_2min; % Event Counts for MATB forms 1 and 2

FeatureM=zeros(length(Timing)-1,5); 
                % HR COMPLEXITY TIMING 
                ThresStd=.2;
                M_C=[2,2]; 
                T_C=[1,1];
                ThresStdR=.15;
                M_HR=2;
                M_Resp=2;
%-------------------------------------------------
% Calculate R-R Intervals Prior 
[hrv, R_t,R_Amp, R_index, S_t,S_Amp]  = rpeakdetectNapoli(Data(:,1),Fs);
%--------------------------------------------------      
% TOTAL TIME SERIES CALCULATIONS 
 hrvE=zscore(hrv);
 S_time=zscore(R_t-S_t); 
 S_AmpF=zscore(S_Amp);
 R_AmpF=zscore(R_Amp);
 RespVol=zscore(Data(R_index,2)); 
 %--------------------------------------------
        for i=1:length(Timing)-1
        %-------- Timing Relative to EKG ---------
            [Pt1,~]=min(find(R_t>=Timing(i)));
            [Pt2,~]=max(find(R_t<=Timing(i+1)));
        %----------- EKG Data------------------------
                %------ AverageHR---------------------------
                 TL=(Timing(i+1)-Timing(i))/60; 
                 FeatureM(i,1)=(Pt2-Pt1)/TL;
         %--- R-R Interval -----------------------------------    
                %------ Sample Entropy R-R Total Series-----
                Temp=((hrvE(Pt1:Pt2-1)));
                FeatureM(i,2)=SampEn(M_HR,ThresStd,Temp);          
                %------ R-R Sample Entropy Segment Series ------
                Temp=zscore(diff(R_t(Pt1:Pt2)));
                FeatureM(i,3)=SampEn(M_HR,ThresStd,Temp);
                %------- Mean R-R Interval -----------------
                Temp=(diff(R_t(Pt1:Pt2)));
                FeatureM(i,4)=mean(Temp);
                %------ Variance of R-R --------------------
                FeatureM(i,5)=var(Temp);
                %------- Max R-R Interval ------------------
                FeatureM(i,6)=max(Temp);
                %------- Min R-R Interval ------------------
                FeatureM(i,7)=min(Temp);
                %------- Mean Amplitude R Wave --------------
                Temp=(R_Amp(Pt1:Pt2));
                FeatureM(i,8)=mean(Temp);      
                %------- Variance of Amplitude R Wave -------
                FeatureM(i,9)=var(Temp);      
        %--S Wave Dynamics ----------------------------   
                %------ Sample Entropy S Wave Time Total Series--------
                Temp=(S_time(Pt1:Pt2));
                FeatureM(i,10)=SampEn(M_HR,ThresStd,Temp);
                %------ Sample Entropy S Wave Time Segment Series--------
                Temp=zscore((R_t(Pt1:Pt2)-S_t(Pt1:Pt2)));
                FeatureM(i,11)=SampEn(M_HR,ThresStd,Temp);
                %------ Amplitude Sample Entropy S Wave Segment Series--------
                Temp=zscore((R_Amp(Pt1:Pt2)-S_Amp(Pt1:Pt2)));
                FeatureM(i,12)=SampEn(M_HR,ThresStd,Temp);
                %------ Mean Amplitude S Wave ------------
                Temp=((R_Amp(Pt1:Pt2)-S_Amp(Pt1:Pt2)));
                FeatureM(i,13)=mean(Temp);
                %------ Variance of Amplitude S Wave -----            
                FeatureM(i,14)=var(Temp);
                %------ Mean time S-S  Wave ------------
                Temp=zscore(diff(S_t(Pt1:Pt2)));
                FeatureM(i,15)=SampEn(M_HR,ThresStd,Temp);
        %- Coupling Of S-S Time segment and R Waves Amplitude Segment Time Series ----------------
                Temp=[ zscore(R_t(Pt1:Pt2)-S_t(Pt1:Pt2)); zscore(R_Amp(Pt1:Pt2))]; 
                FeatureM(i,16)= mvsampen_full(M_C,.2,T_C,Temp);
        %- Coupling Of S Time Full and R Waves Amplitude Full Time Series ----------------
                Temp=[ (S_time(Pt1:Pt2));(R_AmpF(Pt1:Pt2))]; 
                FeatureM(i,17)= mvsampen_full(M_C,.2,T_C,Temp);
        %- Coupling Of S Time Full and S Waves Amplitude Full Time Series ----------------
                Temp=[ (S_time(Pt1:Pt2));(S_AmpF(Pt1:Pt2))]; 
                FeatureM(i,18)= mvsampen_full(M_C,.2,T_C,Temp);
        %- Coupling Of S Time Full and S Waves Amplitude Full Time Series ----------------
                Temp=[ (S_time(Pt1:Pt2));(S_AmpF(Pt1:Pt2))]; 
                FeatureM(i,19)= mvsampen_full(M_C,.2,T_C,Temp);    
        %- Coupling Of Delta S Time Segment and R Waves Interval Segment Time Series ----------------
                Temp=[ zscore(diff(S_t(Pt1:Pt2))); zscore(diff(R_t(Pt1:Pt2)))]; 
                FeatureM(i,20)= mvsampen_full(M_C,.15,T_C,Temp);
        %----------- Respiration --------------------
              % Respiration Vol Complexity Total Segment 
                Temp=RespVol(Pt1:Pt2); 
                FeatureM(i,21)=SampEn(M_Resp,ThresStdR,Temp);
              % Respiration Vol Complexity Segment
                Temp=zscore(Data(R_index(Pt1:Pt2),2)); 
                FeatureM(i,22)=SampEn(M_Resp,ThresStdR,Temp);  
              % Respiration Vol Mean 
                Temp=Data(R_index(Pt1:Pt2),2);
                FeatureM(i,23)= mean(Temp);
              % DD3 Sample Entropy Segmented Time 
                Temp=zscore(diff(diff(diff(Data(R_index(Pt1:Pt2),2)))));
                FeatureM(i,24)=SampEn(M_Resp,ThresStdR,Temp);  
              % Respiration Vol Mean 
                Temp=Data(R_index(Pt1:Pt2),2);
                FeatureM(i,25)= mean(Temp);
              % Respiration Vol Variance 
                FeatureM(i,26)= std(Temp);
              %  DD3 Respiration Vol  Mean 
                Temp=diff(diff(diff(Data(R_index(Pt1:Pt2),2))));
                FeatureM(i,27)= mean(Temp);
              % DD3 Respiration Vol Variance 
                FeatureM(i,28)= std(Temp);
              %---------------------------------------------------------
     % ----COUPLING  -------        
     %!!!!!!!NORMALIZE THE FREAKEN DD3 Signals!!!!!!!!!! 
              %-------- DD3  Respiration Segment Series  and COUPLING HR and----------
               Temp=zscore(diff(R_t(Pt1:Pt2)));
               Temp=[diff(diff(diff(Data(R_index(Pt1:Pt2),2))));Temp(1:end-2)'];
               FeatureM(i,29)=mvsampen_full(M_C,.2,T_C,Temp');
              %-------- DD3 Respiration Segment and COUPLING HR R Wave Amplitude Timing Segment -----
               Temp=zscore(diff(R_t(Pt1:Pt2)));
               Temp=[zscore(diff(diff(diff(Data(R_index(Pt1:Pt2),2)))));Temp(1:end-2)'];
               FeatureM(i,30)=mvsampen_full(M_C,.2,T_C,Temp');
              %-------- Vol Respiration and Coupling HR R-R Interval Timeing Segment ---
               Temp=zscore(Data(R_index(Pt1:Pt2),2));
               Temp=[Temp(1:end-1);zscore(diff(R_t(Pt1:Pt2)))'];
               FeatureM(i,31)=mvsampen_full(M_C,.2,T_C,Temp');
              %-------- Vol Respiration and Amp Coupling HR ----------------------
               Temp=[zscore(Data(R_index(Pt1:Pt2),2));zscore((R_Amp(Pt1:Pt2)))'];
               FeatureM(i,32)=mvsampen_full(M_C,.2,T_C,Temp');
              %---------Vol Respiration and S Wave Full Couping------------------------- 
               Temp=[zscore(Data(R_index(Pt1:Pt2),2));S_AmpF(Pt1:Pt2)'];
               FeatureM(i,33)=mvsampen_full(M_C,.2,T_C,Temp');
              %---------DD3 Respiration and S Wave Full Couping 
               Temp=[diff(diff(diff(Data(R_index(Pt1:Pt2),2))));S_AmpF(Pt1:Pt2-2)'];
               FeatureM(i,34)=mvsampen_full(M_C,.2,T_C,Temp');         
        %----------- O2 Recordings ------------------
                %-- O2 Concentration ---
                Temp=Data(R_index(Pt1:Pt2),3); 
                FeatureM(i,35)=mean(Temp(~(Temp==0))); 
                %---02 Saturation ------
                Temp=Data(R_index(Pt1:Pt2),4); 
                FeatureM(i,36)=mean(Temp(~(Temp==0)));
                O2var=var(Temp(~(Temp==0)));
                O2Mu=mean(Temp(~(Temp==0)));
        %---------- Time Instance -------------;------
                FeatureM(i,37)=i; 
        %---------- Type of Run (Train,NonHypoxic, Hypoxic)------------------
                FeatureM(i,38)=RunHTnH; 
        %---------- Subject Number ------------------------------
                FeatureM(i,39)=Subject; 
        %---------- Study (CFT,MATB,SIM) ---------------------------------------
                FeatureM(i,40)=Study; 
        %----------- Protocol -------------------------------
                FeatureM(i,41)=Proto;   
        %----------- HR SNR -----------------------
               FeatureM(i,42)=snr(Data(R_index(Pt1:Pt2),1),Data(R_index(Pt1:Pt2),5));
        
        %----------- HP Features ------
        % Score   | Deriv?  |  Cols
        % ------- | ------- | ----------
        % Comm    | (y)     |  43-48
        % Comm    | (y')    |  49-54
        % ResMan  | (y)     |  55-60
        % ResMan  | (y')    |  61-66
        % Track   | (y)     |  67-72
        % Track   | (y')    |  73-78
        %
        % Feature Type: col # - start_col - 1 = Feature
        % Feature #:
        % 1: Mean
        % 2: Median
        % 3: Min
        % 4: Max
        % 5: Std Dev
        % 6: Trend "Slope"
               FeatureM(i,43:78) = Perform(i,1:36);
%         %----------- Performance Mean ------------------------
%                FeatureM(i,43)=Perform(i,1);
%         % ---------- Performance Median ------------------------
%                FeatureM(i,44)=Perform(i,2);
%         % ---------- Performance Min ------------------------
%                FeatureM(i,45)=Perform(i,3);
%         % ---------- Performance Max ------------------------
%                FeatureM(i,46)=Perform(i,4);
%         % ---------- Performance Std Dev ------------------------
%                FeatureM(i,47)=Perform(i,5);
%         % ---------- Performance Trend (y(end) - y(start) ------------------------
%                FeatureM(i,48)=Perform(i,6);
%         %----------- dPerformance/dt Mean ------------------------
%                FeatureM(i,49)=Perform(i,7);
%         % ---------- dPerformance/dt Median ------------------------
%                FeatureM(i,50)=Perform(i,8);
%         % ---------- dPerformance/dt Min ------------------------
%                FeatureM(i,51)=Perform(i,9);
%         % ---------- dPerformance/dt Max ------------------------
%                FeatureM(i,52)=Perform(i,10);
%         % ---------- dPerformance/dt Std Dev ------------------------
%                FeatureM(i,53)=Perform(i,11);
%         % ---------- dPerformance/dt Trend (y(end) - y(start) ------------------------
%                FeatureM(i,54)=Perform(i,12);
       %----------- Galvanic Skin Response ---------
        
       %------------Demographics---------------------------------------------------
        FeatureM(i,79:84)=DemoTemp;   % Age, Total Flight Hours, Total Flight Years, HRMax,BMI, Gender (f=1,m=2);
        FeatureM(i,85)=((Pt2-Pt1)./TL)./DemoTemp(4) ; % Intensity from Average HR/MAx HR 
        FeatureM(i,86)=DemoTemp(5).*FeatureM(i,3); % BMI * HR Entropy
        FeatureM(i,87)=FeatureM(i,3).*DemoTemp(1); % HR Entropy and AGE 
        FeatureM(i,88)=FeatureM(i,3).*DemoTemp(2); % HR Entropy Total Flight Hours 
        FeatureM(i,89)=FeatureM(i,21).*((Pt2-Pt1)/TL)/DemoTemp(4) ;  % HR Intensity and Complexity of Respiration Vol 
        FeatureM(i,90)=FeatureM(i,31).*DemoTemp(5) ; % Coupling of RR and Respiration * BMI 
        FeatureM(i,91)=FeatureM(i,31).*DemoTemp(4) ; % Coupling of RR and Respiration *Total FLight HOURS
        FeatureM(i,92)=FeatureM(i,31).*DemoTemp(5).*DemoTemp(1) ; % Coupling of RR and Respiration * BMI * Age 
        FeatureM(i,93)=FeatureM(i,31).*DemoTemp(5).*DemoTemp(1).*DemoTemp(2);  % Coupling of RR and Respiration * BMI * Age * Flight Hours 
        FeatureM(i,94)=FeatureM(i,31).*DemoTemp(5).*DemoTemp(1).*DemoTemp(2)*(((Pt2-Pt1)./TL)./DemoTemp(4) );  % Coupling of RR and Respiration * BMI * Age * Flight Hours* Intensity 
        FeatureM(i,95)=FeatureM(i,3).*DemoTemp(5).*DemoTemp(1).*DemoTemp(2)*(((Pt2-Pt1)./TL)./DemoTemp(4) );  % HR complexity * BMI * Age * Flight Hours* Intensity 
        FeatureM(i,96)=FeatureM(i,3).*DemoTemp(5).*DemoTemp(1).*DemoTemp(2);  % Coupling of RR and Respiration * BMI * Age * Flight Hours 
        FeatureM(i,97)=FeatureM(i,3).*DemoTemp(5).*DemoTemp(1); 
        
        FeatureM(i,98)=O2var.*DemoTemp(5).*DemoTemp(1) ; % O2var  * BMI * Age 
        FeatureM(i,99)=O2var.*DemoTemp(5).*DemoTemp(1).*DemoTemp(2);  % O2var  * BMI * Age * Flight Hours 
        FeatureM(i,100)=O2var.*DemoTemp(5).*DemoTemp(1).*DemoTemp(2).*(((Pt2-Pt1)/TL)./DemoTemp(4) );  % O2var * BMI * Age * Flight Hours* Intensity 
        FeatureM(i,101)=O2var.*DemoTemp(5).*DemoTemp(1).*DemoTemp(2).*(((Pt2-Pt1)/TL)./DemoTemp(4) ).*O2Mu;  % O2var * BMI * Age * Flight Hours* Intensity 
        FeatureM(i,102)=O2var.*DemoTemp(5).*DemoTemp(1).*DemoTemp(2).*O2Mu;  % O2var * BMI * Age * Flight Hours * O2Mu
        FeatureM(i,103)=FeatureM(i,36).*DemoTemp(5)*DemoTemp(1); 
        FeatureM(i,104)=FeatureM(i,36).*DemoTemp(5).*DemoTemp(1).*DemoTemp(2)*(((Pt2-Pt1)./TL)./DemoTemp(4) );  % O2var  * BMI * Age * Flight Hours* Intensity 
        FeatureM(i,105)=FeatureM(i,36).*DemoTemp(5).*DemoTemp(1).*DemoTemp(2).*(((Pt2-Pt1)./TL)./DemoTemp(4) );  % O2var * BMI * Age * Flight Hours* Intensity 
        FeatureM(i,106)= FeatureM(i,36).*DemoTemp(5).*DemoTemp(1).*DemoTemp(2);  % O2var  * BMI * Age * Flight Hours 
        FeatureM(i,107)= FeatureM(i,36).*DemoTemp(5).*DemoTemp(1);   % O2var    * BMI * Age 
        FeatureM(i,108)=O2var;   
        %-----More interactions terms
        FeatureM(i,109)=DemoTemp(5).*FeatureM(i,3).*O2var.*DemoTemp(2); % BMI * HR Entropy
        FeatureM(i,110)=FeatureM(i,3).*DemoTemp(1).*O2var.*DemoTemp(2); % HR Entropy and AGE 
        FeatureM(i,111)=FeatureM(i,3).*O2var.*DemoTemp(2); % HR Entropy Total Flight Hours 
        FeatureM(i,112)=FeatureM(i,21).*((Pt2-Pt1)/TL)/DemoTemp(4).*O2var.*DemoTemp(2) ;  % HR Intensity and Complexity of Respiration Vol 
        FeatureM(i,113)=FeatureM(i,31).*DemoTemp(5).*O2var.*DemoTemp(2) ; % Coupling of RR and Respiration * BMI 
        FeatureM(i,113)=FeatureM(i,31).*DemoTemp(4).*O2var.*DemoTemp(2) ; % Coupling of RR and Respiration *Total FLight HOURS
        FeatureM(i,114)=FeatureM(i,31).*DemoTemp(5).*DemoTemp(1).*O2var.*DemoTemp(2) ; % Coupling of RR and Respiration * BMI * Age 
         
        % ------------- 115: Comm: Time Index Offset
        % ------------- 116: Comm: Num Missing Values per time interval
        % ------------- 117: ResMan: Time Index Offset
        % ------------- 118: ResMan: Num Missing Values per time interval
        % ------------- 119: Tracking: Time Index Offset
        % ------------- 120: Tracking: Num Missing Values per time interval
        FeatureM(i,115:120) = Perform(i,37:42);
        
        % ------------- 121: The Task Form Number from filename
        % -------------      MATBT = 0
        % -------------      MATB1 = 1
        % -------------      MATB2 = 2
        FeatureM(i,121) = taskFormNumber;
        
        % ------------- 122: Number of Comm Events Directed at Pilot
        % ------------- 123: Number of Comm Events Directed at Other Ships
        % ------------- 124: Number of ResMan Failures
        % ------------- 125: Total Number of Events (col116+col117+col118)
        if taskFormNumber == 1
            FeatureM(i, 122:125) = eventCountTimeInstanceMATB(i,3:6);
        elseif taskFormNumber == 2
            FeatureM(i, 122:125) = eventCountTimeInstanceMATB(i+5,3:6);
        else
            FeatureM(i, 122:125) = nan;
        end

end


