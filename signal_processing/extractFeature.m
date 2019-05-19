function extractFeature(fileWav, fileF0, fileScep, fileResyn, DEG)
% extractFeature(fileWav, fileF0, fileScep, fileResyn, DEG)
% extracts cepstram coefficients and F0 then re-synthesizes using STRAIGHT
%
% INPUT
% fileWav: original speech wav file recorded by 16000[Hz]
% fileF0: output F0 file
% fileScep: output scep file
% fileResyn: output re-synthesized speech
% DEG: the dimension of cepstrum using analysis (0-deg)
%
% LINKS
% STRAIGHT, sgram2cep, cep2sgram
%
% NOTES
% - This program is based on extractFeatureWithoutSil.m
% - wav file should be recorded 16[kHz], 16[bit]
% - scep file made by this program is slightly different from that made by
% extractScep.m, however that is maybe only in silent part
%
% HISTORY
% 2019/05/11 wavread & wavwrite are replaced with audioread & audiowrite. 
% 2011/06/11 added cep2sgram part and changed n3sgram in exstraightsynth
% into sgram
% 2011/06/04 functionized
%
% AUTHOR
% Aki Kunikoshi
% a.kunikoshi@gmail.com
%

% dirMain = 'c:\OneDrive\Research\McRoberts\voice_conversion\mht';
% fileWav = [dirMain '\wav\mht_a_001.wav'];
% fileResyn = [dirMain '\resyn\mht_a_001.wav'];
% DEG = 18;


%% load wav file
% x: waveform
% fs: sampling frequency
[x, fs] = audioread(fileWav);


%% previous method
% f0raw: fundamental frequency
% ap:
% n3gram: STRAIGHT spectrogram (513 x frame)
[f0raw, ap, ~] = exstraightsource(x, fs);
[n3sgram, ~] = exstraightspec(x, f0raw, fs);


%% extract scep
scep  = sgram2cep(n3sgram, DEG);
sgram = cep2sgram(scep);
fmax  = size(sgram, 2);


%% make f0 vector
% f0raw2 = f0raw;
%fmax = length(f0raw(1,:));
% for i = 1:fmax
%     f0raw2(1, i) = F0;
% end
% when no information of the input speech is given,
%f0raw2 = repmat(140, 1, fmax);


%% make ap matrix
ap2 = repmat(-20, 513, fmax);


%% output
fF0   = fopen(fileF0, 'wt');
fScep = fopen(fileScep, 'wb');
for ii = 1:size(scep, 2)
    fprintf(fF0, '%f\n', f0raw(1, ii));
    fwrite(fScep, scep(:, ii), 'float');
end
fclose(fF0);
fclose(fScep);


%% synthesis sound
[sy, ~] = exstraightsynth(f0raw, sgram, ap2, fs);
audiowrite(fileResyn, x, fs, 'BitsPerSample', 16);