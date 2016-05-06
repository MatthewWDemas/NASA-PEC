clear all

load('./Data/eventCountScaledPhysioData.m')

%% Executive Summary
% Scaling physiological variables by the number of MATB events does not
% appreciably change the non-parametric correlations between the variables
% and human performance scores.

%% Correlation Comparison

% HP A and Physio A
corrArray_Pa_HPa = nan * ones(66,36);
for iPhysioA = 1:66
    for jHPA = 1:36
        corrArray_Pa_HPa(iPhysioA, jHPA) = corr(PhysioA(:,iPhysioA), ...
            HP_A(:,jHPA), 'type', 'Spearman');
    end
end
max(max(abs(corrArray_Pa_HPa)))

corrArray_Pa_HPa_CommOwn = nan * ones(66,36);
for iPhysioA = 1:66
    for jHPA = 1:36
        corrArray_Pa_HPa_CommOwn(iPhysioA, jHPA) = corr(PhysioACommOwn(:,iPhysioA), ...
            HP_A(:,jHPA), 'type', 'Spearman');
    end
end
max(max(abs(corrArray_Pa_HPa_CommOwn)))

corrArray_Pa_HPa_CommOther = nan * ones(66,36);
for iPhysioA = 1:66
    for jHPA = 1:36
        corrArray_Pa_HPa_CommOther(iPhysioA, jHPA) = corr(PhysioACommOther(:,iPhysioA), ...
            HP_A(:,jHPA), 'type', 'Spearman');
    end
end
max(max(abs(corrArray_Pa_HPa_CommOther)))

corrArray_Pa_HPa_ResMan = nan * ones(66,36);
for iPhysioA = 1:66
    for jHPA = 1:36
        corrArray_Pa_HPa_ResMan(iPhysioA, jHPA) = corr(PhysioAResMan(:,iPhysioA), ...
            HP_A(:,jHPA), 'type', 'Spearman');
    end
end
max(max(abs(corrArray_Pa_HPa_ResMan)))

corrArray_Pa_HPa_ResMan_Pearson = nan * ones(66,36);
for iPhysioA = 1:66
    for jHPA = 1:36
        corrArray_Pa_HPa_ResMan_Pearson(iPhysioA, jHPA) = corr(PhysioAResMan(:,iPhysioA), ...
            HP_A(:,jHPA));
    end
end
max(max(abs(corrArray_Pa_HPa_ResMan_Pearson)))

corrArray_Pa_HPa_Total = nan * ones(66,36);
for iPhysioA = 1:66
    for jHPA = 1:36
        corrArray_Pa_HPa_Total(iPhysioA, jHPA) = corr(PhysioATotal(:,iPhysioA), ...
            HP_A(:,jHPA), 'type', 'Spearman');
    end
end
max(max(abs(corrArray_Pa_HPa_Total)))

figure;
image(abs(corrArray_Pa_HPa), 'CDataMapping', 'scaled')
caxis manual
caxis([0.3,1])
colormap('hot')
colorbar
xlabel('HP A Feature Number')
ylabel('Unscaled Physio A Feature Number')
title('Spearman Correlation')

figure;
image(abs(corrArray_Pa_HPa_CommOwn), 'CDataMapping', 'scaled')
caxis manual
caxis([0.3,1])
colormap('hot')
colorbar
xlabel('HP A Feature Number')
ylabel('Comm Own Scaled Physio A Feature Number')
title('Spearman Correlation')

figure;
image(abs(corrArray_Pa_HPa_CommOther), 'CDataMapping', 'scaled')
caxis manual
caxis([0.3,1])
colormap('hot')
colorbar
xlabel('HP A Feature Number')
ylabel('Comm Other Scaled Physio A Feature Number')
title('Spearman Correlation')

figure;
image(abs(corrArray_Pa_HPa_ResMan), 'CDataMapping', 'scaled')
caxis manual
caxis([0.3,1])
colormap('hot')
colorbar
xlabel('HP A Feature Number')
ylabel('ResMan Scaled Physio A Feature Number')
title('Spearman Correlation')

figure;
subplot(1,2,1)
image(abs(corrArray_Pa_HPa_CommOwn), 'CDataMapping', 'scaled')
caxis manual
caxis([0.3,1])
colormap('hot')
colorbar
xlabel('HP A Feature Number')
ylabel('Physio A Feature Number')
title('Spearman Correlation')
subplot(1,2,2)
image(abs(corrArray_Pa_HPa_CommOwn), 'CDataMapping', 'scaled')
caxis manual
caxis([0.3,1])
colormap('hot')
colorbar
xlabel('HP A Feature Number')
ylabel('Physio A Comm Own Scaled Feature Number')
title('Spearman Correlation')

figure;
image(abs(corrArray_Pa_HPa_ResMan), 'CDataMapping', 'scaled')
caxis manual
caxis([0.3,0.5])
colormap('hot')
colorbar
colormap(flipud(colormap))
xlabel('HP A Feature Number')
ylabel('Physio A Feature Number')
title('Spearman Correlation')

figure
for iPhysioA = 1:66
    subplot(11,6,iPhysioA)
    scatter(HP_A(:,2), PhysioAResMan(:,iPhysioA))
    xlabel('Median Comm Score')
    ylabel(strcat('Physio A Comm Own Scaled Feature # ', num2str(iPhysioA)))
end
    
%% HP B and Physio B (scaled)
corrArray_Pb_HPb = nan * ones(66,36);
for iPhysioA = 1:66
    for jHPA = 1:36
        corrArray_Pb_HPb(iPhysioA, jHPA) = corr(PhysioB(:,iPhysioA), ...
            HP_B(:,jHPA), 'type', 'Spearman');
    end
end
max(max(abs(corrArray_Pb_HPb)))

