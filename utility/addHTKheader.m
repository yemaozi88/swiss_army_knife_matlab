function addHTKheader(fin, fout, type, NUM)
% addHTKheader(fin, fout, type, NUM)
% adds HTK header to feature files
%
% INPUT
% fin: augument vector file (input)
% fout: augument vector file added HTK header (output)
% type: sample format
% NUM: the number of factors per sample
%
% LINK
% loadBin.m
%
% NOTES
% HTK header in this function is written like below:
% - number of samples in file (4-byte integer)
% - sample period in 100[ns] units (4-byte integer) -> 10 * 10000
% - number of bytes per sample (2-byte integer) -> SNS * 4 (short)
% - a code indicating the sample kind (2-byte integer) -> 9 (user)
% this program is not tested yet
% add HTK header to dgv data with interpolation, use addHTKheader2dgv.m
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
%fin = 'D:\users\v-akkuni\feature\feature\100501.feature';
%fout = 'D:\users\v-akkuni\feature\feature-htk\100501.feature-htk';


%% file open
%fid = fopen(fin, 'rb');
%A = fread(fid, [DEG, inf], 'float');
%B = [A(1:18, :)/1000; A(19:36, :)];

fod = fopen(fout, 'wb', 'ieee-be');

% number of frames
A = loadBin(fin, type, NUM);
fmax = size(A, 2);


%% write HTK header for fout
%fod = fopen(fout, 'wb');
fod = fopen(fout, 'wb', 'ieee-be');

% number of samples in file
fwrite(fod, fmax, 'int');
% sample period of 100[ns] unit
fwrite(fod, 50000, 'int');
% number of bytes per sample
fwrite(fod, 96 * 4, 'short'); % cmp:96, lspdf0dvsd:108
% a code indicating the sample kind
fwrite(fod, 9, 'short');


%% write augument vector data for fout
for t = 1:fmax;
      fwrite(fod, A(:, t), 'float');
end

%% release memories
fclose(fod);