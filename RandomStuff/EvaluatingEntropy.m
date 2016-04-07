clear all 
close all 
clc 

addpath('C:\Users\Nick1Nap\Box Sync\Nasa Flight Data\PEC Study data')

load HRV_SubMATB_SIM_Groups_Total 

% The preprocesing of the signal the first 4 secs and the last 2 secs were
% removed. 

% The Hypoxic, Non-NonHypoxi and Training data columns 
% are related to (MATB=Col1,SIM=Col2)

Sub=size(Hypoxic,1);
Exp=size(Hypoxic,2);

M=3; % Template Dimensional Lenght
Cut=1; % Account for non-hypoxic timing 

SEn=zeros(Sub,Exp,3);
for i=1:Sub
 
    for j=1:Exp
        % Training 
        Data=Train{i,j}(1,1:end-1);
        SEn(i,j,1)=SampEn( M, std(Data)*.2 , Data );
        % Hypoxic 
        Data=Hypoxic{i,j}(1,1:end-1);
        SEn(i,j,2)=SampEn( M, std(Data(Cut:end))*.2 , Data(Cut:end));
        % Non-Hypoxic 
        Data=NonHypoxic{i,j}(1,1:end-1);
        SEn(i,j,3)=SampEn( M, std(Data)*.2 , Data )   ;
    end 
 
end 


Perm=[1,2; 2,3 ;1 3;1 1]; % 1=Training 2=Hypoxic 3=NonHypoxic
PermHolder=[1,2, nan, nan; 2,3,nan, nan ;1 3,nan, nan,;1 1, nan, nan];

for i=1:length(Perm);
    for j=1:Exp        
       [h,p,ci,stats]=ttest2(SEn(:,j,Perm(i,1)),SEn(:,j,Perm(i,2)))
       PermHolder(i,j+2)=p;
    end 
end 
