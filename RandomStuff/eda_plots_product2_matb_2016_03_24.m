figure
for i=4:15
    title_txt = strcat('Comm Feature -- ', num2str(i));
    subplot(4,3,i-3)
    h = histfit(DataM_noRA(:,i))
    h(1).FaceColor = [0.9 0.9 0.9];
    title(title_txt)
end
PrintFigPDF(gcf, ...
    '../DataExportMATLAB/product2_matb_comm_histfit_2016_03_24.pdf')


figure
for i=16:(16+11)
    title_txt = strcat('ResMan Feature -- ', num2str(i));
    subplot(4,3,i-15)
    h = histfit(DataM_noRA(:,i))
    h(1).FaceColor = [0.9 0.9 0.9];
    title(title_txt)
end
PrintFigPDF(gcf, ...
    '../DataExportMATLAB/product2_matb_resman_histfit_2016_03_24.pdf')

figure
for i=28:(28+11)
    title_txt = strcat('Track Feature -- ', num2str(i));
    subplot(4,3,i-27)
    h = histfit(DataM_noRA(:,i))
    h(1).FaceColor = [0.9 0.9 0.9];
    title(title_txt)
end
PrintFigPDF(gcf, ...
    '../DataExportMATLAB/product2_matb_track_histfit_2016_03_24.pdf')

figure
for i=4:15
    title_txt = strcat('Comm Feature -- ', num2str(i));
    subplot(4,3,i-3)
    h = normplot(DataM_noRA(:,i))
    title(title_txt)
end
PrintFigPDF(gcf, ...
    '../DataExportMATLAB/product2_matb_comm_qqplot_2016_03_24.pdf')

figure
for i=16:(16+11)
    title_txt = strcat('ResMan Feature -- ', num2str(i));
    subplot(4,3,i-15)
    h = normplot(DataM_noRA(:,i))
    title(title_txt)
end
PrintFigPDF(gcf, ...
    '../DataExportMATLAB/product2_matb_resman_qqplot_2016_03_24.pdf')


figure
for i=28:(28+11)
    title_txt = strcat('Track Feature -- ', num2str(i));
    subplot(4,3,i-27)
    h = normplot(DataM_noRA(:,i))
    title(title_txt)
end
PrintFigPDF(gcf, ...
    '../DataExportMATLAB/product2_matb_track_qqplot_2016_03_24.pdf')

%% Outliers Removed
% DESCRIPTIVE TEXT
figure
for i=4:15
    title_txt = strcat('Filtered Once: Comm Feature -- ', num2str(i));
    subplot(4,3,i-3)
    h = histfit(tmp(:,i))
    h(1).FaceColor = [0.9 0.9 0.9];
    title(title_txt)
end
PrintFigPDF(gcf, ...
    '../DataExportMATLAB/product2_matb_comm_histfit_filt1_2016_03_24.pdf')

figure
for i=16:(16+11)
    title_txt = strcat('Filtered Once: ResMan Feature -- ', num2str(i));
    subplot(4,3,i-15)
    h = histfit(zscore(tmp(:,i)))
    h(1).FaceColor = [0.9 0.9 0.9];
    title(title_txt)
end
PrintFigPDF(gcf, ...
    '../DataExportMATLAB/product2_matb_resman_histfit_filt1_2016_03_24.pdf')


figure
for i=28:(28+11)
    title_txt = strcat('Filtered Once: Track Feature -- ', num2str(i));
    subplot(4,3,i-27)
    h = histfit(tmp(:,i))
    h(1).FaceColor = [0.9 0.9 0.9];
    title(title_txt)
end

figure
for i=4:15
    title_txt = strcat('Filtered Once: Comm Feature -- ', num2str(i));
    subplot(4,3,i-3)
    h = normplot(tmp(:,i))
    title(title_txt)
end

figure
for i=16:(16+11)
    title_txt = strcat('Filtered Once: ResMan Feature -- ', num2str(i));
    subplot(4,3,i-15)
    h = normplot(tmp(:,i))
    title(title_txt)
end

figure
for i=28:(28+11)
    title_txt = strcat('Filtered Once: Track Feature -- ', num2str(i));
    subplot(4,3,i-27)
    h = normplot(tmp(:,i))
    title(title_txt)
end