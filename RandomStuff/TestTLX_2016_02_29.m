

hpdatav2.Session = nominal(hpdatav2.session);
hpdatav2.Run = nominal(hpdatav2.run);
hpdatav2.Run = reorderlevels(hpdatav2.Run, {'RA', 'SL', '15k'});

figure
boxplot(hpdatav2.tlx_score, hpdatav2.Session)
title('TLX Scores by Session')

figure
boxplot(hpdatav2.tlx_score, hpdatav2.Run)
title('TLX Scores by Run')

grpstats(hpdatav2,{'Session', 'Run'}, 'mean', 'DataVars', 'tlx_score')
