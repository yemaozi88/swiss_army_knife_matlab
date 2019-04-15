%
% 2016/02/26
% analyse signal data
%
% Aki Kunikoshi
% 428968@gmail.com
%

clear all, fclose all, clc;


%% definition
% 1-3: acc{VT, ML, AP}
% 4-6: gyr{VT, ML, AP}
ChannelNum = 6;
groupNumMax = 2;
dataNum_train = 100;
dataNum_test  = 15;
dirOut = 'G:\McRoberts\OneDrive\Projects\Gait\stepDetectionComparison\validation\version1\analysis';

% to set makeTrainData 0, 
% at least the script should be performed once with makeTrainData 0
makeTrainData = 1;
doPCA = 0;
% analysisDataKind; 0:original, 1:PCA
analysisDataKind   = 0;
analysisDataDegree = 1;
doROC   = 0;
testROC = 1;


% % ========== iteration ==========
% %flog = fopen([dirMain '\F1.csv'], 'wt');
% %fprintf(flog, 'PCA4,PCA12,gmmNum0,gmmNum1,precision,recall,F1\n');
% %for iterNum = 1:100
% %    disp(['===== ' num2str(iterNum) ' =====']);
% % ========== iteration ==========
%

%% 1-2. train/test data
if makeTrainData
    %% load parameters
    tic
    disp('1. loading parameters...');
% ============ EDIT FROM HERE ============
    % store parameters in cell 'data'
    %   data{1}: n x d matrix - noise
    %   data{2}: m x d matrix - clean
    getNoiseInformation;
    clear CleanCell NoiseCell
    noiseFeatures = [];
    cleanFeatures = [];
    for fileNum = 1:fileNumMax
        noiseFeatures_ = NoiseFeatures{fileNum, ChannelNum};
        noiseFeatures  = [noiseFeatures; noiseFeatures_];
        cleanFeatures_ = CleanFeatures{fileNum, ChannelNum};
        cleanFeatures  = [cleanFeatures; cleanFeatures_];
    end
    clear fileNum fileNumMax
    clear noiseFeatures_ cleanFeatures_
    clear CleanFeatures NoiseFeatures
    
    data{1} = noiseFeatures;
    data{2} = cleanFeatures;
    clear cleanFeatures noiseFeatures
% ============ EDIT TILL HERE ============
    toc
    fprintf('\n');
    
    tic
    disp('2. making train/test data...');
    Xtrain = cell(1, groupNumMax);
    Xtest  = cell(1, groupNumMax);
    for groupNum = 1:groupNumMax
        % test data and training data are not be overlapped
        [Xtrain{groupNum}, idx] = extractRandomData(data{groupNum}, dataNum_train);
        data{groupNum}(idx, :) = [];
        Xtest{groupNum} = extractRandomData(data{groupNum}, dataNum_test);
    end % groupNum
    clear idx groupNum
    
    save([dirOut '\data'], 'data');
    save([dirOut '\Xtrain'], 'Xtrain');
    save([dirOut '\Xtest'], 'Xtest');
    toc
    fprintf('\n');
else
    tic
    disp('1-2. loading train/test data...');
    load([dirOut '\data']);
    load([dirOut '\Xtrain']);
    load([dirOut '\Xtest']);
    toc
    fprintf('\n');
end 
clear makeTrainData


%% 3. data overview
if 1
    tic
    disp('3. checking the data...');
    XtrainAll = [];
    XtestAll  = [];
    Xall = cell(groupNumMax, 1);
    for groupNum = 1:groupNumMax
        XtrainAll = [XtrainAll; Xtrain{groupNum}];
        XtestAll  = [XtestAll; Xtest{groupNum}];
        Xall{groupNum, 1} = [Xtrain{groupNum}; Xtest{groupNum}];
    end
    clear groupNum

    % project features onto the 2 dimensional plane
    if 0
        figure('visible', 'off');
        hold on
            xlabel('1st Feature', 'FontName', 'Arial', 'FontSize', 20, 'FontWeight', 'bold');
            ylabel('2nd Feature', 'FontName', 'Arial', 'FontSize', 20, 'FontWeight', 'bold');

            fh = plot(Xall{1}(:, 1), Xall{1}(:, 2), 'r.', 'MarkerSize', 6);
            plot(Xall{2}(:, 1), Xall{2}(:, 2), 'k.', 'MarkerSize', 6);
    % ============ EDIT FROM HERE ============
            legend([{'noise'}; {'clean'}]);
    % ============ EDIT TILL HERE ============

            set(gca, 'FontName', 'Arial', 'FontSize', 14);

            saveas(fh, [dirOut '\overview.fig']);
            saveas(fh, [dirOut '\overview.png']);
        hold off
        clear fh
    end % project
    toc
    fprintf('\n');
