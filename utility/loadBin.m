function X = loadBin(fin, type, NUM)
% X = loadBin(fin, type, NUM)
% load binary data and set every data to every row of matrix X
%
% INPUT
% fin: input data for data matrix
% type: data format
% NUM: the number of factors per sample
%   dgv: 26 uchar(1 int + 22 uchar), scep: 19 float, joint: 36 float
% OUTPUT
% X: m x d data matrix;
%   m: the number of sample;
%   d: the dimension of data set; 
%   each row of X is a sample vector
%
% HISTORY
% 2009/10/24 generalized
% 2008/10/18 functionized
%
% AUTHOR
% Aki Kunikoshi (D2)
% yemaozi88@gmail.com
%


%% load dgv file
fid = fopen(fin, 'rb');
X = fread(fid, [NUM, inf], type);
fclose(fid);
clear fid