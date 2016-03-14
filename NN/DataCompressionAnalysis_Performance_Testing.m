clear all 
close all 
clc 

load CompressFinalData
%--------- TEST MATB -------------
% TEST MATB 
 Loc=(DataM(:,40)==3);
 DD=DataM(Loc,[1:35,43]);
%DD=DataM(:,[1:36]);
clear DataM; 
%------ Clean Data ---------------
     % Cleaning NAN Data 
        Loc=~(sum(isnan(DD)')>0); 
        DD=DD(Loc,:);
     % Cleaning Inf Data 
        Loc=~(sum((DD==inf)')>0); 
        DD=(DD(Loc,:));
        
   
%----------------------------------------
% Significant Variables 
% Col 1 2 3 4 5 6 7 9 15 20 21 22 23 26 29 30 31 32
Output=zscore(DD(:,36))<0;  
DD=zscore(DD(:,1:35));
      % DD=quantilenorm(DD(:,:));
      
  %====================================================   
        %----------------------------------------------
        % Randomize the Data Set; 
        N=length(Output);
        IndexOrd=randperm(N);
        %-------------------------
        DD=DD(IndexOrd,:); 
        Output=Output(IndexOrd);
 %----------------------------------------------------  
     %------------ Test Set ---------------
     L=round(N*.33); 
     TestD=DD(1:L,:);
     TestO=Output(1:L);
     %------------ Train Set--------------
     TrainD=DD(1+L:end,:);
     TrainO=Output(1+L:end);
%----------------------------------------------------     
     
 ctree=fitctree(TrainD,TrainO);
 resuberror = resubLoss(ctree)
 
 [~,~,~,bestlevel] = cvLoss(ctree,'SubTrees','All')

ctree = prune(ctree,'Level',bestlevel);

 Yest=predict(ctree,TestD)
C = confusionmat(TestO,Yest)

accuracy=(C(1,1)+C(2,2))/sum(sum(C))

view(ctree,'Mode','Graph')
