clear all 
close all 
clc 

addpath('C:\Users\Nick1Nap\Box Sync\Nasa Flight Data\PEC Study data')

load HRV_SubMATB_SIM_Groups_Total_StarStopTime

% The preprocesing of the signal the first 4 secs and the last 2 secs were
% removed. 
Train{7,1}(2,:)=nan; 
Hypoxic{7,1}(2,:)=nan; 
NonHypoxic{7,1}(2,:)=nan; 
% The Hypoxic, Non-NonHypoxi and Training data columns 
% are related to (MATB=Col1,SIM=Col2)

Sub=size(Hypoxic,1);
Exp=size(Hypoxic,2);

M=2; % Template Dimensional Lenght
Cut=1; % Account for non-hypoxic timing 

AvgHR=zeros(Sub,Exp,3);
for i=1:Sub
 
    for j=1:Exp
        % Training 
        Data=Train{i,j}(2,1:end);
        AvgHR(i,j,1)=(length(Data)+1)/(Data(end)/60);
        % Hypoxic 
        Data=Hypoxic{i,j}(2,1:end);
        AvgHR(i,j,2)=(length(Data)+1)/(Data(end)/60);
        % Non-Hypoxic 
        Data=NonHypoxic{i,j}(2,1:end);
        AvgHR(i,j,3)=(length(Data)+1)/(Data(end)/60);
    
    end 
 
end 


Perm=[1,2; 2,3 ;1 3;1 1]; % 1=Training 2=Hypoxic 3=NonHypoxic
PermHolder=[1,2, nan, nan ; 2,3,nan, nan ;1, 3,nan, nan;1, 1, nan, nan];

for i=1:length(Perm);
    for j=1:Exp        
       [h,p,ci,stats]=ttest2(AvgHR(:,j,Perm(i,1)),AvgHR(:,j,Perm(i,2)));
       PermHolder(i,j+2)=p;
    end 
end 
