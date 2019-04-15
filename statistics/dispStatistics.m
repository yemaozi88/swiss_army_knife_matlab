function strStatistics = dispStatistics(x)
% function strStatistics = dispStatistics(x)
% display mean ** +- std ** ( min ** - max ** ).
%
% INPUT
% x: dataset (n x 1 vector).
% OUTPUT
% strStatistics: string formatted mean ** +- std ** ( min ** - max ** ).
% 
% HISTORY
% 2017/04/20 functionized.
%
% Aki Kunikoshi
% 428968@gmail.com
%

strStatistics = sprintf('%.2f +- %.2f (min %.2f - max %.2f)',...
    mean(x), std(x), min(x), max(x));
disp(strStatistics)