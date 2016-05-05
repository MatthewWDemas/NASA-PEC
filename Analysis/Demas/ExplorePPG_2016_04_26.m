
load('PEC_S05_PD_S3_R2_MATB2.mat')
plot(ans(:,5))
plot(ans(5,:))
plot(ans(6,:))
m2 = ans;
load('PEC_S05_PD_S3_R3_MATB1.mat')
m1 = ans;
load('PEC_S18_PC_S3_R3_MATB2.mat')
m2s18 = ans;

figure
plot(m2(5,abs(m2(5,:)) < 0.5))
hold on
plot(m1(5,abs(m1(5,:)) < 0.5))
title('MATB Trials 1 and 2, Subj 5')
xlabel('Time')
ylabel('Ch 5')
legend('MATB2', 'MATB1', 'location', 'best')

figure
plot(m2(1,:), m2(6,:))
hold on
plot(m1(6,:))
title('MATB Trials 1 and 2, Subj 5')
xlabel('Time')
ylabel('Ch 6')
legend('MATB2', 'MATB1', 'location', 'best')

figure
plot(m2(1,:), m2(7,:))
hold on
plot(m1(7,:))
title('MATB Trials 1 and 2, Subj 5')
xlabel('Time')
ylabel('Ch 7')
legend('MATB2', 'MATB1', 'location', 'best')

%% Channel 5 vs. 6
% Doesn't really amount to much

figure
plot(m2(5,:), m2(6,:))
xlabel('Channel 5')
ylabel('Channel 6')
title('Subj 05, MATB2')

%% Subject 5 (age 52) vs. Subject 18 (age 25)
figure
plot(m2(1,:), m2(6,:))
hold on
plot(m2s18(1,:), m2s18(6,:))
title('MATB Trial 2')
xlabel('Time')
ylabel('Ch 6')
legend('Subj 05', 'Subj 18', 'location', 'best')