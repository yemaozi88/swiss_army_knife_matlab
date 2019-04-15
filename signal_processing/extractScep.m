function extractScep(fin, fout, DEG)
% extractScep(fin, fout, deg)
% extract cepstram coefficients using STRAIGHT
%
% INPUT
% fin: original speech wav file recorded by 16000[Hz]
% fout: output scep file
% deg: the dimension of cepstrum using analysis
%
% LINKS
% STRAIGHT.m, sgram2cep.m
%
% HISTORY
% 2009/10/02 functionized
% 2009/09/23 change configuration of input & output filenames
% 2008/03/01
%
% AUTHOR
% Aki Kunikoshi (D2)
% yemaozi88@gmail.com
%


%% load wav file
% x: waveform
% fs: sampling frequency
[x, fs] = wavread(fin);


%% previous method
% f0raw: fundamental frequency
% ap:18
% n3gram: STRAIGHT spectrogram (513 x frame)
[f0raw, ap, prmF0] = exstraightsource(x, fs);
[n3sgram, prmP] = exstraightspec(x, f0raw, fs);


%% extract scep
scep = sgram2cep(n3sgram, DEG);


%% write to scep file
fod = fopen(fout, 'wb');
%frame = length(scep(1, :));
frame = size(scep, 2);
%j = 1;
%while j < frame + 1
for ii = 1:frame
    fwrite(fod, scep(:, ii), 'float');
    %j = j + 1;
end
fclose(fod);