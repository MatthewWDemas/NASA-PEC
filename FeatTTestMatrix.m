function [ ttestsignif, ttestpval ] = FeatTTestMatrix( FeatArr, physio_range, hp_range  )
%FeatTTestMatrix computes matrix of t-test significance values (binary) and 
% p-values  given a DataM array and locations of hp and physio features.
%   INPUT: 
%       DataM array
%       Range with location of "m" physio features
%       Range with location of "n" hp features
%   OUTPUT:
%       m x n matrices (significance and p-value of t-test
%


        % Remove Time Instance 1 from all subject trials
        DataM_noRA = FeatArr;
        DataM_noRA(any(DataM_noRA(:,37) == 1,2), :) = [];
        
        [~, num_physio] = size(physio_range);
        [~, num_hp] = size(hp_range);
        
        ttestpval = zeros(num_physio, num_hp);
        ttestsignif = zeros(num_physio, num_hp);
        hp_count = 0;
        
        % Selection for all derivative-based features except: (1) standard
        % deviation (always positive), (2) Min Tracking (always negative), (3) Max
        % Tracking (always positive).
        % Comm (y)    43-48
        % Comm (y')   49-54
        % ResMan (y)  55-60
        % ResMan (y') 61-66
        % Track (y)   67-72
        % Track (y')  73-78
        
%         hp_deriv = [49 50 54 61 62 66 73 74 78];
%         hp_deriv = hp_deriv + 36;
        hp_deriv = [];
        
        % Go through the HP features
        for hp_feat = hp_range
            %     hp_feat = 75; % Test Code
            hp_count = hp_count + 1;
            phys_count = 0;
            % Go through the physio vars
            for phys_feat = physio_range
                %         phys_feat = 1; % Test Code
                phys_count = phys_count + 1;
                tmp = DataM_noRA(:, [phys_feat hp_feat]);
                tmp(any(isnan(tmp),2),:) = [];
                
%                 % Check if feature is in list of derivatives
%                 if any(abs(hp_feat - hp_deriv) < 1e-10)
                    tmpz = tmp;
%                 else
%                     tmpz = zscore(tmp);
%                 end
                tmpz(:,3) = sign(tmpz(:,2));
                tmpAbove = tmpz(tmpz(:,3) > 0,:);
                tmpBelow = tmpz(tmpz(:,3) <= 0,:);
                [ttestsignif(phys_count, hp_count), ...
                    ttestpval(phys_count, hp_count)] = ...
                    ttest2(tmpAbove(:,1), tmpBelow(:,1));
            end
        end

end

