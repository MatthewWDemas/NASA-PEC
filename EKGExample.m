clear all 
close all 
clc

load EKGData 

index=5;
t=R_t(index);

time=(1/Fs):1/Fs:R_t(index);

% Figure Display
figure;
plot(time,Data(1:R_index(index),1),'linewidth',1.5)
hold on 
plot(R_t(1:index),R_Amp(1:index),'r*','linewidth',2)
hold on ; 
plot(S_t(1:index-1),S_Amp(1:index-1),'g*','linewidth',2)
grid on ; 

legend('EKG','R Index', 'S Index')


figure; 
plot(diff(R_t))
ylabel('R-R Interval')
xlabel('Number of Beats')