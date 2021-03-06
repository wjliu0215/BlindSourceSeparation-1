%CALCOLO DELLE PERFORMANCE per valutare il funzionamento della
%calssificazione
% 
% 
% [...riferimento all'articolo...]
% 
% 
% [...inserire anche valutazione della sparsit� delle sorgenti iniziali...]
% 
%
% "The separation performance was evaluated in
% terms of the SIR improvement and the signal to
% distortion ratio (SDR)."

% The SIR improvement was calculated by
% OutputSIRi-InputSIRi

%%
% %CORRISPONDENZA RICOSTRUITI/SORGENTI ORIGINALI (correlazione)--> non funziona
% %sempre...sbaglia sui segnali separati male  --> molto lento
% 
% %primo ricostruito
% corre11=xcorr(sig1ric,signal1)/(sum(signal1.^2));
% corre12=xcorr(sig1ric,signal2)/(sum(signal2.^2));
% corre13=xcorr(sig1ric,signal3)/(sum(signal3.^2));
% 
% corre1=[sum(corre11.^2);sum(corre12.^2);sum(corre13.^2)]'
% 
% %secondo ricostruito
% corre21=xcorr(sig2ric,signal1)/(sum(signal1.^2));
% corre22=xcorr(sig2ric,signal2)/(sum(signal2.^2));
% corre23=xcorr(sig2ric,signal3)/(sum(signal3.^2));
% 
% corre2=[sum(corre21.^2);sum(corre22.^2);sum(corre23.^2)]'
% 
% %terzo ricostruito
% corre31=xcorr(sig3ric,signal1)/(sum(signal1.^2));
% corre32=xcorr(sig3ric,signal2)/(sum(signal2.^2));
% corre33=xcorr(sig3ric,signal3)/(sum(signal3.^2));
% 
% corre3=[sum(corre31.^2);sum(corre32.^2);sum(corre33.^2)]'
% 
% %REGOLE DI CORRISPONDENZA
% 
% [mass1,I1] = max(corre1);
% [mass2,I2] = max(corre2);
% [mass3,I3] = max(corre3);



%%
%CORRISPONDENZA RICOSTRUITI/SORGENTI ORIGINALI (SIR)
%CALCOLO DELLE INTERFERENZE PRIMA DEL PROCESSSING
% SIRin1=10*log10(sum(signal1.^2)/(sum(signal2.^2)+sum(signal3.^2)));
% SIRin2=10*log10(sum(signal2.^2)/(sum(signal1.^2)+sum(signal3.^2)));
% SIRin3=10*log10(sum(signal3.^2)/(sum(signal1.^2)+sum(signal2.^2)));
% 
% interf12=STFT((signal1+signal2),win);
% interf23=STFT((signal2+signal3),win);
% interf13=STFT((signal1+signal3),win);
% 
% %primo segnale ricostruito
% interf12a=interf12.*masc1;
% interf23a=interf23.*masc1;
% interf13a=interf13.*masc1;
% interf12a=ISTFT(interf12,win);
% interf23a=ISTFT(interf23,win);
% interf13a=ISTFT(interf13,win);
% 
% SIRout11=10*log10(sum(sig1ric.^2)/(sum(interf12a.^2)));
% SIRout12=10*log10(sum(sig1ric.^2)/(sum(interf23a.^2)));
% SIRout13=10*log10(sum(sig1ric.^2)/(sum(interf13a.^2)));
% 
% SIR1=[SIRout11-SIRin3; SIRout12-SIRin1; SIRout13-SIRin2];
% 
% %secondo segnale ricostruito
% interf12b=interf12.*masc2;
% interf23b=interf23.*masc2;
% interf13b=interf13.*masc2;
% interf12b=ISTFT(interf12,win);
% interf23b=ISTFT(interf23,win);
% interf13b=ISTFT(interf13,win);
% 
% SIRout21=10*log10(sum(sig2ric.^2)/(sum(interf12b.^2)));
% SIRout22=10*log10(sum(sig2ric.^2)/(sum(interf23b.^2)));
% SIRout23=10*log10(sum(sig2ric.^2)/(sum(interf13b.^2)));
% 
% SIR2=[SIRout21-SIRin3; SIRout22-SIRin1; SIRout23-SIRin2];
% 
% %terzo segnale ricostruto
% interf12c=interf12.*masc3;
% interf23c=interf23.*masc3;
% interf13c=interf13.*masc3;
% interf12c=ISTFT(interf12,win);
% interf23c=ISTFT(interf23,win);
% interf13c=ISTFT(interf13,win);
% 
% SIRout31=10*log10(sum(sig3ric.^2)/(sum(interf12c.^2)));
% SIRout32=10*log10(sum(sig3ric.^2)/(sum(interf23c.^2)));
% SIRout33=10*log10(sum(sig3ric.^2)/(sum(interf13c.^2)));
% 
% SIR3=[SIRout31-SIRin3; SIRout32-SIRin1; SIRout33-SIRin2];
%%
%CALCOLO DELLE PRESTAZIONI


%CALCOLO DELLE INTERFERENZE PRIMA DEL PROCESSSING
SIRin1=10*log10(sum(signal1.^2)/(sum(signal2.^2)+sum(signal3.^2)));
SIRin2=10*log10(sum(signal2.^2)/(sum(signal1.^2)+sum(signal3.^2)));
SIRin3=10*log10(sum(signal3.^2)/(sum(signal1.^2)+sum(signal2.^2)));

%dipende dalla classificazione!!!!!!!
interf12=STFT((signal1+signal2),win);
interf23=STFT((signal2+signal3),win);
interf13=STFT((signal1+signal3),win);
interf12=interf12.*masc3;
interf23=interf23.*masc2;
interf13=interf13.*masc1;
interf12=ISTFT(interf12,win);
interf23=ISTFT(interf23,win);
interf13=ISTFT(interf13,win);

SIRout1=10*log10(sum(sig1ric.^2)/(sum(interf13.^2)));
SIRout2=10*log10(sum(sig2ric.^2)/(sum(interf23.^2)));
SIRout3=10*log10(sum(sig3ric.^2)/(sum(interf12.^2)));

%PRESTAZIONI
G1=SIRout1-SIRin2;
G2=SIRout2-SIRin1;
G3=SIRout3-SIRin3;

%confronti (figure)
% figure; 
% subplot(2,1,1); imagesc(10*log10(abs(STFT(signal1,win)))); title('Prima Sorgente (originale)');
% subplot(2,1,2); imagesc(10*log10(abs(tra3))); title('Prima Sorgente ricostruita');
% figure; 
% subplot(2,1,1); imagesc(10*log10(abs(STFT(signal2,win)))); title('Seconda Sorgente (originale)');
% subplot(2,1,2); imagesc(10*log10(abs(tra2))); title('Seconda Sorgente ricostruita');
% figure; 
% subplot(2,1,1); imagesc(10*log10(abs(STFT(signal3,win)))); title('Terza Sorgente (originale)');
% subplot(2,1,2); imagesc(10*log10(abs(tra1))); title('Terza Sorgente ricostruita');


disp('Guadagni in dB');
G1
G2
G3