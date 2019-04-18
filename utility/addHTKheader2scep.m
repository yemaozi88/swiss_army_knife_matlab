function addHTKheader2scep(fin, fout, DEG)
% addHTKheader2scep(fin, fout, DEG)
% adds HTK header to an scep file
%
% INPUT
% fin: scep file
% fout: scep file with HTK header (output)
% DEG: the number of factors per sample (0-DEG cepstrams)
%
% LINK
% loadBin.m
%
% NOTES
% HTK header in this function is written like below:
% - number of samples in file (4-byte integer)
% - sample period in 100[ns] units (4-byte integer) -> 1 [ms] = 10000 [100 ns]
% - number of bytes per sample (2-byte integer) -> (DEG+1) * 4 (float)
% - a code indicating the sample kind (2-byte integer) -> 9 (user)
% sample format is 'float'
%
% HISTORY
% 2011/08/01 modified so that it can treat any type of data 
% 2008/05/20 functionized
% 2008/03/04 made HTKheader.m to add HTK header to joint vector
%
% AUTHOR
% Kunikoshi Aki(M1)
% yemaozi88@gmail.com
%

% test
%fin = 'C:\Documents and Settings\kunikoshi\My Documents\Dropbox\gmm_original\scep\aa.scep';
%fout = 'C:\Documents and Settings\kunikoshi\My Documents\Dropbox\gmm_original\scep\aa.scep-htk';
%type = 'float';
%DEG = 20;

DEG = DEG + 1; % includes 0 deg

%% load files
A = loadBin(fin, type, DEG);
fmax = size(A, 2); % number of frames

%% write HTK header for fout
%fod = fopen(fout, 'wb');
fod = fopen(fout, 'wb', 'ieee-be');

% number of samples in file
fwrite(fod, fmax, 'int');
% sample period of 100[ns] unit
fwrite(fod, 10000, 'int');
% number of bytes per sample
fwrite(fod, DEG * 4, 'short');
% a code indicating the sample kind
fwrite(fod, 9, 'short');


%% write augument vector data for fout
for t = 1:fmax;
      fwrite(fod, A(:, t), 'float');
end

%% release memories
fclose(fod);