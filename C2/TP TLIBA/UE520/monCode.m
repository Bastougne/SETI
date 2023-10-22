% TP Servomécanisme
% M2 SETI

clear all
close all
clc
format short g

cd('C:\Temp\UE520')

Te = 1E-4;
monAmplitude = 10; % en volts
maPeriode = 8; % en secondes
largeurImpulsion = 0.5; % en %
monRetard = 1; % en secondes

% récupération des données expérimentales
load('C:\Temp\UE520\TP_SETI_IdentBO_01.mat')

tTemps = TP_SETI_IdentBO_01.X.Data;
monEntree = TP_SETI_IdentBO_01.Y(1).Data;
maSortie = TP_SETI_IdentBO_01.Y(2).Data;

figure(1);
clf;
plot(tTemps, monEntree, 'b')
hold on
plot(tTemps, maSortie, 'r')
xlabel('Temps(sec)')
ylabel('Signal num')
hold off

na = 2;
nb = 2;
dd = 1;

somme1 = zeros(na+nb+1,na+nb+1);
somme2 = zeros(na+nb+1,1);

nzpad = max ([na,nb+dd]);
NN = length(maSortie);
for kk = nzpad+1:NN
    phi = [-maSortie(kk-1:-1:kk-na)'; monEntree(kk-dd:-1:kk-dd-nb)'];
    somme1 = somme1 + phi*phi';
    somme2 = somme2 + phi*maSortie(kk);
end

thetaChapeau = somme1\somme2;
coeffA = thetaChapeau(1:na);
coeffB = thetaChapeau(na+1:na+nb+1);

num = [coeffB'];
den = [1,coeffA'];

z=tf('z',Te);
sys_d = tf(num,den,Te);
sys_d.inputDelay=dd;

tTemps_d = 0:Te:(NN-1)*Te;
figure(1);
hold on;
lsim(sys_d,monEntree,tTemps_d);
hold off;

% temps mort = d
% b0 = 0, na = 1, nb = 1
% Expliquer les résultats obtenues expérimentalement

