function cep = sgram2cep(sgram,dim)
% cep = sgram2cep(sgram,dim)
% cepstrum analysis using STRAIGHT spectrum
%
% INPUT
% sgram: STRAIGHT spectrogram
% dim: dimension of output cepstrum
% OUTPUT
% cep: cepstrum timeseries
%
% HISTORY
% 2008/**/** Saito gave Kunikoshi this program
%
% AUTHOR
% Daisuke Saito (M2)
%

cep=zeros(dim+1,length(sgram(1,:)));

for ii=1:length(sgram(1,:))
   spec=zeros(1024,1);
   spec(1) = sgram(1, ii);
   for jj=2:513
       spec(jj)=sgram(jj,ii);
       spec(1026-jj)=sgram(jj,ii);
   end
   % cepstral analysis
   tmpcep = real(ifft(log10(spec),1024));
   % liftering (1 to dim )
   cep(:,ii)=tmpcep(1:dim+1);
end