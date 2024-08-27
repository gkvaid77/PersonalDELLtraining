function [WSD_mag,WSD_phase,sig]=Calculate_WSD(sinef,sig)

% Telban Cardullo 2005 OTO  model
Koto = 0.4;
tau1 = 5;
tau2 = 0.016;
taul1 = 10;
Noto = Koto*[taul1,1];
Doto = [tau1*tau2,tau1+tau2,1];
OTO = tf(Noto,Doto);

[Moto,Poto]=bode(OTO,sinef*2*pi);


% weighted sum of differences modulus
magdiffr1 = abs(sig.mag-1);

for m=1:length(sinef)
sig.magwsd(m) = Moto(1,1,m)*magdiffr1(m);
end
WSD_mag = sum(sig.magwsd);


% weighted sum of differences phase

for p=1:length(sinef)
    sig.phasewsd(p) = Moto(1,1,p)*(sig.phase(p)-Poto(1,1,p))*pi/180;
end
WSD_phase = sum(sig.phasewsd);


f55=figure()
subplot(2,1,1)
stem(sinef,sig.magwsd,'c-.','Linewidth',2,'MarkerFaceColor','y','MarkerEdgeColor','y')
set(gca,'xscal','log')
ylabel('[abs]')
title('Weighted Mod diff from 1')
legend('Test points')
grid on
subplot(2,1,2)
stem(sinef,sig.phasewsd*180/pi,'c-.','Linewidth',2,'MarkerFaceColor','green','MarkerEdgeColor','green')
set(gca,'xscal','log')
hold off
grid on
xlabel('Frequency [Hz]')
ylabel('[°]')
title('Weighted phase diff from 0°')
legend('Test points')
sgtitle('WSD contribution')
f55.Units = 'inches';
f55.Position =[2 2 3.5 3.0];

%This line is added to check for commit1
%this line is added to check for commit2
end