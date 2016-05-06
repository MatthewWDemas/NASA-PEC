clear all 
close all 
clc 

load('../SharedDataExport/InputOutput_v5_5_3_16')

Indicators = Data(:,[39,41,40,38,37,35,109:119]);

countMATBEvents = Indicators(:,14:17);

%% How many MATB Events are there by percentage?

% Communications Directed at Pilot
tabulate(Indicators(:,14))
%   Value    Count   Percent
%       1        0      0.00%
%       2      274     75.48%
%       3       89     24.52%

% Communications Directed at Other Pilots
tabulate(Indicators(:,15))
%   Value    Count   Percent
%       1        0      0.00%
%       2      176     48.48%
%       3      141     38.84%
%       4       46     12.67%

% Resource Management Pump Failures
tabulate(Indicators(:,16))
%   Value    Count   Percent
%       0       91     25.07%
%       2      229     63.09%
%       4       43     11.85%

% Total Number of Events
tabulate(Indicators(:,17))
%   Value    Count   Percent
%       1        0      0.00%
%       2        0      0.00%
%       3        0      0.00%
%       4       45     12.40%
%       5        0      0.00%
%       6       88     24.24%
%       7      187     51.52%
%       8        0      0.00%
%       9       43     11.85%

%% MATB Event Count and PhysioA Features
% Does not appear to be any consistent relationship between the two.

for jCountMATBEvent = 1:4
    k = 0;
    figure
    for iPhysioA = 1:66
        k = k + 1;
        subplot(6,11,k)
        gscatter(countMATBEvents(:,jCountMATBEvent), PhysioA(:,iPhysioA),...
            Indicators(:,1))
        [rho, pval] = corr(countMATBEvents(:,jCountMATBEvent), ...
                           PhysioA(:,iPhysioA),...
                           'type', 'Spearman');
        ylabel(strcat('PhysioA feat: ', num2str(iPhysioA)))
        xlabel(strcat('MATB Event feat: ', num2str(jCountMATBEvent)))
        title(strcat('\rho = ', num2str(rho), ' -- p = ', num2str(pval)))
    end
end

%% MATB Event Count and HP_A Features
% 

for jCountMATBEvent = 1:4
    k = 0;
    figure
    for iHP_A = 1:36
        k = k + 1;
        subplot(6,6,k)
        gscatter(countMATBEvents(:,jCountMATBEvent), HP_A(:,iHP_A),...
            Indicators(:,1))
        legend('off')
        [rho, pval] = corr(countMATBEvents(:,jCountMATBEvent), ...
                           HP_A(:,iHP_A),...
                           'type', 'Spearman');
        ylabel(strcat('HP_A feat: ', num2str(iHP_A)))
        xlabel(strcat('MATB Event feat: ', num2str(jCountMATBEvent)))
        title(strcat('\rho = ', num2str(rho), ' -- p = ', num2str(pval)))
    end
end