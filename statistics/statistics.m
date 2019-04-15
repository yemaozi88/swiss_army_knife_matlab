function y = statistics(x)
% function y = statistics(x)
% calculate mean, max, min and std over x and store them into y.
%
% INPUT 
%  x: n x 1 vector
% OUTPUT
%  y: structure which has the following elements:
%   - mean
%   - max
%   - min:
%   - std: standard deviation
%
% HISTORY
% 2016/09/19 functionized.
%
% AUTHOR
% Aki Kunikoshi
% 428968@gmail.com
%

y.min    = min(x);
y.max    = max(x);
y.mean   = mean(x);
%y.median = median(x);
y.std    = std(x);
end