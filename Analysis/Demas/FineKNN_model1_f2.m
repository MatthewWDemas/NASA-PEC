function [trainedClassifier, validationAccuracy] = FineKNN_model1_f2(trainingData)
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

% Auto-generated by MATLAB on 08-Apr-2016 19:54:58


% Convert input to table
inputTable = table(trainingData);
inputTable.Properties.VariableNames = {'column'};

% Split matrices in the input table into vectors
inputTable.column_1 = inputTable.column(:,1);
inputTable.column_2 = inputTable.column(:,2);
inputTable.column_3 = inputTable.column(:,3);
inputTable.column_4 = inputTable.column(:,4);
inputTable.column_5 = inputTable.column(:,5);
inputTable.column_6 = inputTable.column(:,6);
inputTable.column_7 = inputTable.column(:,7);
inputTable.column_8 = inputTable.column(:,8);
inputTable.column_9 = inputTable.column(:,9);

% Extract predictors and response
% This code processes the data into the right shape for training the
% classifier.
predictorNames = {'column_1', 'column_2', 'column_3', 'column_4', 'column_5', 'column_6', 'column_7', 'column_8'};
predictors = inputTable(:, predictorNames);
response = inputTable.column_9;

% Train a classifier
% This code specifies all the classifier options and trains the classifier.
classificationKNN = fitcknn(...
    predictors, ...
    response, ...
    'Distance', 'Euclidean', ...
    'Exponent', [], ...
    'NumNeighbors', 1, ...
    'DistanceWeight', 'Equal', ...
    'Standardize', true, ...
    'ClassNames', [0; 1]);

trainedClassifier.ClassificationKNN = classificationKNN;
convertMatrixToTableFcn = @(x) table(x, 'VariableNames', {'column'});
splitMatricesInTableFcn = @(t) [t(:,setdiff(t.Properties.VariableNames, {'column'})), array2table(table2array(t(:,{'column'})), 'VariableNames', {'column_1', 'column_2', 'column_3', 'column_4', 'column_5', 'column_6', 'column_7', 'column_8'})];
extractPredictorsFromTableFcn = @(t) t(:, predictorNames);
predictorExtractionFcn = @(x) extractPredictorsFromTableFcn(splitMatricesInTableFcn(convertMatrixToTableFcn(x)));
knnPredictFcn = @(x) predict(classificationKNN, x);
trainedClassifier.predictFcn = @(x) knnPredictFcn(predictorExtractionFcn(x));
% Convert input to table
inputTable = table(trainingData);
inputTable.Properties.VariableNames = {'column'};

% Split matrices in the input table into vectors
inputTable.column_1 = inputTable.column(:,1);
inputTable.column_2 = inputTable.column(:,2);
inputTable.column_3 = inputTable.column(:,3);
inputTable.column_4 = inputTable.column(:,4);
inputTable.column_5 = inputTable.column(:,5);
inputTable.column_6 = inputTable.column(:,6);
inputTable.column_7 = inputTable.column(:,7);
inputTable.column_8 = inputTable.column(:,8);
inputTable.column_9 = inputTable.column(:,9);

% Extract predictors and response
% This code processes the data into the right shape for training the
% classifier.
predictorNames = {'column_1', 'column_2', 'column_3', 'column_4', 'column_5', 'column_6', 'column_7', 'column_8'};
predictors = inputTable(:, predictorNames);
response = inputTable.column_9;


% Perform cross-validation
partitionedModel = crossval(trainedClassifier.ClassificationKNN, 'KFold', 5);

% Compute validation accuracy
validationAccuracy = 1 - kfoldLoss(partitionedModel, 'LossFun', 'ClassifError');

% Compute validation predictions and scores
[validationPredictions, validationScores] = kfoldPredict(partitionedModel);