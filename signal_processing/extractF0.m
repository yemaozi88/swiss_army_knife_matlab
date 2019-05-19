function extractF0(fileWav, fileF0)
% extractF0(fileWav, fileF0)
% extract F0 countour using STRAIGHT
%
% INPUT
% fileWav: original wav file recorded by 16000[Hz]
% fileF0: f0 file (text file)
%
% LINK
% STRAIGHTV40_006b
%
% HISTORY
% 2019/05/11 audioread is used instead of wavread.
% 2010/07/29 functionized
%
% AUTHOR
% Aki Kunikoshi
% a.kunikoshi@gmail.com
%


%% load wav file
% x: waveform
% fs: sampling frequency
[x, fs] = audioread(fileWav);


%% extract F0
[f0raw, ~, ~] = exstraightsource(x, fs);


%% output to f0 file
ff0 = fopen(fileF0, 'w');
fmax = size(f0raw, 2);
for ii = 1:fmax
    fprintf(ff0, '%f\n', f0raw(1, ii));
end
fclose(ff0);