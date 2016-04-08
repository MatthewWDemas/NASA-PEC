clear all 
close all 
clc 


%============== Initialize Data Set =============================
% MATT: It seems like we are gonna have a problem if we don't have the same
% extension. Just use your extension below mine and you will just receive a
% warning for mine. Likewise I will receive a warning for yours. 
addpath('C:\Users\Nick1Nap\Box Sync\Nasa Flight Data\PEC Study data');  
%addpath('ADD YOUR PATH HERE MATT ');  
            %======Additional Paths 
            addpath('../SharedDataExport/');
            addpath('Data')
            addpath('Algorithms')

%-------------------------------------------------------------------------
% Loading Mat Files 
%-------------------------------------------------------------------------
 load DemoDataV3;  % Demographic Data
 
 
 
 % Max Heart Rate 
 HRmax=220-DemoGraphic(:,2);
 
 % Body Mass Index 
 BMI=(DemoGraphic(:,5)./(DemoGraphic(:,3).*12+DemoGraphic(:,4)).^2)*703;
 
 % Gender 
 GenderV=double(nominal(Gender)) ; % Females=1 ; Males=2; 
 Demo=[DemoGraphic,HRmax,BMI,GenderV];
 DemoLabel=[DemoLabel,'HRmax','BMI','GenderV (F=1,M=2)'];
 
 save('DemoFinal','Demo','DemoLabel')
 
 