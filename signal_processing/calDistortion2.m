%
% 2010/04/**
% calculates cepstral distortion for INTERSPEECH2010
%
% Aki Kunikoshi (D2)
% yemaozi88@gmail.com
%


%% definition
cnn = ['n04', 'n09', 'n13', 'n14', 'n15', 'n16', 'n21', 'n22', 'n25', 'n27'];
nmax = size(cnn, 2)/3;

kk = 1;
while kk < nmax + 1
    NN_ = cnn(1, (3 * kk - 2):3 * kk);
    NN = num2str(NN_);
    disp(['set:' NN])
    
    AVG = zeros(nmax, 4);
    
    dirOut = ['K:\hmts\100430_INTERSPEECH\' NN];
    fout1 = fopen([dirOut '\dst_out.csv'], 'wt');
    fout2 = fopen('K:\hmts\100430_INTERSPEECH\dst_total.csv', 'wt');
    
mix = [1, 2, 4, 8];
mmax = size(mix, 2);

jj = 1;
while  jj < mmax + 1
    MIX = mix(1, jj);    % integer
    MIX_ = num2str(MIX);
    disp(['mix:' MIX_])

    buf_na1 = 0;
    buf_na2 = 0;
    buf_na3 = 0;
    buf_ni1 = 0;
    buf_ni2 = 0;
    buf_ni3 = 0;
    buf_nu1 = 0;
    buf_nu2 = 0;
    buf_nu3 = 0;
    buf_ne1 = 0;
    buf_ne2 = 0;
    buf_ne3 = 0;
    buf_no1 = 0;
    buf_no2 = 0;
    buf_no3 = 0;
    avg_na = 0;
    avg_ni = 0;
    avg_nu = 0;
    avg_ne = 0;
    avg_no = 0;
    for mm = 1:10
        disp(mm)
        dirIn1 = ['K:\hmts\100430_INTERSPEECH\scep\n\' num2str(mm)];
        dirIn2 = ['K:\hmts\100430_INTERSPEECH\' NN '\syn_' num2str(MIX)];

        % na
        buf_na1 = buf_na1 + distortion([dirIn1 '\na.scep'], [dirIn2 '\na1.scep']);
        buf_na2 = buf_na2 + distortion([dirIn1 '\na.scep'], [dirIn2 '\na2.scep']);
        buf_na3 = buf_na3 + distortion([dirIn1 '\na.scep'], [dirIn2 '\na3.scep']);
        
        % ni
        buf_ni1 = buf_ni1 + distortion([dirIn1 '\ni.scep'], [dirIn2 '\ni1.scep']);
        buf_ni2 = buf_ni2 + distortion([dirIn1 '\ni.scep'], [dirIn2 '\ni2.scep']);
        buf_ni3 = buf_ni3 + distortion([dirIn1 '\ni.scep'], [dirIn2 '\ni3.scep']);

        % nu
        buf_nu1 = buf_nu1 + distortion([dirIn1 '\nu.scep'], [dirIn2 '\nu1.scep']);
        buf_nu2 = buf_nu2 + distortion([dirIn1 '\nu.scep'], [dirIn2 '\nu2.scep']);
        buf_nu3 = buf_nu3 + distortion([dirIn1 '\nu.scep'], [dirIn2 '\nu3.scep']);

        % ne
        buf_ne1 = buf_ne1 + distortion([dirIn1 '\ne.scep'], [dirIn2 '\ne1.scep']);
        buf_ne2 = buf_ne2 + distortion([dirIn1 '\ne.scep'], [dirIn2 '\ne2.scep']);
        buf_ne3 = buf_ne3 + distortion([dirIn1 '\ne.scep'], [dirIn2 '\ne3.scep']);

        % no
        buf_no1 = buf_ne1 + distortion([dirIn1 '\no.scep'], [dirIn2 '\no1.scep']);
        buf_no2 = buf_ne2 + distortion([dirIn1 '\no.scep'], [dirIn2 '\no2.scep']);
        buf_no3 = buf_ne3 + distortion([dirIn1 '\no.scep'], [dirIn2 '\no3.scep']);
    end
    avg_na  = (buf_na1 + buf_na2 + buf_na3) / 30;
    avg_ni  = (buf_ni1 + buf_ni2 + buf_ni3) / 30;
    avg_nu  = (buf_nu1 + buf_nu2 + buf_nu3) / 30;
    avg_ne  = (buf_ne1 + buf_ne2 + buf_ne3) / 30;
    avg_no  = (buf_no1 + buf_no2 + buf_no3) / 30;
    AVG(kk, jj) = (avg_na + avg_ni + avg_nu + avg_ne + avg_no)/5;

    fprintf(fout1, '%s,', NN);
    fprintf(fout1, 'na,')
    fprintf(fout1, '%f,', buf_na1 / 10);
    fprintf(fout1, '%f,', buf_na2 / 10);
    fprintf(fout1, '%f,', buf_na3 / 10);
    fprintf(fout1, '%f,', avg_na);
    fprintf(fout1, '\n');

    fprintf(fout1, '%s,', NN);
    fprintf(fout1, 'ni,')
    fprintf(fout1, '%f,', buf_ni1 / 10);
    fprintf(fout1, '%f,', buf_ni2 / 10);
    fprintf(fout1, '%f,', buf_ni3 / 10);    
    fprintf(fout1, '%f,', avg_ni);
    fprintf(fout1, '\n');
    
    fprintf(fout1, '%s,', NN);
    fprintf(fout1, 'nu,')    
    fprintf(fout1, '%f,', buf_nu1 / 10);
    fprintf(fout1, '%f,', buf_nu2 / 10);
    fprintf(fout1, '%f,', buf_nu3 / 10);    
    fprintf(fout1, '%f,', avg_nu);
    fprintf(fout1, '\n');
    
    fprintf(fout1, '%s,', NN);
    fprintf(fout1, 'ne,')    
    fprintf(fout1, '%f,', buf_ne1 / 10);
    fprintf(fout1, '%f,', buf_ne2 / 10);
    fprintf(fout1, '%f,', buf_ne3 / 10);    
    fprintf(fout1, '%f,', avg_ne);
    fprintf(fout1, '\n');
    
    fprintf(fout1, '%s,', NN);
    fprintf(fout1, 'no,')    
    fprintf(fout1, '%f,', buf_no1 / 10);
    fprintf(fout1, '%f,', buf_no2 / 10);
    fprintf(fout1, '%f,', buf_no3 / 10);    
    fprintf(fout1, '%f,', avg_no);
    fprintf(fout1, '\n');
    
    jj = jj + 1;
end 
kk = kk + 1;
end

for kk = 1:nmax
    NN_ = cnn(1, (3 * kk - 2):3 * kk);
    NN = num2str(NN_);
    fprintf(fout2, '%s,', NN);
    for jj = 1:mmax
        fprintf(fout2, '%f,', AVG(kk, jj));
    end
    fprintf(fout2, '\n');
end

fclose(fout1);
fclose(fout2);