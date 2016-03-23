hpdata.RunOrder = categorical(hpdata.RunOrder);
hpdata.Session = categorical(hpdata.Session);
hpdata.Subject = categorical(hpdata.Subject);

hpdata2 = hpdata(hpdata.Subject ~= 'S16' & hpdata.Subject ~= 'S09' &...
    hpdata.Subject ~= 'S10' & hpdata.Subject ~= 'S34', :);

hpdata2 = hpdata(hpdata.Subject ~= ('S16' | 'S09' | 'S10' | 'S34',:);

hpdata2_slfirst = hpdata2(hpdata2.RunOrder == 'SL>15k' &...
    hpdata2.Session == 'MATB', :);
hpdata2_15kfirst = hpdata2(hpdata2.RunOrder == '15k>SL' &...
    hpdata2.Session == 'MATB', :);

%%
% 
% * Ther
% * ITEM2
% 

figure
boxplot(hpdata2.MATB_ResMgmt, hpdata2.RunOrder)
title('Box Plot of ResMan Scores for 1st vs 2nd Half Subjects')

resmanttest = ttest(hpdata2_slfirst.MATB_ResMgmt, hpdata2_15kfirst.MATB_ResMgmt);

mdl = fitlm(hpdata2, 'MATB_ResMgmt ~ RunOrder')

mdl.Residuals.Raw

%%
% 
% * Residuals are slightly skewed left.
% 

figure
plotResiduals(mdl)
title('Plot of Residuals for MATB ResMan vs. Run Order Model')

%%
% 
% * Appear that there is a noticeable serial correlation between residuals.
% 

figure
plotResiduals(mdl, 'lagged')
title('Plot of Serial Relationship Residuals for MATB ResMan vs. Run Order Model')


%%
% 
% * 
% 

figure
plotResiduals(mdl, 'symmetry')
title('Symmetry Plot of Residuals for MATB ResMan vs. Run Order Model')

dwtest(mdl) % 2.13

%%
% 
% * 
% 

figure
plotResiduals(mdl, 'fitted')
title('Residuals vs. Fitted for MATB ResMan vs. Run Order Model')


%%
% 
% * ITEM1
% * ITEM2
% 

rng default


se = std(bootstrp(...
         1000,@(bootr)fitlm(hpdata2, 'MATB_ResMgmt ~ RunOrder')
),mdl.Residuals.Standardized))