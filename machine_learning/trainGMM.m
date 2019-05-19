function obj = trainGMM(X, gNum, mode)
% obj = trainGMM(X, gNum, mode)
% trains Gaussian Mixture Model
%
% INPUT
% X: m x d data matrix;
%   m: the number of sample;
%   d: the dimension of data set; 
%   each row of X is a sample vector
% gNum: the number of mixtures
% mode: 0 - full covariance, 1 - diagonal covariance
% OUTPUT
% obj: an object obj of the gmdistribution class containing maximum
% likelihood estimates of the parameters in a Gaussian mixture model
%
% NOTE
% this program is a simple version of TrainConvertModel.m
%
% HISTORY
% 2010/11/25 functionized
%
% AUTHOR
% Aki Kunikoshi
% a.kunikoshi@gmail.com
%


%% parameters for conversion
% they are the same parameters used in TrainConvertModel.m
para.gNum       = gNum;     % the number of mixtures

% default
para.MaxIter    = 500;   % maximum training iterations
para.TolFun     = 1e-05; % termination tolerance for the objective function value
para.RegCov     = 1e-04; % regularization of covariance matrix


%% Train GMM
% obj = gmdistribution(mu, sigma p);
%   mu: mean matrix, k x d
%       k: the number of factors
%       d: the number of dimension
%   sigma: covariance matrix, d x d x k
%   p: weight
%
% obj = gmdistribution.fit(X, k)
%   X: data, n x d
%       n: the number of data
options = statset('Display', 'final', 'MaxIter', para.MaxIter, 'TolFun', para.TolFun);
if mode == 0
    obj = gmdistribution.fit(X,  para.gNum, 'Regularize', para.RegCov, 'options', options) ;
elseif mode == 1
    obj = gmdistribution.fit(X,  para.gNum, 'Regularize', para.RegCov, 'CovType', 'diagonal', 'options', options) ;
end
%obj = gmdistribution.fit(X, para.gNum, 'options', options);

%BIC = zeros(1, para.gNum);
%for k = 1:para.gNum
%    obj = gmdistribution.fit(X, para.gNum, 'options', options);
%    BIC(k)= obj.BIC;
%end

%[xCovArr, xMeanArr, WArr, gNum] = ConvertMatlabGMM(obj);