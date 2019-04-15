%
% 2011/08/10
% calculates cepstral distortion
%
% AUTHOR
% Aki Kunikoshi (D3)
% yemaozi88@gmail.com
%

clear all, fclose all, clc;


%% definition
srcDir  = 'J:\VoiceConversion\STRAIGHT-based\fws2mht_withDelta_reduced1of5\converted';
tgtDir  = 'J:\VoiceConversion\STRAIGHT-based\mht\scep18_test';
logfile = 'J:\VoiceConversion\STRAIGHT-based\fws2mht_withDelta_reduced1of5\converted\distortionScep18.txt';


%% log file
flog = fopen(logfile, 'wt');


%% directory processing
for n = 9:10
    if n < 10
        nStr = ['0' num2str(n)];
    else
        nStr = num2str(n);
    end
    nStr = ['j' nStr];
    %disp(nStr)

    % load source/target scep files
    if ismac == 1
        fSrcScep = [srcDir '/' nStr '.scep'];
        fTgtScep = [tgtDir '/' nStr '.scep'];
    else
        fSrcScep = [srcDir '\' nStr '.scep'];
        fTgtScep = [tgtDir '\' nStr '.scep'];
    end
%     srcScep = loadBin(fSrcScep, 'float', 19);
%     tgtScep = loadBin(fTgtScep, 'float', 19);    
%     srcScep = srcScep(2:19, :);
%     tgtScep = tgtScep(2:19, :);
%    clear fSrcScep fTgtScep
   
    % calculate distortion
    distortion = distortionScep18(fSrcScep, fTgtScep, 1); % with DTW
    disp([nStr ': ' num2str(distortion)]);
    fprintf(flog, '%s: %f\n', nStr, distortion);
end % n
clear distortion fSrcScep fTgtScep Str
clear srcDir tgtDir
fclose(flog);
clear flog