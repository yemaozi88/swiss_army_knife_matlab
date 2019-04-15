%
% 2010-04-26
% draws bar chart with standard deviation
%


%% bar graph
% data
%X = [1, 2, 3];
%Y = [0.177825, 0.167457, 0.191009];
X = 1:10;
% 5840 without PCA?
% Y = [0.262735, 0.234617; ... % a
%      0.298025, 0.327225; ... % i
%      0.232631, 0.236135; ... % u
%      0.267890, 0.267673; ... % e
%      0.236338, 0.243043; ... % o
%      0.303420, 0.259854; ... % na
%      0.317464, 0.265189; ... % ni
%      0.250748, 0.203341; ... % nu
%      0.274953, 0.243975; ... % ne
%      0.266782, 0.229863];     % no
% 1113 with PCA
Y = [0.256648, 0.217163; ... % a
    0.300739, 0.298962; ... % i
    0.251974, 0.215376; ... % u
    0.256603, 0.264436; ... % e
    0.242503, 0.247170; ... % o
    0.299291, 0.202585; ... % na
    0.292894, 0.223672; ... % ni
    0.253165, 0.176240; ... % nu
    0.266568, 0.191476; ... % ne
    0.252948, 0.208392];    % no

%tcksX={'Average', 'No.4', 'No.27'};
tcksX={'a', 'i', 'u', 'e', 'o', ...
    'na', 'ni', 'nu', 'ne', 'no'};
set(gca, 'XTickLabel',tcksX ,'XTick',1:length(tcksX));
 
hold on
 
% bar chart
h = bar(X, Y, 1.0);

%[numgroups, numbars] = size(Y);

% get X value for every bar
%xdata = get(h, 'XData'); % 1 x numgroups, cell
% get the center
%centerX = cellfun(@(x)(x(1,:)+x(3,:))/2,xdata,'UniformOutput', false);

% error bar
%X = [0.85, 1.85];
Xerr = X - 0.15;
Yerr = Y(:, 1);
%e = [0.007101, 0.007];
% 5840 without PCA?
%e = [0.023935, 0.023913, 0.017653, 0.023886, 0.015459, ...
%    0.018118, 0.019424, 0.014643, 0.015492, 0.013134];
% 1113 with PCA
e = [0.023378, 0.024031, 0.025835, 0.018845, 0.016618, ...
    0.021871, 0.023823, 0.016989, 0.017870, 0.016127]; 
errorbar(Xerr, Yerr, e, 'k', 'linestyle', 'none', 'LineWidth', 2);
 
hold off


%% The number of mixtures
%unit = [1, 2, 4, 8, 16, 32, 64];

% RMSE
% LY2MS = [43.98183, 39.00005, 38.21859, 38.52664, 38.53752, 37.82861, 39.29568];
% LY2MS_ = repmat(41.556605, 1, 7);
% bdl2clb = [15.30885, 13.57697, 12.76492, 12.76291, 12.4295, 12.3418, 11.54996];
% bdl2clb_ = repmat(14.249045, 1, 7);
% %hold on
% plot(unit, LY2MS, 'rs-', unit, bdl2clb, 'bs--', unit, LY2MS_, 'r:', unit, bdl2clb_, 'b:');
% h = legend('Chinese','English');
% %hold off

% Correlation
% LY2MS = [66.4607, 74.5404, 75.885, 76.1866, 76.7104, 77.2887, 76.072];
% LY2MS_ = repmat(75.050, 1, 7);
% bdl2clb = [66.9997, 75.4877, 74.8837, 76.3058, 74.8547, 76.7814, 78.0937];
% bdl2clb_ = repmat(75.8432, 1, 7);
% %hold on
% %plot(unit, LY2MS, 'rs-', unit, bdl2clb, 'bs--', unit, LY2MS_, 'r:', unit, bdl2clb_, 'b:');
% plot(unit, LY2MS, 'ks-', unit, LY2MS_, 'k:');
% %h = legend('Chinese','English');
% %hold off
 
 
%% Threshold value
%unit = 0.75:0.01:0.85;
% RMSE
% LY2MS = [37.99486, 37.21682, 37.63306, 37.77723, 38.43629, 38.69714, 39.25088, 39.90986, 39.89295, 40.48476, 40.1443];
% LY2MS_ = repmat(41.556605, 1, 11);
% bdl2clb = [12.6357, 12.66232, 12.26607, 11.99806, 12.23911, 11.71822, 11.60614, 11.59018, 11.55385, 11.49354, 12.06182];
% bdl2clb_ = repmat(14.249045, 1, 11);
% %hold on
% %plot(unit, LY2MS, 'rs-', unit, bdl2clb, 'bs--', unit, LY2MS_, 'r:', unit, bdl2clb_, 'b:');
% plot(unit, LY2MS, 'ks-', unit, LY2MS_, 'k:');
% %h = legend('Chinese','English');
% %hold off

% Correlation
% LY2MS = [77.0310, 77.8826, 77.0536, 76.9693, 76.2752, 76.0619, 75.3545, 74.5102, 74.3966, 74.1074, 74.2157];
% LY2MS_ = repmat(75.050, 1, 11);
% bdl2clb = [76.7011, 76.2305, 77.2247, 77.6746, 76.1168, 78.0806, 77.9806, 77.9725, 77.9604, 78.221, 75.5515];
% bdl2clb_ = repmat(75.8432, 1, 11);
% %hold on
% %plot(unit, LY2MS, 'rs-', unit, bdl2clb, 'bs--', unit, LY2MS_, 'r:', unit, bdl2clb_, 'b:');
% plot(unit, LY2MS, 'ks-', unit, LY2MS_, 'k:');
% %h = legend('Chinese','English');
% %hold off
