% Explore how to cutoff histogram
figure
for i = 1:5
    title_txt = strcat('Histogram of Mean Sp O_2 during Time Instance ', num2str(i));
    data = DataM(DataM(:,  38) == 3 & DataM(:, 37) == i, 36);
    meandatai = mean(data);
    stddatai = std(data);
    subplot(5,1,i)
    histfit(data);
    xlim([70 100]);
    ylim([0 36]);
    title(title_txt);
    text(72,22, strcat('Mean: ', num2str(meandatai)));
    text(72,10, strcat('Std Dev: ', num2str(stddatai)));
%     legend(num2str(meandatai),...
%         num2str(stddatai),...
%         'location', 'best');
end

% Quantile Norm
quantilenorm(DataM_noRA), 'Display', 'true')

lmstat