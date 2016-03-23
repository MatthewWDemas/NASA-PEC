%% Exploration of Matlab Machine Learning
% To test and understand appropriate machine learning techniques.

%% Introduction
% Classification vs. Regression

%% Machine Learning Methods
% 
% * fitctree
% * fitrtree
% * fitcdiscr
% * fitcknn
% * fitcnb
% * fitcsvm
% * fitrsvm
% * fitcecoc
% * fitensemble
% * TreeBagger

%% Steps to Data Analysis:
%
% # Prepare Data? on page 17-4
% # Choose an Algorithm? on page 17-4
% # Fit a Model? on page 17-5
% # Choose a Validation Method? on page 17-5
% # Examine Fit and Update Until Satisfied? on page 17-6
% 

%
%
%% Support for Both Categorical and Numerical Predictors
% 
% * Decision Tree
% * SVM
% * Naive Bayes
% * Ensemble
% 

%% Considerations
% What did I learn?
%% 
% 
% * Considerations for 
% * Flexibility
% * Categorical Variable Support
% 

Example
%% Examples
% DESCRIPTIVE TEXT
%%
% 
% * Kd-Tree
% * ITEM2
% 


load fisheriris
x = meas(:, 3:4);
gscatter(x(:,1), x(:,2), species)
legend('Location', 'best')

newpoint = [5 1.45];
line(newpoint(1), newpoint(2), 'marker', 'x', 'color', 'k',...
    'markersize', 10, 'linewidth', 2)

Mdl = KDTreeSearcher(x)

[n,d] = knnsearch(Mdl, newpoint, 'k', 10);
line(x(n,1), x(n,2), 'color', [.5 .5 .5], 'marker', 'o',...
    'linestyle', 'none', 'markersize', 10)

x(n, :)

xlim([4.5 5.5]);
ylim([1 2]);
axis square

tabulate(species(n))

ctr = newpoint - d(end);
diameter = 2*d(end);
h = rectangle('position', [ctr, diameter, diameter],...
    'curvature', [1 1]);
h.LineStyle = ':';

figure
newpoint2 = [5 1.45; 6 2; 2.75 0.75];
gscatter(x(:,1), x(:,2), species)
legend('location', 'best')
[n2, d2] = knnsearch(Mdl, newpoint2, 'k', 10);
line(x(n2, 1), x(n2, 2), 'color', [0.5 0.5 0.5], 'marker', 'o',...
    'linestyle', 'none', 'markersize', 10)
line(newpoint2(:, 1), newpoint2(:, 2), 'marker', 'x', 'color', 'k',...
    'markersize', 10, 'linewidth', 2, 'linestyle', 'none')

tabulate(species(n2(1,:)))
tabulate(species(n2(2,:)))
tabulate(species(n2(3,:)))


load ionosphere
ionosphere = array2table(X);
ionosphere.Group = Y;