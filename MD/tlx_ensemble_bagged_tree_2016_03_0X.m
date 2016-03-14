function [trainedClassifier, validationAccuracy] = trainClassifier(trainingData)
% trainClassifier(trainingData)
%  returns a trained classifier and its validation accuracy.
%  This code recreates the classification model trained in
%  Classification Learner app.
%
%   Input:
%       trainingData: the training data of same data type as imported
%        in the app (table or matrix).
%
%   Output:
%       trainedClassifier: a struct containing the trained classifier.
%        The struct contains various fields with information about the
%        trained classifier.
%
%       trainedClassifier.predictFcn: a function to make predictions
%        on new data. It takes an input of the same form as this training
%        code (table or matrix) and returns predictions for the response.
%        If you supply a matrix, include only the predictors columns (or
%        rows).
%
%       validationAccuracy: a double containing the validation accuracy
%        score in percent. In the app, the History list displays this
%        overall accuracy score for each model.
%
%  Use the code to train the model with new data.
%  To retrain your classifier, call the function from the command line
%  with your original data or new data as the input argument trainingData.
%
%  For example, to retrain a classifier trained with the original data set
%  T, enter:
%    [trainedClassifier, validationAccuracy] = trainClassifier(T)
%
%  To make predictions with the returned 'trainedClassifier' on new data T,
%  use
%    yfit = trainedClassifier.predictFcn(T)
%
%  To automate training the same classifier with new data, or to learn how
%  to programmatically train classifiers, examine the generated code.

% Auto-generated by MATLAB on 04-Mar-2016 16:44:09


inputTable = trainingData;
% Extract predictors and response
% This code processes the data into the right shape for training the
% classifier.
predictorNames = {'Subject', 'Run', 'Protocol', 'Sessionid', 'Runid', 'Task', 'Trial', 'Trialid', 'Session', 'SubjectTrial', 'PRQ', 'SessionOrder', 'RunOrder', 'CFT_TotalCombined', 'CFT_TotalCompleteScore', 'CFT_TotalCorrectScore', 'COG_DASCPUT', 'COG_DASCRTC', 'COG_DATDRTC', 'COG_DATIRTC', 'COG_DATSCAC', 'COG_MTSACC', 'COG_MTSPUT', 'COG_MTSRTC', 'COG_PFCACC', 'COG_PFCPUT', 'COG_PFCRTC', 'COG_SDCACC', 'COG_SDCPUT', 'COG_SDCRTC', 'COG_VSCACC', 'COG_VSCPUT', 'COG_VSCRTC', 'MATB_Comm', 'MATB_Overall', 'MATB_ResMgmt', 'MATB_Tracking', 'SIM_Altitude', 'SIM_Heading', 'SIM_Speed', 'Age', 'Height', 'Weight', 'TotalFlightHours', 'SixMonthsFlightHr', 'YearsFlying', 'DailyComputerHrs', 'ComputerGamesDaysPerMonth', 'ComputerGameHours', 'PercentFlightSim', 'X39', 'X40', 'X38', 'X1', 'X2', 'X3', 'X4', 'X5', 'X6', 'X7', 'X8', 'X9', 'X10', 'X11', 'X12', 'X13', 'X14', 'X15', 'X16', 'X17', 'X18', 'X20', 'X21', 'X22', 'X23', 'X24', 'X25', 'X26', 'X27', 'X28', 'X30', 'X31', 'X32', 'X33', 'X34', 'X35', 'X36', 'X37', 'X41', 'X42'};
predictors = inputTable(:, predictorNames);
response = inputTable.tlx_2class;

% Data transformation: Select subset of the features
% This code selects the same subset of features as were used in the app.
includedPredictorNames = predictors.Properties.VariableNames([false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false false true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true true false false false true]);
predictors = predictors(:,includedPredictorNames);

% Train a classifier
% This code specifies all the classifier options and trains the classifier.
template = templateTree(...
    'MaxNumSplits', 20);
classificationEnsemble = fitensemble(...
    predictors, ...
    response, ...
    'AdaBoostM1', ...
    30, ...
    template, ...
    'Type', 'Classification', ...
    'LearnRate', 0.1, ...
    'ClassNames', [-1; 1]);

trainedClassifier.PredictorNames = includedPredictorNames;
trainedClassifier.ClassificationEnsemble = classificationEnsemble;
extractPredictorsFromTableFcn = @(t) t(:, predictorNames);
predictorExtractionFcn = @(x) extractPredictorsFromTableFcn(x);
featureSelectionFcn = @(x) x(:,includedPredictorNames);
ensemblePredictFcn = @(x) predict(classificationEnsemble, x);
trainedClassifier.predictFcn = @(x) ensemblePredictFcn(featureSelectionFcn(predictorExtractionFcn(x)));
inputTable = trainingData;
% Extract predictors and response
% This code processes the data into the right shape for training the
% classifier.
predictorNames = {'Subject', 'Run', 'Protocol', 'Sessionid', 'Runid', 'Task', 'Trial', 'Trialid', 'Session', 'SubjectTrial', 'PRQ', 'SessionOrder', 'RunOrder', 'CFT_TotalCombined', 'CFT_TotalCompleteScore', 'CFT_TotalCorrectScore', 'COG_DASCPUT', 'COG_DASCRTC', 'COG_DATDRTC', 'COG_DATIRTC', 'COG_DATSCAC', 'COG_MTSACC', 'COG_MTSPUT', 'COG_MTSRTC', 'COG_PFCACC', 'COG_PFCPUT', 'COG_PFCRTC', 'COG_SDCACC', 'COG_SDCPUT', 'COG_SDCRTC', 'COG_VSCACC', 'COG_VSCPUT', 'COG_VSCRTC', 'MATB_Comm', 'MATB_Overall', 'MATB_ResMgmt', 'MATB_Tracking', 'SIM_Altitude', 'SIM_Heading', 'SIM_Speed', 'Age', 'Height', 'Weight', 'TotalFlightHours', 'SixMonthsFlightHr', 'YearsFlying', 'DailyComputerHrs', 'ComputerGamesDaysPerMonth', 'ComputerGameHours', 'PercentFlightSim', 'X39', 'X40', 'X38', 'X1', 'X2', 'X3', 'X4', 'X5', 'X6', 'X7', 'X8', 'X9', 'X10', 'X11', 'X12', 'X13', 'X14', 'X15', 'X16', 'X17', 'X18', 'X20', 'X21', 'X22', 'X23', 'X24', 'X25', 'X26', 'X27', 'X28', 'X30', 'X31', 'X32', 'X33', 'X34', 'X35', 'X36', 'X37', 'X41', 'X42'};
predictors = inputTable(:, predictorNames);
response = inputTable.tlx_2class;


% Perform cross-validation
partitionedModel = crossval(trainedClassifier.ClassificationEnsemble, 'KFold', 5);

% Compute validation accuracy
validationAccuracy = 1 - kfoldLoss(partitionedModel, 'LossFun', 'ClassifError');

% Compute validation predictions and scores
[validationPredictions, validationScores] = kfoldPredict(partitionedModel);