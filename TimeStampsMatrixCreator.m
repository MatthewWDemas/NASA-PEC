clear all 
close all 
clc 
load TimeStamps

%------------- Intialization -----------------------
Index= [4 5 6 7 8 9 10 11 12 13 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 38 40 ...
      41 42 44 45 46 47 48 50 51 52 53 54 55 56 57];
%----------------------------------------------------
% Removal of Headers 
%----------------------------------------------------
TimeStamps=TimeStamps(3:end,:);
TimeLabels(1:2,:)=[];
%----------------------------------------------------
njn=1;
% Labeling Matrix 
for j=1:length(Index)
   r=1+(10*(Index(j)-3));
   % Training Data Set 
   TrainL(njn,1:2)=TimeLabels((r+1),1:2);
   TrainL(njn,3)=TimeLabels((r+4),2);
   TrainL(njn,4)=TimeLabels((r+7),2);
   % Hypoxia Data Set 
   HypoxiaL(njn,1:2)=TimeLabels((r+3),1:2);
   HypoxiaL(njn,3)=TimeLabels((r+6),2);
   HypoxiaL(njn,4)=TimeLabels((r+9),2);
   % NonhypoxiaData Set 
   NonHypoxiaL(njn,1:2)=TimeLabels((r+2),1:2);
   NonHypoxiaL(njn,3)=TimeLabels((r+5),2);
   NonHypoxiaL(njn,4)=TimeLabels((r+8),2);
   
   njn=1+njn;                       
end 

njn=1;
% Labeling Stamps  
for j=1:length(Index)
   r=1+(10*(Index(j)-3));
   % Training Data Set 
   TrainS{njn,1}=Index(j);
   TrainS{njn,2}=TimeStamps((r+1),1:3);
   TrainS{njn,3}=TimeStamps((r+4),1:3);
   TrainS{njn,4}=TimeStamps((r+7),1:3);
   % Hypoxia Data Set 
   HypoxiaS{njn,1}=Index(j);
   HypoxiaS{njn,2}=TimeStamps((r+3),1:3);
   HypoxiaS{njn,3}=TimeStamps((r+6),1:3);
   HypoxiaS{njn,4}=TimeStamps((r+9),1:3);
   % NonhypoxiaData Set 
   NonHypoxiaS{njn,1}=Index(j);
   NonHypoxiaS{njn,2}=TimeStamps((r+2),1:3);
   NonHypoxiaS{njn,3}=TimeStamps((r+5),1:3);
   NonHypoxiaS{njn,4}=TimeStamps((r+8),1:3);
   
   njn=1+njn;                       
end 

save('TimeStampsIn','NonHypoxiaS','HypoxiaS','TrainS')

