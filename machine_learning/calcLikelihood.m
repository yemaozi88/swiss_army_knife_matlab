function likelihood = calcLikelihood(obj, X)
% likelihood = calcLikelihood(obj, X)
% calculate log likelihood.
%
% INPUT
% obj: an object created by gmdistribution or fitgmdist.
% X: m x d data matrix;
%   m: the number of sample;
%   d: the dimension of data set; 
%   each row of X is a sample vector
% OUTPUT
% likelihood
%
% HISTORY
% 2017/03/02 functionized.
%
% AUTHOR
% Aki Kunikoshi
% 428968@gmail.com
%

% % test
% X = input;
% obj = obj0;

% calculate likelihood
[dataNumMax, varNumMax] = size(X);
objpdf = obj.pdf(X);

% % objpdf can be calculated as below
% mu     = obj.mu; % mixNumMax x varNumMax
% Sigma  = obj.Sigma; % 1 x varNumMax x mixNumMax
% weight = obj.ComponentProportion; % 1 x mixNumMax
% mixNumMax = obj.NumComponents;
% P = zeros(dataNumMax, mixNumMax); % dataNumMax x mixNumMax
% for mixNum = 1:mixNumMax
%     mu_ = mu(mixNum, :);
%     Sigma_ = Sigma(:, :, mixNum);
%     % multi-variate probabilitic density function
%     P(:, mixNum) = mvnpdf(X, mu_, Sigma_);
% end % mixNum
% objpdf2 = P * weight';
% [objpdf, objepdf2]

likelihood = nansum(log(objpdf));

end % function