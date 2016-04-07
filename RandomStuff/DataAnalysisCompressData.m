clear all 
close all 
clc 

load CompressFinalData



%--------- TEST MATB -------------
% TEST MATB 
Loc=(DataM(:,38)==1);
DD=DataM(Loc,:);

%------ Clean Data ---------------
     % Cleaning NAN Data 
        Loc=~(sum(isnan(DD)')>0); 
        DD=DD(Loc,:);
     % Cleaning Inf Data 
        Loc=~(sum((DD==inf)')>0); 
        DD=(DD(Loc,:));
        
        
        
%-----------------------------------        
        
        
        
        
            % Cleaning Specially for MatB Case         
                            % %--------------------------
                            % % Remove 1st min 
                            % Loc=~(DD(:,35)==1); 
                            % DD=DD(Loc,:);
                            % % --------------------------
                            % % Remove subject 12 
                            % Loc=~(DD(:,37)==12); 
                            % DD=(DD(Loc,:));
                            % %------------------------
                            % % Remove protocol 1
                            % Loc=~(DD(:,39)==2); 
                            % DD=(DD(Loc,:));
                            % %------------------------
%--------------------------------------------
% Normalization Implementation 
     % Note: 1)Do we normalize with response variable as well
     %       2)Do we 
       % DD=quantilenorm(DD(:,[2,8,14,19,24,26,29]));
        
  
        
        
%     
% % % 
% % % 
% % % 
% % % % SNR_P1=1; 
% % % % SNR_PD=DataMatB(DataMatB(:,39)==SNR_P1,:); 
% % % % for i=49
% % % %     
% % % %     Loc =SNR_PD(:,37)==i
% % % % end 
% % % 

% for i=1:length(DD(1,:))
%     figure 
% scatter(DD(:,i),AA(:,41))
% CC(i)=corr(DD(:,i),AA(:,41))
% end 
% % % 
% % % LocHP=(DD(:,41)>.65); 

% HP=DD(LocHP,:); 
% 
% for i=1:40
%     figure 
% scatter(HP(:,i),HP(:,41))
% %CC(i)=corr(DD(:,i),DD(:,41))
% end 
% 
% 



% % % 
% % % 
% % % % 
% % % % 
% PassFail=nominal(DD(:,41)>.5); 
% 
% %----------------------
% 
% [B,dev,stats]=mnrfit(DD(:,[2,8,14,19,24,26,29]),PassFail); 
% 
% Yhat=mnrval(B,DD(:,[2,8,14,19,24,26,29]))




% % % 
% % % SNR_P1=1; 
% % % SNR_PD=DD(DD(:,39)==SNR_P1,:); 
% % % for i=49
% % %     
% % %     Loc =SNR_PD(:,37)==i
% % %     
% % %     
% % %     figure ; 
% % %     
% % %     plot(DD())
% % % end 



% 
% 
%       O2C=DataM(:,33);
%         Cond=DataM(:,36);
%         
%         [Cond,ii]=sort(Cond); 
%          O2C=O2C(ii);
%          
%          figure
%          plot(Cond)
%          hold on 
%          plot(O2C)


