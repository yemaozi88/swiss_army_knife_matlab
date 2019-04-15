function [Y, extractedIdx] = extractRandomData(X, subsetSize)
% [Y, extractedIdx] = extractRandomData(X, subsetSize)
% extract subset of the data randomly.
%
% INPUT
% X: input data (# of sample x # of dimension).
% subsetSize: the number of the samples in the subset.
%
% OUTPUT
% Y: subset of X.
% extractedIdx: index of extracted data.
%
% HISTORY
% 2015/10/09 set extractedIdx as an output.
% 2015/08/25 functionized.
%
% AUTHOR
% Aki Kunikoshi
% 428968@gmail.com
%


%% test data
% X = 0:10:100;
% X = X';
% subsetSize = 3;


%% if subset number is not entered or wrong, quit
if nargin ~= 2 || subsetSize < 1
    error('please check the arguments!');
end


%% randomise the data
dataSize = size(X, 1);
randIdx = randperm(dataSize);


%% extract the subset
extractedIdx = randIdx(1:subsetSize);
Y = X(extractedIdx, :);