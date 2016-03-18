
% s57sim2_tab.Properties.VariableNames
%     'Subject_Number'    'time'    'dp_time'    'Speed'
%     'Pos_NED_X'    'Pos_NED_Y'    
%     'Lat'    'Long'
%     'AltPos_WGS84_Z'    
%     'Bank_Anglephi'    'pitch_angletheta' 'HeadingMagPsi'    'headingpsi'    
%     'xDot'    'yDot'    'zDot'
%     'phiDot'    'thetaDot'    'psiDot'    
%     'normal_acceleration'
%     'Headingexp_state'    'Altexp_state'    'Speedexp_state'
%     'Snippet_number'    
%     'Stick1_PosX'    'Stick1_PosY'
%     'Stick1_ForceX'    'Stick1_ForceY'
%     'Stick2_PosX' 'Stick2_PosY'    'Stick2_ForceX'    'Stick2_ForceY'
%     'ROBD_program'    'ROBD_Alt'    'ROBD_final_Alt'
%     'ROBD_O2_conc'    'ROBD_BL_Press'    'ROBD_Elapsed_Time'
%     'ROBD_Remaining_Time'    'ROBD_SPO2'    'ROBD_Pulse'
%     'GTEC_Time'    'GTEC_EKG'    'GTEC_Pulse'    'GTEC_O2_Sat'
%     'GTEC_Resperation'    'ROBD_Date'    'ROBD_Time'

%% Heading Exploratory Plots
% Headingexp_state is Expected Heading
% HeadingMagPsi is Actual Heading

figure
plot(s57sim2_tab.time, s57sim2_tab.Headingexp_state)
title('Expected Heading vs. Time')
xlabel('Time')
ylabel('Expected Heading')

figure
[hx, hy1, hy2] = plotyy(s57sim2_tab.time, s57sim2_tab.HeadingMagPsi,...
    s57sim2_tab.time, s57sim2_tab.headingpsi)
title('Actual Heading (?) ( vs. Time')
xlabel('Time')
ylabel(hx(1), 'Actual Heading (Possibility 1?)')
ylabel(hx(2), 'Actual Heading (Possibility 2?)')

figure
plot(s57sim2_tab.time, s57sim2_tab.Headingexp_state)
hold on
plot(s57sim2_tab.time, s57sim2_tab.HeadingMagPsi)
plot(s57sim2_tab.time, s57sim2_tab.headingpsi)
title('Actual and Expected Heading vs. Time')
legend('Expected Heading',...
    'Actual Heading (Poss 1)',...
    'Actual Heading (Poss 2)',...
    'location', 'best')
xlabel('Time')
ylabel('Heading')

figure
plot(s57sim2_tab.time, s57sim2_tab.Altexp_state)
hold on
plot(s57sim2_tab.time, s57sim2_tab.AltPos_WGS84_Z)
title('Altitude vs. Time')
xlabel('Time')
ylabel('Altitude')
legend('Expected Altitude',...
    'Actual Altitude (?)',...
    'location', 'best')

figure
hh = histfit(s57sim2_tab.time)
title('Histogram of Number of Time Steps for Each Time')
hh(1).FaceColor = [0.9 0.9 0.9];

figure
histogram(s57sim2_tab.ROBD_Elapsed_Time)

figure
plot(s57sim2_tab.Lat, s57sim2_tab.Long)
title('Plot of Simulator Longitude vs. Latitude')
xlabel('Latitude')
ylabel('Longitude')

figure
plot(s57sim2_tab.Pos_NED_X, s57sim2_tab.Pos_NED_Y)
title('Plot of Simulator X Pos vs. Y Pos')
xlabel('X Position')
ylabel('Y Position')

figure
plot(s57sim2_tab.time, s57sim2_tab.Speedexp_state)
hold on
plot(s57sim2_tab.time, s57sim2_tab.Speed)
title('Actual and Expected Speed vs. Time')
legend('Expected Speed', 'Actual Speed', 'location', 'best')

figure
plot(s57sim2_tab.time, s57sim2_tab.xDot)
hold on
plot(s57sim2_tab.time, s57sim2_tab.yDot)
plot(s57sim2_tab.time, s57sim2_tab.zDot)
title('Components of Speed (?) vs. Time')
legend('Component of Speed (?) in x direction',...
    'Component of Speed (?) in y direction',...
    'Component of Speed (?) in z direction',...
    'location', 'best')
xlabel('Time')
ylabel('Inner Product')

figure
plot(s57sim2_tab.time, s57sim2_tab.Speed)
hold on
plot(s57sim2_tab.time, 2*sqrt(s57sim2_tab.xDot.^2 + ...
    s57sim2_tab.yDot.^2 + s57sim2_tab.zDot.^2))
