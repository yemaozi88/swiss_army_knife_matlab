function sgram = cep2sgram(cep)
% sgram = cep2sgram(cep)
% converts STRAIGHT cepstrum into STRAIGHT spectogram
%
% INPUT
% cep: cepstrum time series
% OUTPUT
% sgram: STRAIGHT spectrogram
%
% HISOTRY
% 2008/**/** Saito gave Kunikoshi this program
%
% AUTHOR
% Daisuke Saito (M2)
%

sgram=zeros(513,length(cep(1,:)));


for ii=1:length(cep(1,:))
    tmpcep=zeros(1024,1);
    for jj=1:length(cep(:,ii))
        tmpcep(jj)=cep(jj,ii);
        if jj > 1
            tmpcep(1026-jj)=cep(jj,ii);
        end
    end
    for jj=length(cep(:,ii))+1:513
        tmpcep(jj)=0;
        tmpcep(1026-jj)=0;
    end
    est=real(fft(tmpcep));
    for jj=1:513
        sgram(jj,ii)=10^est(jj);
    end
    %sgram(513,ii)=sgram(512,ii);
end