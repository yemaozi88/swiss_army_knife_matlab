function [result, resultVec] = calcPerformance(predictions, answers)
% result = calcPerformance(predictions, answers)
% calculate performance of the system. 
% Performance is evaluated with:
%   sensitivity
%   specificity
%   precision
%   accuracy
%   F1
%
% INPUT
% predictions, answers: nx1 vectors
%   each component takes binary value; 
%   positive - 1, negative - 0.
% OUTPUT
% result: structure
%   sensitivity
%   specificity
%   precision
%   accuracy
%   F1
%
% HISTORY
% 2016/03/02 functionized
%
% AUTHOR
% Aki Kunikoshi
% 428968@gmail.com
%

%% test
% predictions;
% answers = y_test_all;


%% if the length of predictions and that of answers are not match, error.
if length(predictions) ~= length(answers)
    error('the length of predictions and that of answers does not match!');
end


%% get TruePositive, TrueNegative, FalsePositive, FalseNegative
sampleSize = length(predictions);
[positiveSampleNum_, ~] = find(answers == 1);
positiveSampleNum = length(positiveSampleNum_);
negativeSampleNum = sampleSize - positiveSampleNum;
clear positiveSampleNum_

[idx, ~] = find(predictions == 1 & answers == 1);
TP = length(idx);
[idx, ~] = find(predictions == 0 & answers == 1);
FN = length(idx);
[idx, ~] = find(predictions == 0 & answers == 0);
TN = length(idx);
[idx, ~] = find(predictions == 1 & answers == 0);
FP = length(idx);

sensitivity = TP/(TP+FN) * 100;
specificity = TN/(TN+FP) * 100;
precision   = TP/(TP+FP) * 100;
accuracy    = (TP+TN) / sampleSize * 100;
F1          = 2*TP/(2*TP + FP + FN) * 100;
result.sensitivity = sensitivity;
result.specificity = specificity;
result.precision   = precision;
result.accuracy    = accuracy;
result.F1          = F1;
resultVec = [sensitivity, specificity, precision, accuracy, F1];

end % function