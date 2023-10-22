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
% sortie n'est pas la vraie valeur appluiquee au moteur, c'est la valeur numerique seuilee


Phi = zeros(na+nb+1,1);
SortiePredictARX = zeros(1,NN);
ErreurPredictARX = zeros(1,NN);
for kk = nzpad+1:NN
    Phi = [-maSortie(kk-1:-1:kk-na)'; monEntree(kk-dd:-1:kk-dd-nb)'];
    SortiePredictARX(kk) = Phi' * thetaChapeau;
    ErreurPredictARX(kk) = maSortie(kk) - SortiePredictARX(kk);
    somme2 = somme2 + phi*maSortie(kk);
end

SortieModeleCommande = (lsim(sys_d,monEntree,tTemps_d))';
maCol1 = [210,250,150]./255;
figure(2);clf
hold on
pl0 = plot(tTemps_d,maSortie,'r-');
pl1 = plot(tTemps_d, SortieModeleCommande, 'g-', 'LineWidth', 0.5);
pl2 = plot(tTemps_d, SortiePredictARX, '-', 'Color', maCol1, 'LineWidth', 1);

% Tracé de l'histogramme de l'erreur de prédiction
figure(3);clf
hist(ErreurPredictARX,ceil(NN/1000))
title('erreur de prédiction')

% Tracé de l'histogramme de l'erreur de simulation
figure(4);clf
hist(maSortie-SortieModeleCommande,ceil(NN/1000))
title('erreur de simulation')

% Moyenne des erreurs relatives
mean(ErreurPredictARX/max(abs(ErreurPredictARX)));
mean(maSortie-SortieModeleCommande/max(abs(maSortie-SortieModeleCommande)));


% Pole de l'ordre de -110 d'après les applications numériques (d'après le partie préparatoire)
% D'après Shannon -220 (2*pi*f*c ???) ==> fréquence 500 Hz


