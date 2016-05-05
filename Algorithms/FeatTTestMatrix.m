function [ ttestsignif, ttestpval ] = FeatTTestMatrix( FeatArr, ...
    physio_range, hp_range, use_legacy_code, ignore_range)
%FeatTTestMatrix computes matrix of t-test significance values (binary) and 
% p-values  given a DataM array and locations of hp and physio features.
%   INPUT: 
%       DataM array
%       physio_range: Range with location of "m" physio features
%       hp_range: Range with location of "n" hp features
%       use_legacy_code: Binary value--should legacy code to split data set
%           based on z-scored HP values be used?
%       ignore_range: Range with location of features that will not be
%           z-scored if "use_legacy_code" is invoked.
%   OUTPUT:
%       m x n matrices (significance and p-value of t-test
%   The function splits a data set in two based on the negative or
%   non-negative z-scores or changes since some given time step.

        % Get sizes of input
        [~, num_physio] = size(physio_range);
        [~, num_hp] = size(hp_range);

        % Initialize arrays to hold pvalues and ttest significances
        ttestpval = zeros(num_physio, num_hp);
        ttestsignif = zeros(num_physio, num_hp);
        hp_count = 0;
                
        % Go through the HP features
        for hp_feat = hp_range
            %     hp_feat = 75; % Test Code
            hp_count = hp_count + 1;
            phys_count = 0;
            % Go through the physio vars
            for phys_feat = physio_range
                %         phys_feat = 1; % Test Code
                phys_count = phys_count + 1;
                tmp = FeatArr(:, [phys_feat hp_feat]);
                tmp(any(isnan(tmp),2),:) = [];
                switch use_legacy_code
                    case 1
                        % Legacy code--with raw features, some features
                        % need to be z-scored (std deviations etc).
                        % It was easier to specify the locations of
                        % features to not be included (at the time).
                        % This code checks if the raw score that should not
                        % be z-scored is in a list (if statement). If it
                        % is, it will not be z-scored, if it is not in the
                        % list the values are z-scored.
                        %
                        if any(abs(hp_feat - ignore_range) < 1e-10)
                            tmpz = tmp;
                        else
                            tmpz = zscore(tmp);
                        end
                    otherwise
                        tmpz = tmp;
                end
                tmpz(:,3) = sign(tmpz(:,2));
                tmpAbove = tmpz(tmpz(:,3) >= 0,:);
                tmpBelow = tmpz(tmpz(:,3) < 0,:);
                [ttestsignif(phys_count, hp_count), ...
                    ttestpval(phys_count, hp_count)] = ...
                    ttest2(tmpAbove(:,1), tmpBelow(:,1));
            end
        end

end

