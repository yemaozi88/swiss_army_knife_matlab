function ConfidenceInterval = calcConfidenceInterval(x)
% ConfidenceInterval = calcConfidenceInterval(x)
% calculate Confidence Interval.
%
% INPUT
%   x: n x 1 vector
% OUTPUT
%   ConfidenceInterval
%
% NOTE
% 
% HISTORY
% 2016/12/23
%
% AUTHOR
% Aki Kunikoshi
% 428968@gmail.com
%

% test

% standard error
SEM = std(x)/sqrt(length(x));

% T-Score
t = tinv([0.025 0.975], length(x)-1);

ConfidenceInterval = mean(x) + t*SEM;