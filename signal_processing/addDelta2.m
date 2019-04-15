function addDelta2(fin, DEG, type, fout)
% addDelta2(fin, DEG, type, fout)
% add delta to static part
%
% INPUT
% fin: static feature file
% DEG: the dimension of scep (1-DEG), it would be 18 for dgv 
% type: data type, 'scep0'(without energy), 'scep1'(with energy) or 'dgv'
% fout: augmented vector 
%   dgv: 5:22 and its delta
%   scep0: 2:DEG+1 and its delta
%   scep1: 1:DEG and its delta
%
% LINK
% loadBin.m, getDelta.m
%
% HISTORY
% 2011/08/19 the first and the last frames are cut
% 2011/08/19 added scep0/scep1 parts
% 2011/08/16 added dgv part
% 2011/08/10 functionized
%
% AUTHOR
% Kunikoshi Aki(D3)
% yemaozi88@gmail.com
%

%% test
% clear all, fclose all, clc;
% % scep
% %fin = 'J:\VoiceConversion\STRAIGHT-based\fws\scep18_test\j01.scep';
% %DEG   = 18;
% %type = 'scep';
% %fout  = 'J:\H2SwithDelta\j01.feature';
% % dgv
% fin = 'J:\!gesture\transitionAmong16of28\dgv\1\01-02.dgv';
% DEG   = 18;
% type = 'dgv';
% fout  = 'J:\H2SwithDelta\01-02.feature';


%% load data
if strcmp(type, 'scep0') == 1 || strcmp(type, 'scep1') == 1
    static = loadBin(fin, 'float', DEG+1); % (DEG+1) x fmax
elseif strcmp(type, 'dgv') == 1
    static = loadBin(fin, 'uchar', 26); % (DEG+1) x fmax
else
    error('variable type should be scep0/scep1 or dgv!')
end


%% get delta
delta = getDelta(static);

if strcmp(type, 'scep0') == 1
    static = static(2:DEG+1, :);
    delta  = delta(2:DEG+1, :);
elseif strcmp(type, 'scep1') == 1
    static = static(1:DEG, :);
    delta  = delta(1:DEG, :);
elseif strcmp(type, 'dgv') == 1
    static = static(5:22, :);
    delta  = delta(5:22, :);
end


%% write out data
fod = fopen(fout, 'wb');
fmax = size(static, 2);
%for t = 1:fmax;
for t = 2:fmax-1; % the first and the last frames are wrong
    %fwrite(fod, static(2:DEG+1, t), 'float');
    %fwrite(fod, delta(2:DEG+1, t), 'float');
    fwrite(fod, static(:, t), 'float');
    fwrite(fod, delta(:, t), 'float');    
end
clear static delta
fclose(fod);
clear fout fod fmax t