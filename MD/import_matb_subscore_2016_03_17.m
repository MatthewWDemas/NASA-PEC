
% call to import pec_data
% call to import matb_ts
load pec_data;
load matb_ts;

% Join tables and select numerical values
pec_data.Session = categorical(pec_data.Session);
matb_ts_pec = innerjoin(pec_data(pec_data.Session == 'MATB', [1:10 100:104]), ...
    matb_ts,...
    'Keys', {'Subject', 'Run'});

    matb_ts_pec_wide = unstack(matb_ts_pec, '
    matb_ts_part = matb_ts_part(:, [11:14 25:28]);
matb_ts_part_wide_sl
matb_ts_part_wide_15k 




% Convert to numerical array
matb_ts_array = table2array(matb_ts_part);

MATBRA_Track
MATBSL_Track
MATB15k_Track



MATBRA = {CommRA, ResManRA, TrackingRA};
MATBSL = {CommSL, ResManSL, TrackingSL};
MATB15k = {Comm15k, ResMan15k, Tracking15k};

Perform{3} = {MATBRA, MATBSL, MATB15k};
