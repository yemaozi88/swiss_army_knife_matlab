function [p,q] = dtw(X,Y)
%% function [p,q] = dtw(X,Y);
%
% function for Dynamic time warping.
%
% usage: [p,q] = dtw(X,Y)
%  -input: X,Y (time series of vectors, dim x time)
%  -ouput: p,q: indices 
%
% 
% HISTORY
% 2010/04/23 Saito gave Kunikoshi this program
%
% AUTHOR
% Daisuke Saito (M2)
%

if (nargin ~= 2)
    error('usage: [p,q] = dtw(X,Y);');
end

if (size(X,1) ~= size(Y,1))
    error('X and Y should be of same dimensionality');
end

M = make_disMat(X,Y);

[r,c] = size(M);

% costs
D = zeros(r+1, c+1);
D(1,:) = NaN;
D(:,1) = NaN;
D(1,1) = 0;
D(2:(r+1), 2:(c+1)) = M;

% traceback
phi = zeros(r,c);

for ii = 1:r; 
  for jj = 1:c;
    [dmin, tb] = min([D(ii, jj)+D(ii+1,jj+1),D(ii, jj+1), D(ii+1, jj)]);
    D(ii+1,jj+1) = D(ii+1,jj+1)+dmin;
    phi(ii,jj) = tb;
  end
end
clear D

% TRACEBACK
ii = r; 
jj = c;
p = ii;
q = jj;

while ii > 1 || jj > 1
  tb = phi(ii,jj);
  ii = ii - floor((4-tb)/2);
  jj = jj - mod(4-tb,2);
  
  p = [ii,p];
  q = [jj,q];
end

%% function D = make_disMat(X,Y)
% 
function D= make_disMat(X,Y)
xx = sum(X.*X,1);
yy = sum(Y.*Y,1);
xy = X'*Y;

% D = sqrt(abs(repmat(xx',[1 size(yy,2)]) + repmat(yy,[size(xx,2) 1]) - 2*xy));
D = abs(repmat(xx',[1 size(yy,2)]) + repmat(yy,[size(xx,2) 1]) - 2*xy);
