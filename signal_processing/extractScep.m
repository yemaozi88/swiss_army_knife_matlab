function extractScep(fileWav, fileScep, deg)
% extractScep(fileWav, fileScep, deg)
% extract cepstram coefficients using STRAIGHT
%
% INPUT
% fileWav: original speech wav file recorded by 16000[Hz]
% fileScep: output scep file
% deg: the dimension of cepstrum using analysis
%
% LINKS
% STRAIGHT.m, sgram2cep.m
%
% HISTORY
% 2019/05/11 audioread is used instead of wavread.
% 2009/10/02 functionized
% 2009/09/23 change configuration of input & output filenames
% 2008/03/01
%
% AUTHOR
% Aki Kunikoshi
% a.kunikoshi@gmail.com
%


%% load wav file
% x: waveform
% fs: sampling frequency
[x, fs] = audioread(fileWav);


%% previous method
% f0raw: fundamental frequency
% ap: 18
% n3gram: STRAIGHT spectrogram (513 x frame)
[f0raw, ~, ~] = exstraightsource(x, fs);
[n3sgram, ~] = exstraightspec(x, f0raw, fs);


%% extract scep
scep = sgram2cep(n3sgram, deg);


%% output to scep file
fscep = fopen(fileScep, 'wb');
frame = size(scep, 2);
for ii = 1:frame
    fwrite(fscep, scep(:, ii), 'float');
end
fclose(fscep);