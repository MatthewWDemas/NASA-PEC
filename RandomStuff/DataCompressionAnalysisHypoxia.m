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
LocNH=(DD(:,36)==2);
NH=DD(LocNH,:); 

LocH=(DD(:,36)==3);
H=DD(LocH,:); 

                % --------------Normalization 
                 DD=[NH; H];
                 col=1:35;
                 %AA=quantilenorm(DD(:,[1:35,41]));    
                 AA=quantilenorm(DD(:,:));
                 NH=AA(1:length(NH(:,1)),:); 
                 H=AA(length(NH(:,1))+1:end,:);
                 
                 
 
for i=1:36
    [h(i),p(i)]=ttest2(NH(:,i),H(:,i)); 
    
    figure;
    subplot(211)
    hist(NH(:,i),20); 
    title('NonHypoxic')
    subplot(212)
    hist(H(:,i),20); 
    title('Hypoxic')
end 


