function [PtLoc1,PtLoc2,ErrorT] = PreprocessingPoints(Stamps,Data,Fs) 

% Issues with NoN_Montonic Stamps 
Threshold1=10;
Threshold2=300;
NZLoc=~(Data==0);
NZData=Data(NZLoc);
Start=1; 
        if sum(Threshold1<(abs(diff(NZData))<Threshold2))
        [I,~]=find((abs(diff(NZData))>Threshold));
        YPoint=NZData(I); 
        [I,~]=find(Data==YPoint(end));
        Start=Start+I(end); 
        end 


        
%-----------------------------------------------
     %----- Start Point --------
    [~,PtLoc1]=min(abs(Stamps(1)-Data(Start:end)));
     %----- Ending Point -------
    [~,PtLoc2]=min(abs(Stamps(2)-Data(Start:end)));
    %------ Validation ---------
     ErrorT=(PtLoc2-(PtLoc1+floor(Stamps(3)*Fs)));
     
 % If the error is too high .... From zero out points     
     if abs(ErrorT)>(Fs/4)
         %------------- Interpolation ------------------     
         Start=1; 
         Win=350;
         MidP=round(length(NZLoc)/2); 
         LocH=MidP-Win:MidP+Win;
         LocHNZ=~(Data(LocH)==0)';
         XPt=LocH(LocHNZ)';
         YPt=Data(XPt); 
         XX=[ones(length(XPt),1),XPt]; 
         B=inv(XX'*XX)*XX'*YPt;
         tx=0:length(Data)-1;
         Yest=(B(2).*tx+B(1));
         SetZ=Yest<0; 
         Yest(SetZ)=0;
         %-----------------------------------------
          Data=Yest;
        %----- Start Point --------
         [~,PtLoc1]=min(abs(Stamps(1)-Data(Start:end)));
         %----- Ending Point -------
         [~,PtLoc2]=min(abs(Stamps(2)-Data(Start:end)));
         %------ Validation ---------
         ErrorT=(PtLoc2-(PtLoc1+floor(Stamps(3)*Fs)));
     end 
     
     

     % Correction for the OffSet 
     PtLoc2=PtLoc2+(Start-1); 
     PtLoc1=PtLoc1+(Start-1); 
     
end

