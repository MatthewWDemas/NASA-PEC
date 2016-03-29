% Using RA data removed scores (outliers...?)
% Product 2 HP...Version 3 (HP Product 2 + Physio)
% DataM

ttestpval = ones(36) * NaN;

% Go through the HP features
for hp_feat = 4:39
% Go through the physio vars
    for phys_feat = [3 40:74]
        tmp = DataM_noRA(:, [phys_feat hp_feat]);
        tmpz = zscore(tmp);
        tmpz(:,3) = sign(tmpz(:,2));
        tmpAbove = tmpz(tmpz(:,3) > 0,:);
        tmpBelow = tmpz(tmpz(:,3) <= 0,:);
        ttestpval(phys_feat, hp_feat) = ttest2(tmpAbove, tmpBelow);
    end
end
        
% Get z-score
% Get signed value
% Split data array into 2 (based on pos/neg HP signed z-scored features)
% Conduct t-test
% store p-value in matrix (below diagonal missing)
