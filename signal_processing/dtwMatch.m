function Y = dtwMatch(X1, X2)
% function Y = dtwMatch(X1, X2)
% output matched frame series.
%
% INPUT
% - X1, X2: source/target time series of vectors, dim x frame#
% OUTPUT
% - Y: matched frame series.
%
% LINK
% dtw.m
%
% HISTORY
% 2019/05/14 functionized
%
% AUTHOR
% Aki Kunikoshi
% a.kunikoshi@gmail.com
%

X1 = 

%dtwCal(X, Y, CSV);
DPpath = csvread(CSV);
fnum = size(DPpath, 1);

% disp(size(X, 2))
% disp(size(Y, 2))
% disp(fnum)


%% make joint vector
fod  = fopen(fout, 'wb');

for ii = 1:fnum
    xid = DPpath(ii, 1);
    yid = DPpath(ii, 2);
    fwrite(fod, X(:, xid), 'float');
    fwrite(fod, Y(:, yid), 'float');
end
    
fclose(fod);