title('Speed vs. Time')
xlabel('Time')
ylabel('Speed')
legend('Actual Speed',...
    'Speed (Vector Addition)',...
    'location', 'best')

figure
plot(s57sim2_tab.time, s57sim2_tab.Bank_Anglephi)
hold on
plot(s57sim2_tab.time, s57sim2_tab.pitch_angletheta)
title('Components of Orientation (?) vs. Time')
legend('Bank Angle',...
    'Pitch Angle',...
    'location', 'best')

figure
plot(s57sim2_tab.time, s57sim2_tab.phiDot)
hold on
plot(s57sim2_tab.time, s57sim2_tab.thetaDot)
plot(s57sim2_tab.time, s57sim2_tab.psiDot)
title('Components of Speed for different Orientations (?) vs. Time')

figure
plot(s57sim2_tab.time, s57sim2_tab.normal_acceleration)
title('Normal Acceleration (?) vs. Time')
legend('Bank Angle Component',...
    'Pitch Angle Component',...
    'Heading Component',...
    'location', 'best')

figure
plot(s57sim2_tab.time, s57sim2_tab.Stick1_PosX)
hold on
plot(s57sim2_tab.time, s57sim2_tab.Stick1_PosY)
title('Stick Position Components vs. Time')
legend('X',...
    'Y',...
    'location', 'best')

figure
plot(s57sim2_tab.time, s57sim2_tab.Stick1_ForceX)
hold on
plot(s57sim2_tab.time, s57sim2_tab.Stick1_ForceY)
title('Stick Force Components vs. Time')
legend('X',...
    'Y',...
    'location', 'best')

figure
plot(s57sim2_tab.Stick1_ForceX, s57sim2_tab.Stick1_ForceY)
title('Stick Force X-Y Components vs. Time')

figure
plot(s57sim2_tab.Stick1_PosX, s57sim2_tab.Stick1_PosY)
title('Stick Position X-Y Components vs. Time')

figure
plot(s57sim2_tab.time, s57sim2_tab.ROBD_Elapsed_Time)
title('ROBD Elapsed Time vs. Time')
xlabel('Time (in seconds)')
ylabel('ROBD Elapsed Time (in seconds)')

figure
plot(s57sim2_tab.time, s57sim2_tab.ROBD_Alt)
title('ROBD Altitude vs. Time')
xlabel('Time (in seconds)')
ylabel('ROBD Altitude (in feet)')

figure
plot(s57sim2_tab.time, s57sim2_tab.ROBD_BL_Press)
title('ROBD Breathing Line (?) Pressure vs. Time')
xlabel('Time (in seconds)')
ylabel('ROBD BL Press')

figure
plot(s57sim2_tab.time, s57sim2_tab.ROBD_SPO2)
title('ROBD SPO2 vs. Time')
xlabel('Time (in seconds)')
ylabel('ROBD SPO2')

figure
plot(s57sim2_tab.time, s57sim2_tab.ROBD_Pulse)
title('ROBD Pulse vs. Time')
xlabel('Time (in seconds)')
ylabel('ROBD Pulse')

figure
[hx, hy1,hy2] = plotyy(s57sim2_tab.time, s57sim2_tab.ROBD_Pulse, ...
    s57sim2_tab.time, s57sim2_tab.ROBD_SPO2)
hold on
title('ROBD Physio vs. Time')
xlabel('Time (in seconds)')
ylabel(hx(1), 'ROBD Pulse')
ylabel(hx(2), 'ROBD SPO2')

figure
[hx, hy1,hy2] = plotyy(s57sim2_tab.time, s57sim2_tab.ROBD_Alt, ...
    s57sim2_tab.time, s57sim2_tab.ROBD_final_Alt)
hold on
title('ROBD Altitude vs. Time')
xlabel('Time (in seconds)')
ylabel(hx(1), 'ROBD Altitude')
ylabel(hx(2), 'ROBD Final Altitude')

figure
plot(s57sim2_tab.time, s57sim2_tab.dp_time)
hold on
plot(s57sim2_tab.time, s57sim2_tab.ROBD_Elapsed_Time)
plot(s57sim2_tab.time, s57sim2_tab.ROBD_Remaining_Time)
plot(s57sim2_tab.time, s57sim2_tab.GTEC_Time)
title('Clocks vs. Time')
xlabel('Time (in seconds)')
ylabel('Alternate Clock')
legend('DP Time',...
    'ROBD Elapsed Time',...
    'ROBD Remaining Time',...
    'GTEC Time',...
    'location', 'best')

figure
plot(diff(s57sim2_tab.time))