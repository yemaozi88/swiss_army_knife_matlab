function [EVec, EVal, u] = PCA(X)
% [EVec, EVal, u] = PCA(X)
% PCA analysis
%
% INPUT
% X:  mxd data matrix;
%   m: the number of sample;
%   d: the dimension of data set; 
%   each row of X  is a sample vector
% OUTPUT
% EVec: Eigenvectors
% EVal: Eigenvalues
% u: mean
%
% HISTORY
% 2008/10/14 Qiao gave this program and PCA_Trans.m to Kunikoshi
%
% AUTHOR
% Yu Qiao
% qiao@gavo.t.u-tokyo.ac.jp
%

u = mean(X);
C = cov(X);
[EVec, EVal] = eig(C);

d = size(X, 2);
EVal = diag(EVal);
EVal = EVal(d:-1:1);
EVec = EVec(:, d:-1:1);
%[COEFF, SCORE, LATENT] = princomp(X);
%a=1;