function [X_train, X_test] = splitTrainTest(X, train_size)
% function [X_train, X_test] = splitTrainTest(X, train_size)
% Split arrays or matrices into random train and test subsets.
%
% INPUT
% X: input data (# of sample x # of dimension).
% train_size (optional): 
%   the proportion of the dataset to include in the test split.
%   between 0.0 and 1.0. default is 0.8.
%
% OUTPUT
% X_train, X_test: subset of X.
%
% HISTORY
% 2018/12/20 functionized.
%
% AUTHOR
% Aki Kunikoshi
% 428968@gmail.com
%


%% if the train_size is not set or wrong, set default value.
if nargin == 1
    disp('train_size is not set.');
    disp('train_size is set to be the default value: 0.8.');
elseif nargin == 2
    if train_size > 1 || train_size < 0
        disp('train_size is not between 0 and 1.');
        disp('train_size is set to be the default value: 0.8.');
    end
else
    error('wrong arguments.');
end


%% split data.
dataNum_train = round(size(X, 1) * train_size);
[X_train, ~]  = extractRandomData(X, dataNum_train);
X_test        = setdiff(X, X_train, 'rows');
