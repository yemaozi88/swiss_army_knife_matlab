function X = loadBinDir(dirIn, type, NUM)
% X = loadBinDir(dirIn, type, NUM)
% load binary data and add it into the end of matrix X
%
% INPUT
% dirIn: the directory of input binary data
% type: data format
% NUM: the number of factors in one data
%   dgv: 26 uchar(1 int + 22 uchar), scep: 19 float, joint: 36 float
% OUTPUT
% X: m x d data matrix;
%   m: the total number of sample in the directory;
%   d: the dimension of data set; 
%   each row of X is a sample vector
%
% LINK
% loadBin.m
%
% HISTORY
% 2011/02/19 modified so that this program works on Mac as well
% 2010/04/20 functionized based on loadBin.m
%
% AUTHOR
% Aki Kunikoshi (D2)
% yemaozi88@gmail.com
%

%% test
% dirIn = 'J:\!gesture\transitionAmong16of28\dgvs\1';
% type  = 'uchar';
% NUM   = 26;


%% load data
dirlist = dir(dirIn);
dirlength = length(dirlist);

X = [];
ii = 1;
%while ii < dirlength + 1
for ii = 1:dirlength
	% except ".", "..", "DS_Store"
  	if length(dirlist(ii).name) > 3 
        filename = dirlist(ii).name;
        if ismac == 1
            fin = [dirIn '/' filename];
        else
            fin = [dirIn '\' filename];
        end
        X_ = loadBin(fin, type, NUM);
        X = [X, X_];
    end
    %ii = ii + 1;
end
clear dirlist dirlength filename
clear ii fin X_