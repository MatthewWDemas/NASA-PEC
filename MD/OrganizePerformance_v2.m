clear all 
close all 
clc 

%---------- Initialize Data Set ----------------------
load DataPerformance 
%load DataPhysioCompress

addpath(...
    '~/Box Sync/Nasa Flight Data/DataAnalysis_Matt/NASA-PEC-MATLAB/');

% Join tables and select numerical values
pec_data.Session = categorical(pec_data.Session);
matb_ts_pec = innerjoin(...
    pec_data(pec_data.Session == 'MATB', [1:10 100:104]), ...
    matb_ts,...
    'Keys', {'Subject', 'Run'});

% call to import pec_data
% call to import matb_ts
load pec_data;
load matb_ts;

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
            % MATB  
              % MATB RA 
                    % Participate Order 
                 [~,I]=sort(MATBRA(1,:));
                  MATBRA=MATBRA(:,I);
              % MATB SL 
                    % Participate Order 
                   [~,I]=sort(MATBSL(1,:));
                   % ******** CFT PATCH ********* 
                   % NEED TO GET ADDITIONAL PARTICIAPTE 
                   MATBSL=[ones(length(MATBSL(:,1)),1)*nan,MATBSL(:,I)];
                % FIRST PATCH FIX: MATBSL=MATBSL(:,I);
              % MATB 15k
                % Participate Order 
                [~,I]=sort(MATB15k(1,:));
                MATB15k=MATB15k(:,I);
            %-----------Consolidation of Study
                % ------ MATB ------------ 
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
      