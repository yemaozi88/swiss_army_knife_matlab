function dtwCal(X, Y, fout)
% dtwCal(X, Y, fout)
% function for Dynamic time warping with csv output
%
% INPUT
% X, Y: time series of vectors, dim x frame#
% fout: csv file which indices will be written 
%
% LINK
% dtw.m
%
% AUTHOR
% Aki Kunikoshi (D2)
% yemaozi88@gmail.com
%

[p, q] = dtw(X, Y);

%% output
OUT = [p; q];
OUT = OUT';
csvwrite(fout, OUT);