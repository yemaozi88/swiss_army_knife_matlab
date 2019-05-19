%
% 2010-07-31
% synthesis speech from trained scep and f0 file
%
% LINK
% STRAIGHTV40_006b
%
% AUTHOR
% Kunikoshi Aki, The University of Tokyo, Japan
% ( Microsoft Research Asia intern since May until August, 2010 )
%   Email: kunikoshi@gavo.t.u-tokyo.ac.jp
%

convDir = 'D:\users\v-akkuni\verification\HF2ZT\conv';
DEG = 24;

for fileNo = [100701:100720]
    disp(fileNo)
for MixNum = [1, 2, 4, 8, 16, 32]
    disp(MixNum)

    fileNo = num2str(fileNo);
    MixNum = num2str(MixNum);
    
    finScep = [convDir '\' fileNo '_mix' MixNum '.scep'];
    finF0   = [convDir '\' fileNo '_mix' MixNum '.lf0'];
    fout    = [convDir '\' fileNo '_mix' MixNum '.wav'];

    
    %% for re-syn test

    %% load wav file
    % x: waveform
    % fs: sampling frequency
    %[x, fs] = wavread(finWav);

    %% previous method
    % f0raw: fundamental frequency
    % n3gram: STRAIGHT spectrogram
    %[f0raw, ap, prmF0] = exstraightsource(x, fs);
    %[n3sgram, prmP] = exstraightspec(x, f0raw, fs);

    %scep = sgram2cep(n3sgram, DEG);


    %% load scep and f0 files

    convScep_ = loadBin(finScep, 'float', DEG+1);
    convF0_ = load(finF0);

    fmax_ = size(convScep_, 2);
    fmax = fmax_ * 5;

    convScep = zeros(DEG+1, fmax);
    convF0   = zeros(fmax, 1);


    % interpolate signals so that frame rate is 1[ms]
    %  sampling rate: analysis.exe - 5 [ms], STRAIGHT - 1 [ms]
    convScep_ = [convScep_, convScep_(:, fmax_)];
    convF0_   = [convF0_; convF0_(fmax_)];

    for ii = 1:fmax
        idx = floor(ii/5);
        if idx == 0
            idx = 1;
        end

    %     convScep(:, ii) = convScep_(:, idx);
    %     convF0(ii, 1)   = convF0_(idx, 1);

        idx_ = rem(ii, 5);

        if idx_ == 0;
            convScep(:, ii) = convScep_(:, idx) + (convScep_(:, idx+1) - convScep_(:, idx))* 4/5;        
            convF0(ii, 1) = convF0_(idx, 1) + (convF0_(idx+1, 1) - convF0_(idx, 1))* 4/5;
        else
            convScep(:, ii) = convScep_(:, idx) + (convScep_(:, idx+1) - convScep_(:, idx))* (idx_ - 1)/5;        
            convF0(ii, 1) = convF0_(idx, 1) + (convF0_(idx+1, 1) - convF0_(idx, 1))* (idx_ - 1)/5;
        end
    end
    clear ii idx idx_
    clear convScep_ convF0_ fmax_


    %% median filter
    % for d = 1:deg+1
    %     convScep(d, :) = medfilt1(convScep(d, :));
    % end
    % convF0 = medfilt1(convF0);


    %% put gain at the first
    convScep = [convScep(DEG+1, :); convScep(1:DEG, :)];


    %% convert cepstrum into spectrogram
    convSgram = cep2sgram(convScep);



    %% values for STRAIGHT synthesis
    % sampling frequency
    fs = 16000;
    % make ap matrix
    ap2 = zeros(513, fmax);
    for t = 1:fmax
         for s = 1:513
             ap2(s, t) = -30;
         end
    end


    %% synthesis sound
    [sy, prmS] = exstraightsynth(convF0, convSgram, ap2, fs);


    %% write to wav file
    wavwrite(sy/32768, fs, 16, fout);
end
end