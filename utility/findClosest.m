function [valueFound, index] = findClosest(valueFind, signal)
% function [valueFound, index] = findClosest(valueFind, signal)
% find the closest value to valueFind in the signal
%
% INPUT
%  valueFind: value to find in the signal.
%  signal: nx1 vector.
% OUTPUT
%  valueFound: the value which is found to be the closest to valueFind.
%  index: index of the valueFound.
%
% HISTORY
% 2016/02/13 functionized
% 
% AUTHOR
% Aki Kunikoshi
% 428968@gmail.com
%

%% test data
% valueFind = accel_time;
% signal    = double(dur(n, 1));

signal_    = abs(signal-valueFind);
[~, index] = min(signal_);
valueFound = signal_(index);

end % function