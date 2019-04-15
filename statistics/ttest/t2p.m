function p = t2p(t, DoF, tailNum)
% p = t2p(t, DoF)
% convert t value to p value.
%
% INPUT
%   t: t-value
%   Dof: Degree of Freedom
%   tailNum (optional): 1 - 1 tailed, 2 or other - 2 tailed (default)
% OUTPUT
%   p: p-value
%
% NOTE
%   this function is copied from the followin link:
% https://jp.mathworks.com/matlabcentral/answers/175091-how-to-calculate-2-tailed-p-value-using-t-value-and-degree-of-freedom
% 
% HISTORY
% 2016/12/22
%
% AUTHOR
% Aki Kunikoshi
% 428968@gmail.com
%

% test
%t =  4;
%DoF = 10;

%% 2 tailed by default.
if nargin == 2 || tailNum ~= 1
    tailNum = 2;
end 

% 2-tailed t-distribution
p = 1-betainc(DoF/(DoF+t^2), DoF/2, 0.5, 'upper');
    
% 1-tailed
if tailNum == 1
    p = p/2;
end % tailNum