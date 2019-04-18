function scep2wav(scep, fout, name)
% scep2wav(scep, fout, name)
% synthesizes speech from scep using STRIGHT
%
% INPUT
% scep: STRAIGHT cepstrum (float, (DEG+1) x frame)
% fout: the name of synthesized wav file
% name: 'suzuki' or 'kunikoshi'
%
% LINKS
% STRAIGHT, cep2sgram.m
%
% NOTES
% f0 is 140[Hz] (suzuki) or 205[Hz] (kunikoshi) constant
% ap is -20 constant
% this function is based on resyn.m
%
% HISTORY
% 2010/01/14 functionized
%
% AUTHOR
% Aki Kunikoshi (D2)
% yemaozi88@gmail.com
%


%% definition
fs = 16000;

% test
%fin = 'C:\research\ProbabilisticIntegrationModel\S2H-H2S_ERRV20_ERRC20_thres5_mix32\28-07-04-13-14\synScep\aa.scep';
%fout = 'C:\research\ProbabilisticIntegrationModel\S2H-H2S_ERRV20_ERRC20_thres5_mix32\28-07-04-13-14\synScep\aa.wav';
%name = 'suzuki';
%%DEG = 18;



%% constant f0
if strcmp(name, 'suzuki') == 1
    F0 = 140;
elseif strcmp(name, 'kunikoshi') == 1
    F0 = 205;
else
    error('Please chek the name whom you would like to synthesize of!');
end


%% analysis
sgram = cep2sgram(scep);
fmax = size(sgram, 2);
clear scep


%% make f0 vector
f0raw2 = repmat(F0, 1, fmax);
clear F0


%% make ap matrix
ap2 = repmat(-20, 513, fmax);


%% synthesis sound
[sy, prmS] = exstraightsynth(f0raw2, sgram, ap2, fs);
clear prmS f0raw2 sgram ap2


%% write to wav file
wavwrite(sy/32768, fs, 16, fout);
clear sy