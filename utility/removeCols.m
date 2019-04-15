function [y, idx] = removeCols(x, val)
% [y, idx] = removeCols(x, val)
% remove column(s) of x that contains val (numeral or NaN).
%
% INPUT
% x: a matrix.
% val: target value. default is NaN.
% OUTPUT
% y: the matrix after removing columns of x that contains val.
% idx: index of the column(s) of x that contains val.
% 
% HISTORY
% 2017/02/03 functionized.
%
% Aki Kunikoshi
% 428968@gmail.com
%

%% test data
% x = [NaN, 2, 3; 4, 6, 7; 5, 2, 6; 5, NaN, 3];
% val = 6;


%% check the input
if nargin == 1
    val = NaN;
end 

    
%% find val
if isnan(val)
    isVal = isnan(x);
else
    isVal = double(x == val);
end
isValsum = sum(isVal, 1);
idx = find(isValsum);
    

%% remove the column(s)
y = x;
y(:, idx) = [];
