function [corrMatrix, idxHighCorr] = calcCorrelationMatrix(x, threshold)
% [corrMatrix, idxHighCorr] = calcCorrelationMatrix(x, threshold)
% calculate correlation matrix.
%
% INPUT
%   x: n x d matrix.
%   threshold: optional. If you want to search variable pairs those
%   correlation is higher than specific threshold, set this value.
% OUTPUT
%   corrMatrix: correlation matrix
%   idxHighCorr: correlation higher than threshold
%
% HISTORY
% 2017/05/04 functionized
%
% AUTHOR
% Aki Kunikoshi
% 428968@gmail.com
%


%% test
% clear all, fclose all, clc;
% dirMain = 'c:\Users\A.Kunikoshi\OneDrive - McRoberts\Projects\AnalysisAllData';
% load([dirMain '\ExcelData\cleaned.mat']);
% x = variables;
% clear variables
% clear removedCols removedRows
% clear dirMain fin
% clear dataNumMax variableNumMax
% clear variableNameList


%% if the threshold is specified load it
if nargin == 1
    threshold = 0;
end


%% calculate correlation matrix
variableNumMax = size(x, 2);
corrMatrix = zeros(variableNumMax, variableNumMax);
idxHighCorr = []; % highly correlated (= more than threshold) variables
for var1 = 1:variableNumMax
    for var2 = var1+1:variableNumMax
        a = corrcoef(x(:, var1), x(:, var2));
        corrVal = a(1, 2);
        corrMatrix(var1, var2) = corrVal;
        if abs(corrVal) >= threshold
            idxHighCorr = [idxHighCorr; var1, var2];
        end
        clear a
    end % var2
end % var1
clear var1 var2 corrVal