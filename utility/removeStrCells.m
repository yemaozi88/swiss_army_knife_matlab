function y = removeStrCells(x, str)
% function y = removeStrCells(x, str)
% remove 'string' from the cell array.
%
% INPUT 
%  x: 1 dimension cell array.
%  str: string to be removed.
% OUTPUT
%  y: x in which str is removed.
%
% HISTORY
% 2017/11/02 functionized.
%
% AUTHOR
% Aki Kunikoshi
% 428968@gmail.com
%

% % test
% x = {'cat', 'dog', 'cat', 'hourse'};
% str = 'cat';

idx = find(strcmp(x, str)==1);
y = x;
y(idx) = [];
end