end % if


%% 4. PCA
if doPCA
    tic
    disp('4. PCA...');

    [Evec, Eval, u] = PCA(XtrainAll);

    % energy occupancy
    EvalNorm = Eval ./ sum(Eval) * 100;
    idx = 1:length(EvalNorm);
    EvalCumsum = cumsum(EvalNorm);
    EvalCumsumIdx = [idx', EvalCumsum];
    disp('- energy occupancy');
    disp(EvalCumsumIdx);

    % plot - EvalCumsum
    if 0 
        figure('visible', 'on');
        hold on
            xlabel('Number of PC', 'FontName', 'Arial', 'FontSize', 20, 'FontWeight', 'bold');
            ylabel('Energy occupancy', 'FontName', 'Arial', 'FontSize', 20, 'FontWeight', 'bold');

            fh = plot(EvalCumsum, 'ko-', 'MarkerSize', 3, 'LineWidth', 2);
%             xlim([0 53])
%             ylim([0 100])
            set(gca, 'FontName', 'Arial', 'FontSize', 14);

            saveas(fh, [dirOut '\PCA_VariableNum.fig']);
            saveas(fh, [dirOut '\PCA_VariableNum.png']);
        hold off
        clear fh
    end 

    % project features onto the 2 dimensional PCA plane
    if 1
        XPCAall = PCA_Trans(XtrainAll, Evec, u, 2);
        for groupNum = 1:groupNumMax
            XtrainPCA{groupNum} = PCA_Trans(Xtrain{groupNum}, Evec, u, 2);
            XtestPCA{groupNum}  = PCA_Trans(Xtest{groupNum}, Evec, u, 2);
        end % groupNum

        figure('visible', 'off');
        hold on
            xlabel('1st Principal Component', 'FontName', 'Arial', 'FontSize', 20, 'FontWeight', 'bold');
            ylabel('2nd Principal Component', 'FontName', 'Arial', 'FontSize', 20, 'FontWeight', 'bold');

            fh = plot(XtrainPCA{1}(:, 1), XtrainPCA{1}(:, 2), 'r.', 'MarkerSize', 6);
            plot(XtrainPCA{2}(:, 1), XtrainPCA{2}(:, 2), 'k.', 'MarkerSize', 6);
% ============ EDIT FROM HERE ============
            legend([{'noise'}; {'clean'}]);
% ============ EDIT TILL HERE ============

            set(gca, 'FontName', 'Arial', 'FontSize', 14);

            saveas(fh, [dirOut '\PCA.fig']);
            saveas(fh, [dirOut '\PCA.png']);
        hold off
        clear fh
    end % project
    toc
    fprintf('\n');
end % end
clear doPCA


%% 5. data for analysis
if 1
    tic
    disp('5. making data for analysis...');
    % training data
    if analysisDataKind
        [Evec, Eval, u] = PCA(XtrainAll);
        for groupNum = 1:groupNumMax
            XtrainPCA{groupNum} ...
                = PCA_Trans(Xtrain{groupNum}, Evec, u, analysisDataDegree);
            XtestPCA{groupNum} ...
                = PCA_Trans(Xtest{groupNum}, Evec, u, analysisDataDegree);
        end % groupNum
        clear groupNum
        
        X_train = XtrainPCA;
        X_test  = XtestPCA;
    else % analysisDataKind
        for groupNum = 1:groupNumMax
            X_train{groupNum} = Xtrain{groupNum}(:, 1:analysisDataDegree);
            X_test{groupNum}  = Xtest{groupNum}(:, 1:analysisDataDegree);
        end % groupNum
    end % analysisDataKind
    X_train_all = [X_train{1}; X_train{2}];
    X_test_all  = [X_test{1}; X_test{2}];

    % answer data
    y_train{1}  = zeros(size(X_train{1}, 1), 1);
    y_train{2}  = ones(size(X_train{2}, 1), 1);
    y_test{1}   = zeros(size(X_test{1}, 1), 1);
    y_test{2}   = ones(size(X_test{2}, 1), 1);
    y_train_all = [y_train{1}; y_train{2}];
    y_test_all  = [y_test{1}; y_test{2}];
    toc
    fprintf('\n');
end


%% [analysis] ROC curve
if doROC
    tic
    disp('[analysis] ROC curve');
    if analysisDataDegree ~= 1
        error('ROC can be calculated only when the degree is 1.');
    else
        maxXtrain = ceil(max(X_train_all));
        minXtrain = ceil(min(X_train_all));
        thresIndex = minXtrain:maxXtrain;
        thresIndexLength = length(thresIndex);
        
        sensitivity  = zeros(thresIndexLength, 1);
        specificity_ = zeros(thresIndexLength, 1);
        F1           = zeros(thresIndexLength, 1);
        for thresNum = 1:thresIndexLength;
            threshold = thresIndex(thresNum);
% ============ EDIT FROM HERE ============
            % original data (it is opposite for PCAed data)
            % noise: a feature becomes large
            % clean: a feature becomes small
            [~, idx1] = find(X_train{1}<=threshold); % positive
            [~, idx2] = find(X_train{2}>threshold); % negative
% ============ EDIT TILL HERE ============

            TP = sum(idx1);
            FN = length(X_train{1}) - TP;
            TN = sum(idx2);
            FP = length(X_train{2}) - TN;

            clear idx1 idx2
            sensitivity(thresNum, 1)  = TP/(TP+FN);
            specificity_(thresNum, 1) = 1 - TN/(TN+FP);
            F1(thresNum, 1)      = 2*TP/(2*TP + FP + FN);
        end
        clear TP FP TN FN idx
        clear thresNum threshold
        clear maxXtrain minXtrain thresIndexLength

        % ROC curve
        if 0
            index = 0:0.01:1;
            figure('visible', 'off');
            hold on
                xlabel('1 - specificity', 'FontName', 'Arial', 'FontSize', 20, 'FontWeight', 'bold');
                ylabel('sensitivity', 'FontName', 'Arial', 'FontSize', 20, 'FontWeight', 'bold');

                fh = plot(specificity_, sensitivity, 'ko-', 'LineWidth', 2, 'MarkerSize', 6);
                plot(index, index, 'k-', 'LineWidth', 1);
                set(gca, 'FontName', 'Arial', 'FontSize', 14);

                saveas(fh, [dirOut '\ROC.fig']);
                saveas(fh, [dirOut '\ROC.png']);
            hold off
            clear fh index
        end % ROC curve
        
        % analyse the result
        % ============ EDIT FROM HERE ============
%         [idx, ~] = find(F1 > 0.87);
%         minThres = thresIndex(idx(1));
%         maxThres = thresIndex(idx(end));
%         fprintf('%d - %d (F1: %.2f - %.2f [%%])\n', ...
%             minThres, maxThres, F1(minThres)*100, F1(maxThres)*100);
%         clear minThres maxThres idx thresIndex
        % ============ EDIT FROM HERE ============
     end % analysisDataDegree
     toc
     fprintf('\n');
end % doROC
clear doROC


%% [evaluate] ROC curve
if testROC
    tic
    fprintf('[evaluate] ROC curve\n');
    % ============ EDIT FROM HERE ============
    threshold = 17;

    % original data (it is opposite for PCAed data)
    % noise: a feature becomes large
    % clean: a feature becomes small
    [~, idx1] = find(X_test{1}<=threshold); % positive
    [~, idx2] = find(X_test{2}>threshold); % negative
    % ============ EDIT TILL HERE ============

    TP = sum(idx1);
    FN = length(X_test{1}) - TP;
    TN = sum(idx2);
    FP = length(X_test{2}) - TN;
    
    sensitivity = TP/(TP+FN) * 100;
    specificity = 1 - TN/(TN+FP) * 100;
    F1          = 2*TP/(2*TP + FP + FN) * 100;
    recognitionRate = (TP+TN) / length(X_test_all) * 100;
    
    fprintf('<< performance of threshold >>\n');
    fprintf('F1 score: %.2f [%%]\n', F1);
    fprintf('recognition rate: %.2f [%%]\n', recognitionRate);
    toc
    fprintf('\n');
end % testROC
clear testROC


%% [analysis] Logistic Regression
% if doLogisticRegression
% % tic
%     disp('[analysis] Logistic Regression');
% 
% %     flog = fopen([dirMain '\F1.csv'], 'wt');
% %     fprintf(flog, 'degree,alpha_,precision,recall,F1\n');
% %     for degree = 1:10
%     degree = 1;
% %         for num_alpha_ = 1:10
% %             num_alpha = 10^(-num_alpha_);
%             % Note that mapFeature also adds a column of ones for us
%             % so the intercept term is handled
%             X_train_map = mapFeature(X_train_all(:, 1), X_train_all(:, 2), degree);
%             X_test_map  = mapFeature(X_test_all(:, 1), X_test_all(:, 2), degree);
% 
% % 
% %             %% gradient descent
% %             % Initialize fitting parameters
% %             theta = zeros(size(X_train_map, 2), 1);
% %             % regularization parameter (should be modified)
% %             lambda = 1;
% %             num_iters = 10000;
% %             [theta, J_history] = gradientDescentMulti_LogisticRegression(X_train_map, y_train_all, theta, lambda, num_alpha, num_iters);
% %             % figure;
% %             % plot(J_history);
% % 
% %             %plotDecisionBoundary(theta, X_train_all, y_train_all);
% % 
% %             h = sigmoid(X_test_map * theta);
% %             [idxN, ~] = find(h <= 0.5);
% %             answerN = y_test_all(idxN, :);
% %             FN = sum(answerN);
% %             TN = length(answerN) - FN;
% %             [idxP, ~] = find(h > 0.5);
% %             answerP = y_test_all(idxP, :);
% %             TP = sum(answerP);
% %             FP = length(answerP) - TP;
% % 
% %             P = TP / (TP + FP) * 100;
% %             R = TP / (TP + FN) * 100;
% %             F1 = 2 * (P*R/ (P + R));
% %             fprintf('deg %d - alpha %d: %.2f[%%]\n', degree, num_alpha_, F1);
% %             fprintf(flog, '%d,%d,%f,%f,%f\n', degree, num_alpha_, P, R, F1);
% %         end % num_alpha
% %     end % degree
% %     fclose(flog);
% end % doLogisticRegression
% clear doLogisticRegression


% %% Gaussian Mixture Model
% if doGMM
% %     %flog = fopen([dirMain '\F1.csv'], 'wt');
% %     %fprintf(flog, 'gmmNum0,gmmNum1,precision,recall,F1\n');
% % 
% %     F1array = [];
% %     gmmNumArray = [1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024];
% %     %for gmmNum0_ = 1:length(gmmNumArray)
% %     for gmmNum0_ = 3:7
% %         gmmNum0 = gmmNumArray(gmmNum0_);
% %         %for gmmNum1_ = 1:length(gmmNumArray)
% %         for gmmNum1_ = 3:7
% %             gmmNum1 = gmmNumArray(gmmNum1_);
% %     
% %             % not in the transportation
% %             obj0 = trainGMM(X_train{1}, gmmNum0, 1); % 0 - full, 1 - diagonal
% %             %save([dirMain '\GMM\obj0_gmm_mix' num2str(gmmNum0)], 'obj0');
% %             %disp(' -- GMM of not-in-transportation parts has been trained.')
% % 
% %             % in the transportation
% %             obj1 = trainGMM(X_train{2}, gmmNum1, 1); % 0 - full, 1 - diagonal
% %             %save([dirMain '\GMM\obj1_gmm_mix' num2str(gmmNum1)], 'obj1');
% %             %disp(' -- GMM of in-transportation parts has been trained.')
% % 
% %             %dataNum_test
% %             TP = 0;
% %             TN = 0;
% %             FP = 0;
% %             FN = 0;
% %             for dNum = 1:dataNum_test
% %                 % test data - not in the transportation
% %                 input = X_test{1}(dNum, :);
% %                 L0 = pdf(obj0, input);
% %                 L1 = pdf(obj1, input);
% %                 if L0 >= L1
% %                     TN = TN + 1;
% %                 else
% %                     FP = FP + 1;
% %                 end
% %                 clear input
% % 
% %                 % test data - in the transportation
% %                 input = X_test{2}(dNum, :);
% %                 L0 = pdf(obj0, input);
% %                 L1 = pdf(obj1, input);
% %                 if L0 >= L1
% %                     FN = FN + 1;
% %                 else
% %                     TP = TP + 1;
% %                 end
% %                 clear input
% %             end % dNum
% %             P = TP / (TP + FP) * 100;
% %             R = TP / (TP + FN) * 100;
% %             F1 = 2 * (P*R/ (P + R));
% % 
% %             %fprintf('gmmNum0 %d - gmmNum1 %d: %.2f[%%]\n', gmmNum0, gmmNum1, F1);
% %             %fprintf(flog, '%d,%d,%f,%f,%f\n', gmmNum0, gmmNum1, P, R, F1);
% %             F1array_ = [gmmNum0_, gmmNum1_, P, R, F1];
% %             F1array  = [F1array; F1array_];
% %             clear F1array_
% %         end % gmmNum1_
% %     end % gmmNum0_
% %     %fclose(flog);
% end
% % 
% % % ========== iteration ==========
% % % % max F1 value
% % % [~, idxMax] = max(F1array(:, 5));
% % % F1array(idxMax, :);
% % % fprintf('PCA4: %.3f, PCA12: %.3f\n', EvalCumsum(4, :), EvalCumsum(12, :));
% % % fprintf('mix0: %d, mix1: %d, P: %.3f, R: %.3f, F1: %.3f\n\n', gmmNum0, gmmNum1, P, R, F1);
% % % fprintf(flog, '%.3f,%.3f,%d,%d,%.3f,%.3f,%.3f\n', EvalCumsum(4, :), EvalCumsum(12, :), gmmNum0, gmmNum1, P, R, F1);
% % % clear idxMax
% % %end % iterNum
% % % fclose(flog);
% % % ========== iteration ==========
% % toc