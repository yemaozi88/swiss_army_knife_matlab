function [similarity, point] = getSignalSimilarity(signal1, signal2)
% function [similarity, point] = getSignalSimilarity(signal1, signal2)
% adjust the length of the signals with DTW
% and calculate their similarity (Euclidean distance between the DTWed signals).
%
% INPUT
%  signal1, 2: nx1 vector.
% OUTPUT
%  similarity: average Euclidean distance between signal1DTW and signal2DTW.
%  point: the number of points included in signal1DTW and signal2DTW.
%
% LINKS
% dtw.m
%
% HISTORY
% 2018/12/16 similarity is devided by 'point'.
% 2015/12/24 functionized
%
% Aki Kunikoshi
% 428968@gmail.com
%


% %% test data
% signal1 = gaitCycle{2};
% signal2 = gaitCycle{1};


%% DTW
[p, q] = dtw(signal1', signal2');
signal1DTW = signal1(p');
signal2DTW = signal2(q');
clear p q


%% calculate the distortion
point = size(signal1DTW, 1);
similarity = signal1DTW - signal2DTW;
similarity = norm(similarity) * norm(similarity) / point;


%% plot
if 0
    tIndex = 1:size(signalModel, 1);
    tIndex = tIndex';

    figure('visible', 'on');
    hold on
        xlabel('Time', 'FontName', 'Arial', 'FontSize', 20, 'FontWeight', 'bold');
        ylabel('Signal', 'FontName', 'Arial', 'FontSize', 20, 'FontWeight', 'bold');
        
        %plot(tIndex, signalModel, 'k');
        %plot(signal, 'b');
        plot(signal1DTW, 'k');
        plot(signal2DTW, 'b');
        
        set(gca, 'FontName', 'Arial', 'FontSize', 14);
    hold off
end