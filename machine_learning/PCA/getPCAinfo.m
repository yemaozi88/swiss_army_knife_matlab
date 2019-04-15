%
% 2008/10/17
% getPCAinfo.m calculates eigen vectors, eigen values and mean for data set
%
% HISTORY
% 2011/02/19 functionized as getEigenParam.m
% 2010/04/21 divided getPCA from PCA_dgv.m
% 2010/04/20 functionized loadBinDir 
% 
% AUTHOR
% Aki Kunikoshi (D2)
% yemaozi88@gmail.com
%


%% definition
NUM = 22; % number of signal from dataglove
SNS = 18; % number of sensor
dirInV = 'C:\hmts\100430_INTERSPEECH\vowels\dgv';
%dirInC = 'C:\hmts\100430_INTERSPEECH\';
dirOut = 'C:\hmts\100430_INTERSPEECH\vowels\Eval';


%% calculate eigen vectors, eigen values and mean for data set

% vowels
V = [];
for nn = 1:3
    filenameV = [dirInV '\' num2str(nn)];
    V_ = loadBinDir(filenameV, 'uchar', 26);
    V  = [V, V_];
    clear filenameV;
    clear V_;
end

% % 16 gestures which i can make easily
% ges = [4, 9, 13, 14, 15, 16, 21, 22, 25, 27];
% gmax = size(ges, 2);
% 
% ii = 1;
% C = [];
% while  ii < gmax + 1
%     numI = ges(1, ii);     % integer
%     numS = num2str(numI); % string
%     if length(numS) == 1  % if numS is 1 digit then add 0 at the head
%         numS = ['0' numS];
%     end
% 
% for nn = 1:3
%     filenameC = [dirInC 'n' numS '\dgv\n\' num2str(nn)];
%     C_ = loadBinDir(filenameC, 'uchar', 26);
%     C = [C, C_];
%     clear filenameC;
%     clear C_;
% end
%     ii = ii + 1;
% end


%X_ = [C, V];
X_ = V;
X = X_(5:22, :);
X = X';
clear X_;
clear V;
%clear C;

% PCA
[Evec, Eval, u] = PCA(X);

 
%% write down basic values needed for PCA to txt. files
% EVec: eigen vectors
% EVal: eigen values
% u: mean
fname_Evec = [dirOut '\Evec.txt'];
fname_Eval = [dirOut '\Eval.txt'];
fname_u     = [dirOut '\u.txt'];

fout_Evec = fopen(fname_Evec, 'wt');
fout_Eval = fopen(fname_Eval, 'wt');
fout_u = fopen(fname_u, 'wt');

fprintf(fout_Evec, '%f\n', Evec);
fprintf(fout_Eval, '%f\n', Eval);
fprintf(fout_u, '%f\n', u);

fclose(fout_Evec);
fclose(fout_Eval);
fclose(fout_u);