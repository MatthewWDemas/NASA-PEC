

%% Model 4, group1, a: Physio B and HP B
model4_g1_a = score(group1,1:4);

m4_G1_Va_pb_hpb = horzcat(PhysioB(group1,:), HP_B(group1,:));

[~, pval_m4_G1_Va_pb_hpb] = ...
    FeatTTestMatrix(m4_G1_Va_pb_hpb , ...
    1:60, 1:36, 0, []);

figure;
image(pval_m4_G1_Va_pb_hpb, 'CDataMapping', 'scaled')
caxis manual
caxis([0,0.05])
colormap('hot')
colorbar
% colormap(flipud(colormap))
title('P-values between Physio (B) and PCA 1-4 (HP_B)')

good_vals = [2 3 5 6 7 15 20 29 30 31 44 45 46 48 49 50 51 52 53 54 55];

HP_B_29class = (HP_B(group1,29) >= 0);

figure
k=0;
for i = 1:length(good_vals)
    for j = i+1:length(good_vals)
        k=k+1;
        strcat('i: ', num2str(i),'j: ',  num2str(j),'k: ',  num2str(k))
        if mod(k,35) == 0
            figure
        end
        subplot(7,5,mod(k,35)+1)
        gscatter(PhysioB(group1, i), PhysioB(group1,j),HP_B_29class);
        xlab = strcat('PhysioB Var', num2str(good_vals(i)));
        ylab = strcat('PhysioB Var', num2str(good_vals(j)));
        plot_title = strcat(num2str(k), ': Model 4, Group1, Ver-a: PhysioB, HPB';
        xlabel(xlab);
        ylabel(ylab);
        title(plot_title);
    end
end

model4_G1_Va_feat = PhysioB(group1, good_vals);

model4_G1_Va = horzcat(model4_G1_Va_feat, HP_B_29class);

figure;
histfit(HP_B(group1, 29))
title('Histogram of Group 1 Tracking Std Dev with Normal Overlay')