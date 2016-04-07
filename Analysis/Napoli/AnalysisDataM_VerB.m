clear all 
close all 
clc 

%load DataMatrixSeta_StdSegment
load DataMatrixSeta_ZScore_M3
%--------- Initializing Column --------------
TimeP=11;
RunT=12;
%----------------------------------------
% Trend Analysis
%----------------------------------------
 figure
 % SUBPLOT 1 
 subplot(411)
 VarC=1; % HR Entropy Variable 
 for i=1:5
        % Hypoxic Condition
        Loc1=((DataM(:,RunT)==3) + (DataM(:,TimeP)==i))==2; 
        %Loc1=(Loc1-(DataM(:,VarC)==Inf))==1;
        % NonHypoxic Condition
        Loc2=((DataM(:,RunT)==2) + (DataM(:,TimeP)==i))==2; 
        %Loc2=(Loc2-(DataM(:,VarC)==Inf))==1;
        %plot(i,mean(DataM(Loc1,2)),'-*r')
        errorbar(i,mean(DataM(Loc1,VarC)),1.96*(std(DataM(Loc1,VarC)/sqrt(sum(Loc1)))),'rx')
        hold on 
        errorbar(i,mean(DataM(Loc2,VarC)),1.96*(std(DataM(Loc2,VarC)/sqrt(sum(Loc2)))),'bx')
        %plot(i,mean(DataM(Loc2,2)),'-*b')
        hold on
 end 
grid on 
%xlabel('Time Segments (10 min Interval)')
legend('Hypoxic','NonHypoxic')
title('Overview Hypoxic vs NonHypoxic')
% SUBPLOT 3 
subplot(412)
 for i=1:5
        % Hypoxic Condition
        Loc1=((DataM(:,RunT)==3) + (DataM(:,TimeP)==i)+ (DataM(:,14)==1) )==3; 
        %Loc1=(Loc1-(DataM(:,VarC)==Inf))==1;
        % NonHypoxic Condition
        Loc2=((DataM(:,RunT)==2) + (DataM(:,TimeP)==i) + (DataM(:,14)==1))==3; 
        %Loc2=(Loc2-(DataM(:,VarC)==Inf))==1;
        %plot(i,mean(DataM(Loc1,2)),'-*r')
        errorbar(i,mean(DataM(Loc1,VarC)),1.96*(std(DataM(Loc1,VarC)/sqrt(sum(Loc1)))),'rx')
        hold on 
        errorbar(i,mean(DataM(Loc2,VarC)),1.96*(std(DataM(Loc2,VarC)/sqrt(sum(Loc2)))),'bx')
        %plot(i,mean(DataM(Loc2,2)),'-*b')
        hold on
 end 
grid on 
%xlabel('Time Segments (10 min Interval)')
legend('Hypoxic','NonHypoxic')
title('CFT of Hypoxic and NonHypoxic')

% SUBPLOT 3 
subplot(413)
 for i=1:5
        % Hypoxic Condition
        Loc1=((DataM(:,RunT)==3) + (DataM(:,TimeP)==i)+ (DataM(:,14)==2) )==3; 
        %Loc1=(Loc1-(DataM(:,VarC)==Inf))==1;
        % NonHypoxic Condition
        Loc2=((DataM(:,RunT)==2) + (DataM(:,TimeP)==i) + (DataM(:,14)==2))==3; 
        %Loc2=(Loc2-(DataM(:,VarC)==Inf))==1;
        %plot(i,mean(DataM(Loc1,2)),'-*r')
        errorbar(i,mean(DataM(Loc1,VarC)),1.96*(std(DataM(Loc1,VarC)/sqrt(sum(Loc1)))),'rx')
        hold on 
        errorbar(i,mean(DataM(Loc2,VarC)),1.96*(std(DataM(Loc2,VarC)/sqrt(sum(Loc2)))),'bx')
        %plot(i,mean(DataM(Loc2,2)),'-*b')
        hold on
 end 
grid on 
%xlabel('Time Segments (10 min Interval)')
legend('Hypoxic','NonHypoxic')
title('MatB of Hypoxic and NonHypoxic')

% SUBPLOT 4 
subplot(414)
 for i=1:5
        % Hypoxic Condition
        Loc1=((DataM(:,RunT)==3) + (DataM(:,TimeP)==i)+ (DataM(:,14)==3) )==3; 
        %Loc1=(Loc1-(DataM(:,VarC)==Inf))==1;
        % NonHypoxic Condition
        Loc2=((DataM(:,RunT)==2) + (DataM(:,TimeP)==i) + (DataM(:,14)==3))==3; 
        %Loc2=(Loc2-(DataM(:,VarC)==Inf))==1;
        %plot(i,mean(DataM(Loc1,2)),'-*r')
        errorbar(i,mean(DataM(Loc1,VarC)),1.96*(std(DataM(Loc1,VarC)/sqrt(sum(Loc1)))),'rx')
        hold on 
        errorbar(i,mean(DataM(Loc2,VarC)),1.96*(std(DataM(Loc2,VarC)/sqrt(sum(Loc2)))),'bx')
        %plot(i,mean(DataM(Loc2,2)),'-*b')
        hold on
 end 
grid on 
xlabel('Time Segments (10 min Interval)')
legend('Hypoxic','NonHypoxic')
title('SIM of Hypoxic and NonHypoxic')


% 
%----------------------------------------
% Scatter Plot Distributions 
%----------------------------------------
        % Hypoxic Condition
        % Data === Hypoxic, Data==Time
Loc1=((DataM(:,RunT)==3) + (DataM(:,TimeP)==5))==2; 
        % Nonpoxic Condition
        % Data === NonHypoxic, Data==Time
Loc2=((DataM(:,RunT)==2) + (DataM(:,TimeP)==5))==2; 


figure
Xlab=2;
Ylab=10;
h1=scatter(DataM(Loc1,Xlab),DataM(Loc1,Ylab));
hold on; 
h2=scatter(DataM(Loc2,Xlab),DataM(Loc2,Ylab));
grid on; 
h1.MarkerEdgeColor = [0 0.4470 0.7410];
h2.MarkerEdgeColor = [0.8500 0.3250 0.0980];
legend('Hypoxic', 'NonHypoxic')
xlabel('HR Entropy')
ylabel('AveHR')