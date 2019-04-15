function [combinationList, combinationListSize] = listAllCombinations(n, k)
% [combinationList, combinationListSize] = listAllCombinations(n, k)
% list all combinations - nCk.
%
% INPUT
% n, k: natural numbers.
% OUTPUT
% combinationList: the matrix after removing row(s) of x that contains val.
% combinationListSize: size of combinationList.
% 
% HISTORY
% 2017/02/09 functionized.
%
% Aki Kunikoshi
% 428968@gmail.com
%

indexArray = 1:n;
combinationList  = nchoosek(indexArray, k);
combinationListSize = size(combinationList, 1);