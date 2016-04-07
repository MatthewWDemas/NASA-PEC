%------------ Neural Net Prep -----------------------------
DataM_MATB = DataM(DataM(:,40) == 3,:); % Only MATB trials
DataM_MATB = DataM(DataM_MATB(:,38) ~= 1,:); % Remove Room Air Trials

% Columns with Actual Predictors: 1-35 + 42

DataM_MATB_nn = DataM_MATB(:, [1:35 42 46]);
DataM_MATB_nn(any(isnan(DataM_MATB_nn),2),:) = [];
DataM_MATB_nn(abs(zscore(DataM_MATB_nn(:,37))) > 3,:) = [];


DataM_MATB_nn_feat = DataM_MATB_nn(:, 1:36);
DataM_MATB_nn_resp = DataM_MATB_nn(:,37);

find(abs(zscore(DataM_MATB_nn_resp)) > 3)


figure
histfit(zscore(DataM_MATB_nn_resp))

pool = gcp;
pool.NumWorkers % 6 on MacPro
net2 = train(net1, x, t, 'useParallel', 'yes');
y = net2(x, 'useParallel', 'yes');

DataM_MATB_cluster = DataM_MATB(:, [43:54]);
DataM_MATB_cluster(any(isnan(DataM_MATB_cluster),2),:) = [];

DataM_MATB_cluster_z = zscore(DataM_MATB_cluster);
indices = find(abs(DataM_MATB_cluster_z(:,:)) > 3);
DataM_MATB_cluster_z(indices) = [];

gpuDeviceCount
