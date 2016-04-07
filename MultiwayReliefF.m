function [all_ranked, all_weights] = MultiwayReliefF(DataM_noRA, physio_cols, hp_cols, k)
%MultiwayReliefF Computes relieff algorithm ranks and weights for multiple
% reponses and predictors.
%   INPUT: 
%       Data Array
%       Predictor Columns
%       Response Columns
%       K value to use
%   OUTPUT:
%       2 arrays (predictors are rows, responses are columns)
%       all_ranked (array of ranks)
%       all_weights (array of weights)

    all_ranked = nan*ones(length(physio_cols), length(hp_cols));
    all_weights = nan*ones(length(physio_cols), length(hp_cols));
    i = 0;
    figure;
    for hp_feat = hp_cols
        i = i + 1;
        subplot(6,6,i)
        [ranked, weights] = relieff(DataM_noRA(:,physio_cols), DataM_noRA(:,hp_feat), k);
    %     bar(weights(ranked))
        plot(physio_cols, ranked)
        all_ranked(:,i) = ranked;
        all_weights(:,i) = weights;
        title(num2str(hp_feat))
    end
end
