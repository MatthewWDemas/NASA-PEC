clear all 
close all 
clc 

%---------- Initialize Data Set ----------------------
load DataPerformance 
%load DataPhysioCompress
        %---------- Organize Data Set----------------
            % CTF 
                % CTF RA 
               % Participate Order 
                    [~,I]=sort(CFTRA(1,5:end));
                    CFTRA=CFTRA(:,I+4);
                % CTF SL 
                        % Participate Order 
                    [~,I]=sort(CFTSL(1,5:end));
                    CFTSL=CFTSL(:,I+4);              
                % 15k (Hypoxic)
                        % Participate Order 
                    [~,I]=sort(CFT15k(1,5:end));
                    CFT15k=[CFT15k(:,I+4)];
                    %CFT15k=[CFT15k(:,1:4),CFT15k(:,I+4)];
            % MatB  
              % CTF RA 
                    % Participate Order 
                 [~,I]=sort(MATBRA(1,:));
                  MATBRA=MATBRA(:,I);
              % CTF SL 
                    % Participate Order 
                   [~,I]=sort(MATBSL(1,:));
                   % ******** CFT PATCH ********* NEED TO GET ADDITIONAL PARTICIAPTE 
                   MATBSL=[ones(length(MATBSL(:,1)),1)*nan,MATBSL(:,I)];
                % FIRST PATCH FIX: MATBSL=MATBSL(:,I);
              % CFT 15k
                % Participate Order 
                [~,I]=sort(MATB15k(1,:));
                MATB15k=MATB15k(:,I);
            %-----------Consolidation of Study
                % ------ CFT ------------ 
                MATB={MATBRA,MATBSL,MATB15k};
                Perform{3}=MATB;
                clear('MATBRA','MATBSL','MATB15k')
                %------- MatB ----------
                CFT={CFTRA,CFTSL,CFT15k};
                CogS={CFTRA.*nan,CFTSL.*nan,CFT15k.*nan};
                SIM={CFTRA.*nan,CFTSL.*nan,CFT15k.*nan};
                %-------------------------
                Perform{1}=CFT; 
                Perform{2}=CogS;
                Perform{4}=SIM; 
                clear('CFTRA','CFTSL','CFT15k','I')
                clear ('CFT','MATB','CogS','SIM')
      save PerformanceCFTMATB
      
            
% %---------- Initialize Parameters -------------------
% Study=14; 
% Partic=13;
%            % Timing Segmentation 
%                 Time=1:5; 
% %-----------------------------------------------------
% %----------- Performance Organization ----------------
% for Run=1:3 
%         
%         for S=1:2 ;
%         % Rubic CFT=1; Matb=2; Sim=3;
%         % Study Location is Column 14 in DataM 
% 
%             for P=1:49 ;
%             % Participate Number associated to Subject number 
%             % Participate Location is located in Column 13 
% 
%                     %---------------------------------------
%                     % Location on DataM for Insertation 
%                     %---------------------------------------
%                     
%                     %-------------------------------------
%                      % Preprocessing Performance  
%                     if S==1;  % CFT 
%                         Temp=CFT{Run}; 
%                         if P<length(Temp(1,:))  % ******** CFT or CogS PATCH ********* NEED TO DEFINE COGS AND CFT
%                            Temp=Temp(2:end,P);
%                         else 
%                              break
%                         end 
%                     elseif  S==2 ;% MATB 
%                         Temp=MATB{Run}; 
%                         Temp=Temp(2:end,P);
%                         Loc=~isnan(Temp); 
%                         Temp=Temp(Loc); 
%                     end 
% 
% 
%             end 
%     
% end 
%     
% end 