corrArray_Pb_HPb_CommOwn = nan * ones(66,36);
for iPhysioA = 1:66
    for jHPA = 1:36
        corrArray_Pb_HPb_CommOwn(iPhysioA, jHPA) = corr(PhysioBCommOwn(:,iPhysioA), ...
            HP_B(:,jHPA), 'type', 'Spearman');
    end
end
max(max(abs(corrArray_Pb_HPb_CommOwn)))

corrArray_Pb_HPb_CommOther = nan * ones(66,36);
for iPhysioA = 1:66
    for jHPA = 1:36
        corrArray_Pb_HPb_CommOther(iPhysioA, jHPA) = corr(PhysioBCommOther(:,iPhysioA), ...
            HP_B(:,jHPA), 'type', 'Spearman');
    end
end
max(max(abs(corrArray_Pb_HPb_CommOther)))

corrArray_Pb_HPb_ResMan = nan * ones(66,36);
for iPhysioA = 1:66
    for jHPA = 1:36
        corrArray_Pb_HPb_ResMan(iPhysioA, jHPA) = corr(PhysioBResMan(:,iPhysioA), ...
            HP_B(:,jHPA), 'type', 'Spearman');
    end
end
max(max(abs(corrArray_Pb_HPb_ResMan)))

corrArray_Pb_HPb_Total = nan * ones(66,36);
for iPhysioA = 1:66
    for jHPA = 1:36
        corrArray_Pb_HPb_Total(iPhysioA, jHPA) = corr(PhysioBTotal(:,iPhysioA), ...
            HP_B(:,jHPA), 'type', 'Spearman');
    end
end
max(max(abs(corrArray_Pb_HPb_Total)))


%% ReliefF Comparison

%% Test Code
[ranked, weight] = relieff(PhysioACommOwn, HP_A(:,25), 10);

figure;
bar(weight)
xlabel('Physio A Predictor Number')
ylabel('Weight')
title('Weights Unsorted')

figure;
bar(weight(ranked))
xlabel('Physio A Predictor Number')
ylabel('Weight')
title('Weights Sorted')

valueRange = 1:200;
relieffWeightsArray = nan * ones(66,length(valueRange));
relieffRankArray = nan * ones(66,length(valueRange));
i = 0;
for iKValue = valueRange
    i = i + 1;
    [relieffRankArray(:,i), ...
     relieffWeightsArray(:,i)] = ...
            relieff(PhysioACommOwn, HP_A(:,25), iKValue);
end

max(max(relieffWeightsArray))

figure;
image(relieffWeightsArray, 'CDataMapping', 'scaled')
caxis manual
caxis([0,0.0389])
colormap('hot')
colorbar
% colormap(flipud(colormap))
title('ReliefF Weights')

valueRange = 1:200;
relieffWeightsArrayB = nan * ones(66,length(valueRange));
relieffRankArrayB = nan * ones(66,length(valueRange));
i = 0;
for iKValue = valueRange
    i = i + 1;
    [relieffRankArrayB(:,i), ...
     relieffWeightsArrayB(:,i)] = ...
            relieff(PhysioA, HP_A(:,25), iKValue);
end

max(max(relieffWeightsArrayB))


figure;
subplot(1,2,1)
image(relieffWeightsArray, 'CDataMapping', 'scaled')
caxis manual
caxis([0,0.0389])
colormap('hot')
colorbar
% colormap(flipud(colormap))
title('ReliefF Weights Scaled by Own Comm Event Count')
subplot(1,2,2)
image(relieffWeightsArrayB, 'CDataMapping', 'scaled')
caxis manual
caxis([0,0.0384])
colormap('hot')
colorbar
% colormap(flipud(colormap))
title('ReliefF Weights Unscaled Scores')

diffRelieffWeightsArray = 100*(relieffWeightsArray - relieffWeightsArrayB)./relieffWeightsArrayB;

figure;
image(diffRelieffWeightsArray, 'CDataMapping', 'scaled')
caxis manual
caxis([0,100])
colormap('hot')
colorbar
xlabel('Neighborhood Size (k)')
ylabel('Physio Predictor #')
title('ReliefF Weights Percent Change for Mean Tracking Score')

figure
image(relieffRankArray, 'CDataMapping', 'scaled')
caxis manual
caxis([1,11])
colormap('hot')
colorbar
colormap(flipud(colormap))
xlabel('Neighborhood Size (k)')
ylabel('Physio Predictor #')
title('ReliefF Rank Comm Own Scaled')

figure
image(relieffRankArrayB, 'CDataMapping', 'scaled')
caxis manual
caxis([1,11])
colormap('hot')
colorbar
colormap(flipud(colormap))
xlabel('Neighborhood Size (k)')
ylabel('Physio Predictor #')
title('ReliefF Rank Unscaled Physio Features for Mean Tracking Response')

relieffWeightsArray(relieffRankArray(1:10,100),100)

(relieffRankArray(:,100)<=10)

figure
% bar(relieffWeightsArray(:,100))
bar(relieffWeightsArray(relieffRankArray(:,100),100))
xlabel('Comm Own Scaled PhysioA Feature #')
ylabel('RReliefF Weight')

figure
% bar(relieffWeightsArray(:,100))
bar(relieffWeightsArrayB(relieffRankArrayB(:,150),150))
xlabel('Un-Scaled PhysioA Feature #')
ylabel('RReliefF Weight')

figure
plot(valueRange, max(relieffWeightsArrayB(:,valueRange)))
hold on
plot(valueRange, max(relieffWeightsArray(:,valueRange)))
xlabel('RReliefF Neighborhood Size (k)')
ylabel('Maximum RReliefF Weight given k')
legend('Unscaled Physio A', 'Comm Own Scaled PhysioA',...
       'location', 'best')
