function addHTKheader2dgv(fin, fout)
% dgv2htk(fin, fout)
% modifies dgv data into htk format by following 3 steps:
% 1. interpolate data by every 1ms, because sampling rate of CyberGlove is not constant
% 2. extract data by every 10ms
% 3. add HTK header to the header
%
% INPUT
% fin: augument vector file (input)
% fout: augument vector file added HTK header (output)
%
% LINK
% joint2htk.m
%
% NOTES
% HTK header in this function is written like below:
% - number of samples in file (4-byte integer)
% - sample period in 100[ns] units (4-byte integer) -> 10 * 10000
% - number of bytes per sample (2-byte integer) -> SNS * 4 (short)
% - a code indicating the sample kind (2-byte integer) -> 9 (user)
%   NUM = 22; % number of signal from dataglove
%   SNS = 18; % number of sensor
%
% HISTORY
% 2011/08/01 changed name from dgv2htk.m to addHTKheader2dgv.m
% 2008/10/23 functionized
%



%% definition
NUM = 22; % number of signal from dataglove
SNS = 18; % number of sensor


%% file open
fid = fopen(fin, 'rb');
fod = fopen(fout, 'wb', 'ieee-be');

% number of frames
B_ = fread(fid, [NUM + 4, inf], 'uchar');
fmax = length(B_(1,:));


%% interpolation
T = sum(B_');
total_time = T(1);
B = zeros(SNS, total_time);

step = 0;
step_buf = 0;
for t = 1:fmax;
    step = step_buf + B_(1, t);
    if t == 1; % step_buf == 0;
        for s = 1:step-1
            B(:, s) = B_(5:22, step);
        end
    elseif t == fmax;
        for s = step_buf:step
            B(:, s) = (B_(5:22, t) - B_(5:22, t-1)) * (s-step_buf)/B_(1, t) + B_(5:22, t-1);
        end
    else
        for s = step_buf:step-1
            B(:, s) = (B_(5:22, t) - B_(5:22, t-1)) * (s-step_buf)/B_(1, t) + B_(5:22, t-1);
        end
    end
    step_buf = step;
end


%% get every 10ms data from B
C = [];
for t = 1:size(B,2);
    if rem(t, 10) == 1;
        C = [C, B(:,t)];
    end
end


%% write HTK header for fout
% number of samples in file
fwrite(fod, size(C, 2), 'int');
% sample period of 100[ns] unit
fwrite(fod, 10 * 10000, 'int');
% number of bytes per sample
fwrite(fod, SNS * 4, 'short');
% a code indicating the sample kind
fwrite(fod, 9, 'short');
 
 
%% write augument vector data for fout
for t = 1:size(C,2);
      fwrite(fod, C(:,t), 'float');
end


%% release memories
fclose(fid);
fclose(fod);