function Y = PCA_Trans(X, EVec,  u, n)
% Y = PCA_Trans(X, EVec,  u, n)
% Project the data into the subspace spanned by the eigenvectors of PCA
% 
% INPUT
% X:  mxd data matrix;
%   m: the number of sample;
%   d: the dimension of data set; 
%   each row of X  is a sample vector
% EVec: Eigenvectors
% u: mean
% n: the number of egien vectors used
% OUTPUT
% Y: transformed data
%
% HISTORY
% 2008-10-14 this program and PCA.m was gaven by Mr.Qiao
%

if nargin<4
    n = size(X, 2);
end
% k : data length
% d : dimention
[k, d] = size(X);

% repeat u k times in the direction of row
u = repmat(u, k,1);

% project
Y = (X-u) * EVec(:, 1:n);