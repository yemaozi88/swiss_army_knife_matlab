function dtwProc(X, Y, DIM, CSV, fout)
% dtwProc(X, Y, DIM, CSV, fout)
% makes joint vector using CSV file made by dtwCal.m
%
% INPUT
% X, Y: source/target time series of vectors, dim x frame#
% DIM: the number of dimension of X, Y
% CSV: csv file which indices of DPpath are written 
% foutS, foutT: source/target part of DTW aligned data
%
% LINK
% dtwCal.m
%
% HISTORY
% 2010/06/09 functionized
%
% NOTES
% This program is not checked
%
% AUTHOR
% Aki Kunikoshi (D2)
% yemaozi88@gmail.com
%

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