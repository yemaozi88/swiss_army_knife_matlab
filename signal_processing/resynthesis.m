function resynthesis(fileWavIn, fileWavOut, DEG)
% resyn(fileWavIn, fileWavOut, DEG)
% re-synthesize using STRAIGHT.
%
% INPUT
% fileWavIn: original wav file recorded by 16000[Hz]
% fileWavOut: resynthesized wav file 
% DEG: the dimension of cepstrum using analysis
%
% LINK
% STRAIGHTV40_006b
%
% HISTORY
% 2019/05/12 cleaned up.
% 2010/06/29 functionized
%
% AUTHOR
% Aki Kunikoshi
% a.kunikoshi@gmail.com
% 


%% load wav file
% x: waveform
% fs: sampling frequency
[x, fs] = audioread(fileWavIn);


%% previous method
% f0raw: fundamental frequency
% ap:18
% n3gram: STRAIGHT spectrogram
[f0raw, ap, ~] = exstraightsource(x, fs);
[n3sgram, ~] = exstraightspec(x, f0raw, fs);


%% analysis
scep  = sgram2cep(n3sgram, DEG);
sgram = cep2sgram(scep);


%% make ap matrix
ap2 = ap;
for t = 1:length(scep(1, :))
     for s = 1:513
         ap2(s, t) = -25;
     end
end
clear s t


%% synthesis sound
[sy, prmS] = exstraightsynth(f0raw, sgram, ap2, fs);


%% write to wav file
audiowrite(sy/32768, fs, 16, fileWavOut);