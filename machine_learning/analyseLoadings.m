function [communalityPercent, contributionPercent, LoadingsSorted] = analyseLoadings(Loadings, specVar)
% [communalityPercent, contributionPercent, LoadingsSorted] 
%   = analyseLoadings(Loadings, specVar)
% calculate communality and contribution of Factor Analysis.
% In addition, Loadings will be sorted.
%
% INPUT
%   Loadings, specVar: can be obtained with factoran.
% OUTPUT
%   communalityPercent: how much variance is explained with common factors.
%       col1: index of the variable.
%       col2: communality in percent.
%   contributionPercent: how much contribute the factor.
%       row1: index of the factor.
%       row2: contribution in percent.
%   LoadingsSorted:
%       col1: index of the variable.
%       col2- : Loadings ^2
%       col(end): specVar
%
% HISTORY
% 2017/05/05 functionized
%
% AUTHOR
% Aki Kunikoshi
% 428968@gmail.com
%

%% test
%[Loadings, specVar, T, stats] = factoran(X, 5, 'rotate', 'varimax');


%% declare variables
[varNumMax, factorNumMax] = size(Loadings);
Loadings2  = Loadings .* Loadings;
LoadingsEx = [Loadings2, specVar];
id = 1:varNumMax;
id = id';


%% calculate communality
% - how much variance is explained with common factors
% - communality + specVar = 1
communality = sum(Loadings2, 2);
communalityPercent = [id, communality * 100];
communalityPercent = sortrows(communalityPercent, 2);
communalityPercent = flipud(communalityPercent);


%% calculate contribution
% how much contribute each factor.
contribution = sum(LoadingsEx, 1);
contributionPercent = contribution ./ sum(contribution) * 100;
idx = 1:size(contributionPercent, 2)-1;
contributionPercent = [idx, 0; contributionPercent];
clear idx


%% sort Loadings
LoadingsEx = [id, LoadingsEx];
clear id

% find the most contributing factor
maxFactor = zeros(varNumMax, 1);
for varNum = 1:varNumMax
    line = LoadingsEx(varNum, 2:end-1);
    [~, maxFactor(varNum, 1)] = max(line);
end % varNum
clear line varNum

LoadingsSorted = [];
for factorNum = 1:factorNumMax;
    lines = LoadingsEx(find(maxFactor==factorNum), :);
    lines = flipud(sortrows(lines, factorNum+1));
    LoadingsSorted = [LoadingsSorted; lines];
end % varNum
clear lines varNum

end % function