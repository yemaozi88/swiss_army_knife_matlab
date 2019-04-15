function [h, t, p] = ttest2tail(a, b, pLimit)
% function [h, t, p] = ttest2tail(a, b, pLimit)
% 2 tailed paired t test
%
% INPUT
% a: data 1 (dataNum x 1)
% b: data 2 (dataNum x 1)
% pLimit: limit value of p
% OUTPUT
% h: 0 - 
% t: t-value
% p: p-value
%
% NOTE
% ttest2tail.csv is required.
%
% HISTORY
% 2016/12/22 bugfix: sigLevel -> alpha, p -> t
% 2015/02/04
%
% AUTHOR
% Aki Kunikoshi
% 428968@gmail.com
%

%% testdata
% a = [90; 75; 75; 75; 80; 65; 75; 80];
% b = [95; 80; 80; 80; 75; 75; 80; 85];
% a = [0; 0; 0; 0; 0; 0; 0; 0];
% b = [0; 0; 0; 0; 0; 0; 0; 0];

assert(nargin == 3, ...
 'input arguments should be 3.')
assert(size(a, 1) == size(b, 1), ...
 'input vectors should have the same size.')
assert(size(a, 1) < 200, ...
 'the size of input vector should be < 200.')
 
sampleNumMax = size(a, 1); % = size(b, 1)
DoF = sampleNumMax - 1;

diffMean = mean(a-b);
diffStdError = sqrt(var(a-b)/sampleNumMax);
if diffStdError == 0
    t = NaN;
    p = NaN;
    
    h = NaN;
else
    t = diffMean/diffStdError;
    p = t2p(t, DoF, 2);
    
    % significantly different?
    if abs(p) <= pLimit
        h = 1;
    else
        h = 0;
    end
end

end % function