function Y = adddelta(X)
% Y = adddelta(X)
% adds delta parameter
%
% NOTE
% this code is given by Miaomiao Wen, after Saito gave it to her
%
% Daisuke Saito (D3)
%

buf1 = zeros(size(X));
buf2 = zeros(size(X));

buf1(:,1:size(buf1,2)-1) = X(:,2:size(X,2));
buf2(:,2:size(buf2,2)) = X(:,1:size(X,2)-1);

xd = (buf1 - buf2) / 2 ;

Y = [X;xd];