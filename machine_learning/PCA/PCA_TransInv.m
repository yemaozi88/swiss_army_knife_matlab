function Y = PCA_TransInv(X, EVec, u)
% Y = PCA_TransInv(X, EVec, u)
% decodes data from PCAed data, 
% the dimension of both data would be the same
% 
% INPUT
% X:  mxd data matrix;
%   m: the number of sample;
%   d: the dimension of data set; 
%   each row of X  is a sample vector
% EVec: Eigenvectors
% u: mean
% OUTPUT
% Y: transformed data
%
% NOTES
% - to get EVec, PCA.m should be execute in advance
% - or should be loaded by loadEigenParam.m
%
% HISTORY
% 2011/02/21 functionized based on PCA_Trans.m
%
% AUTHOR
% Aki Kunikoshi (D2)
% yemaozi88@gmail.com
%

% test
% clear all, clc, fclose('all');
% 
% EigenParamDir = 'C:\research\_gesture\transitionAmong16of28\dgvs\1\EigenParam';
% dgvFile = 'C:\research\_gesture\transitionAmong16of28\dgvs\2\01-02.dgvs';
% 
% [EVec, Eval, u] = loadEigenParam(EigenParamDir);
% X = loadBin(dgvFile, 'uchar', 26);
% X = X(5:22, :);
% X = X';
% 
% % original data
% %Xorg = X;
% X = PCA_Trans(X, EVec, u, d);

if nargin<3
    n = size(X, 2);
end

% k : data length
% d : dimention
[k, d] = size(X);

% repeat u k times in the direction of row
u = repmat(u, k,1);

% project
%Y = (X-u) * EVec(:, 1:n);
% decord
Y = X / EVec(:, 1:d) + u;
clear u