function extractF0(fin, fout)
% extractF0(fin, fout)
% extract F0 countour using STRAIGHT
%
% INPUT
% fin: original wav file recorded by 16000[Hz]
% fout: f0 file (text file)
%
% LINK
% STRAIGHTV40_006b
%
% HISTORY
% 2010/07/29 functionized
%
% AUTHOR
% Kunikoshi Aki(D2)
% yemaozi88@gmail.com
%

% test
%fin  = 'D:\users\v-akkuni\verification\test\100501.WAV';
%fout = 'D:\users\v-akkuni\verification\test\100501.sf0';


%% load wav file
% x: waveform
% fs: sampling frequency
[x, fs] = wavread(fin);


%% previous method
% f0raw: fundamental frequency
% ap:18
% n3gram: STRAIGHT spectrogram
[f0raw, ap, prmF0] = exstraightsource(x, fs);


%% write to f0 file
fod = fopen(fout, 'w');
fmax = size(f0raw, 2);
for ii = 1:fmax
    fprintf(fod, '%f\n', f0raw(1, ii));
end
fclose(fod);