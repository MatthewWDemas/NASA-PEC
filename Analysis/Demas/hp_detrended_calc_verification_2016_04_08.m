
%% How did data change after using detrended y values? 
% New Code was implemented changing method for calculating median, minimum,
% maximum and standard deviation?. The following lines calculate the Chi
% squared deviation for all values: 49 Subject x 2 Runs x 5 Time Instances
% x (36 Features - 12 Features not affected (mean, trend slope)) = 11,760.


load('Data\DataMatrixSeta_ZScoreFullTime_M3_2016_04_08.mat')
Aa = DataM;
A = Aa(Aa(:,40) == 3  & Aa(:,38) ~= 1,:);

load('/Users/matt/Desktop/DataM_noDetrendedMedMinMaxStd.mat')
Bb = DataM_verNoTrendRemove;
B = Bb(Bb(:,40) == 3 & Bb(:,38) ~= 1,:);

chisqAB = sum(sum(A(:,43:78) - B(:,43:78)).^2);

figure;
subplot(1,2,1)
image(B(B(:,40) == 3 & B(:,38) ~= 1,:))
colormap('jet')
colorbar
title('Original Data')
subplot(1,2,2)
image(A(A(:,40) == 3  & A(:,38) ~= 1,:))
title('HP Features Median, Min, Max, Std Dev with Detrended Input')

% 
%%
% 
% * All (11760) values changed by 1.89 x 10^10.
% * This seems ridiculously high -- $1.6 \times 10^6$ per value.
% * 
% 

mean(