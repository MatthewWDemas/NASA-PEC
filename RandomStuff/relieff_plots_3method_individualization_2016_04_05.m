% Import Large (222 Column) DataM matrix with 3 methods of feature
% individualization.
% Loop through each HP feature from each method type (GIVEN column
% range of physio AND column range of HP).
% Compute relieff plot for GIVEN level of K (10...??).
% Put in subplot grid, for each Method Type

load('../DataExportMATLAB/DataM_3_feat_version_v1_2016_04_04.mat')

DataM = DataM_3_feat_version;
DataM_noRA = DataM(DataM(:,38) ~= 1 & DataM(:,40) == 3 & DataM(:,37) ~= 1,:);


%---------------- Un-individualized Features -----------------------------
y_physio_cols = [1:34 36 42];
y_hp_cols = [43:78];
k = 10;

[y_all_ranked, y_all_weights] = ...
    MultiwayReliefF(DataM_noRA, y_physio_cols, y_hp_cols, k);

figure
b=bar3(y_all_weights)
ylabel('Physio Features')
xlabel('y_1 Differenced Individualized HP Features')
title('ReliefF Weights (Time Instance 1 Removed)')
colorbar

for k = 1:length(b)
    zdata = b(k).ZData;
    b(k).CData = zdata;
    b(k).FaceColor = 'interp';
end


%----------------y1 Diff Individualized Features --------------------------
y1diff_physio_cols = 79:114;
y1diff_hp_cols = 115:150;
k = 10;

[y1diff_all_ranked, y1diff_all_weights] = ...
    MultiwayReliefF(DataM_noRA, y1diff_physio_cols, y1diff_hp_cols, k);

figure
b=bar3(y1diff_all_weights)
ylabel('Physio Features')
xlabel('y_1 Differenced Individualized HP Features')
title('ReliefF Weights (Time Instance 1 Removed)')
colorbar

for k = 1:length(b)
    zdata = b(k).ZData;
    b(k).CData = zdata;
    b(k).FaceColor = 'interp';
end



%----------------Lag Diff Individualized Features -------------------------
lagdiff_physio_cols = 151:186;
lagdiff_hp_cols = 187:222;
k = 10;

[lagdiff_all_ranked, lagdiff_all_weights] = ...
    MultiwayReliefF(DataM_noRA, lagdiff_physio_cols, lagdiff_hp_cols, k);

figure
b=bar3(lagdiff_all_weights)
ylabel('Physio Features')
xlabel('Lag Differenced Individualized HP Features')
title('ReliefF Weights (Time Instance 1 Removed)')
colorbar

for k = 1:length(b)
    zdata = b(k).ZData;
    b(k).CData = zdata;
    b(k).FaceColor = 'interp';
end


% ------ Sum of Weights for All Plots -------------------------
y_all_weights_cleaned = y_all_weights;
y_all_weights_cleaned(any(isnan(y_all_weights_cleaned), 2),:) = [];
y1diff_all_weights_cleaned = y1diff_all_weights;
y1diff_all_weights_cleaned(any(isnan(y1diff_all_weights_cleaned), 2),:) = [];
lagdiff_all_weights_cleaned = lagdiff_all_weights;
lagdiff_all_weights_cleaned(any(isnan(lagdiff_all_weights_cleaned), 2),:) = [];

figure;
subplot(3,1,1)
bar(sum(y_all_weights_cleaned));
ylim([-0.5 1])
title('Sum of Weights for Each HP Feature for Un-individualized Features');
subplot(3,1,2)
bar(sum(y1diff_all_weights_cleaned))
ylim([-0.5 1])
title('Sum of Weights for Each HP Feature for y_1 Diff Individualized Features');
subplot(3,1,3)
bar(sum(lagdiff_all_weights_cleaned))
ylim([-0.5 1])
title('Sum of Weights for Each HP Feature for Lag Diff Individualized Features');
% legend('Sum of Weights for Each HP Feature for y_1 Diff Individualized Features',...
%     'Sum of Weights for Each HP Feature for Lag Diff Individualized Features',...
%     'location', 'best')
