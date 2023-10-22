% TP Servomécanisme,
% M2 SETI, 
% Février 2023

clear all
close all
clc
format short g

cd('C:\Temp\UE520\')

% Période d'échantillonnage
Te = 1E-4;

MonAmplitude = 10; % en Volt
MaPeriode = 8; % en seconde
LargeurImpulsion = 0.5; % fraction de la période
MonRetard = 1; % en seconde

% Récupération des données expérimentales
load('C:\Temp\UE520\TPSETI_IdentBO_01.mat')

ttemps = TPSETI_IdentBO_01.X.Data;
MonEntree = TPSETI_IdentBO_01.Y(1).Data;
MaSortie = TPSETI_IdentBO_01.Y(2).Data;

figure(1);clf;
plot(ttemps,MonEntree,'b')
hold on
plot(ttemps,MaSortie,'r')
xlabel('temps (sec)')
ylabel('Signal Num')
hold off

% Initialisation de l'estimateur MC, de l'ARX
Na = 4;
Nb = 4;
dd = 0;
Somme1 = zeros(Na+Nb,Na+Nb);
Somme2 = zeros(Na+Nb,1);

Nzpad = max([Na,Nb+dd]);
NN = length(MaSortie);
for kk = Nzpad+1:NN
    Phi = [-MaSortie(kk-1:-1:kk-Na)';...
        MonEntree(kk-dd-1:-1:kk-dd-Nb)'];
    Somme1 = Somme1 + Phi*Phi';
    Somme2 = Somme2 + Phi*MaSortie(kk);
end

ThetaChapeau = Somme1\Somme2;
CoefA = ThetaChapeau(1:Na);
CoefB = ThetaChapeau(Na+1:Na+Nb);

Num = [0,CoefB'];
Den = [1,CoefA'];

z=tf('z',Te);
Sys_d = tf(Num,Den,Te);Sys_d.InputDelay=dd;

ttemps_d = 0:Te:(NN-1)*Te;
figure(1);
hold on;
lsim(Sys_d,MonEntree,ttemps_d);
hold off

Phi = zeros(Na+Nb,1);
SortiePrediteARX = zeros(1,NN);
ErreurPredictionARX = zeros(1,NN);
for kk = Nzpad+1:NN
    Phi = [-MaSortie(kk-1:-1:kk-Na)';...
        MonEntree(kk-dd-1:-1:kk-dd-Nb)'];
    SortiePrediteARX(kk) = Phi'*ThetaChapeau;
    ErreurPredictionARX(kk) = MaSortie(kk)-...
        SortiePrediteARX(kk);
end
SortieModeleCde = (lsim(Sys_d,MonEntree,ttemps_d))';
MaCol1 = [010,150,220]./255; % Couleur vert foncé
figure(2);clf
hold on
pl0 = plot(ttemps_d,MaSortie,'r-');
pl1 = plot(ttemps_d,SortieModeleCde,'g-',...
    'LineWidth',0.5);
pl2 = plot(ttemps_d,SortiePrediteARX,'-','Color',...
    MaCol1,'LineWidth',1);

% Tracé de l'histogramme de l'erreur de prédiction
figure(3);clf
hist(ErreurPredictionARX,ceil(NN/1000))
title('erreur de prédiction')
% Tracé de l'histogramme de l'erreur de simulation
figure(4);clf
hist((MaSortie-SortieModeleCde),ceil(NN/1000))
title('erreur de simulation')

% moyenne des Erreurs (relative)
mean(ErreurPredictionARX/...
    max(abs(ErreurPredictionARX)))
mean(MaSortie-SortieModeleCde)/...
    max(abs(MaSortie-SortieModeleCde))

%% Filtrage des données E/S par 
% un filtre passe-bas du 2nd ordre
xxi = 0.71;
ffc = 40; % Hz
aalp = (2/(Te*2*pi*ffc))^2;
bbet = 4*xxi/(Te*2*pi*ffc);
hh0 = (aalp-bbet+1)/(aalp+bbet+1);
hh1 = 2*(1-aalp)/(aalp+bbet+1);
FPB1 = inv(aalp+bbet+1)*(z^2+2*z+1)/...
    (z^2+hh1*z+hh0)
figure(5);clf;bode(FPB1,'b');grid on

MonEntree_f = (lsim(FPB1,MonEntree))';
MaSortie_f = (lsim(FPB1,MaSortie))';

figure(6);clf;
plot(ttemps,MonEntree,'b-');
hold on
plot(ttemps,MonEntree_f,'c-'); hold off

figure(7);clf;
plot(ttemps,MaSortie,'r-');
hold on
plot(ttemps,MaSortie_f,'k-'); hold off

Somme1_f = zeros(Na+Nb,Na+Nb);
Somme2_f = zeros(Na+Nb,1);

Nzpad = max([Na,Nb+dd]);
NN = length(MaSortie_f);
for kk = Nzpad+1:NN
    Phi = [-MaSortie_f(kk-1:-1:kk-Na)';...
        MonEntree_f(kk-dd-1:-1:kk-dd-Nb)'];
    Somme1_f = Somme1_f + Phi*Phi';
    Somme2_f = Somme2_f + Phi*MaSortie_f(kk);
end

ThetaChapeau_f = Somme1_f\Somme2_f;
CoefA_f = ThetaChapeau_f(1:Na);
CoefB_f = ThetaChapeau_f(Na+1:Na+Nb);

Num_f = [0,CoefB_f'];
Den_f = [1,CoefA_f'];

z=tf('z',Te);
Sys_d_f = tf(Num_f,Den_f,Te);Sys_d_f.InputDelay=dd;

ttemps_d = 0:Te:(NN-1)*Te;
figure(10);
plot(ttemps,MonEntree,'b');
hold on
plot(ttemps,MaSortie,'r');
xlabel('temps (sec)')
ylabel('Signal Num')
lsim(Sys_d_f,MonEntree,ttemps_d);
hold off

Phi = zeros(Na+Nb,1);
SortiePrediteARX_f = zeros(1,NN);
ErreurPredictionARX_f = zeros(1,NN);
for kk = Nzpad+1:NN
    Phi = [-MaSortie(kk-1:-1:kk-Na)';...
        MonEntree(kk-dd-1:-1:kk-dd-Nb)'];
    SortiePrediteARX_f(kk) = Phi'*ThetaChapeau_f;
    ErreurPredictionARX_f(kk) = MaSortie(kk)-...
        SortiePrediteARX_f(kk);
end
SortieModeleCde_f = (lsim(Sys_d_f,MonEntree,ttemps_d))';
MaCol1 = [010,150,220]./255; % Couleur vert foncé
figure(12);clf
hold on
pl0 = plot(ttemps_d,MaSortie,'r-');
pl1 = plot(ttemps_d,SortieModeleCde_f,'g-',...
    'LineWidth',0.5);
pl2 = plot(ttemps_d,SortiePrediteARX_f,'-','Color',...
    MaCol1,'LineWidth',1);

% Tracé de l'histogramme de l'erreur de prédiction
figure(13);clf
hist(ErreurPredictionARX_f,ceil(NN/1000));
title('erreur de prédiction')
% Tracé de l'histogramme de l'erreur de simulation
figure(14);clf
hist((MaSortie-SortieModeleCde_f),ceil(NN/1000));
title('erreur de simulation')

% moyenne des Erreurs (relative)
mean(ErreurPredictionARX_f/...
    max(abs(ErreurPredictionARX_f)));
mean(MaSortie-SortieModeleCde_f)/...
    max(abs(MaSortie-SortieModeleCde_f));



%% Calcul du correcteur RST
%% en bf : on impose un comportement du 1er ordre
%% Choix du pole en bf
p1c = 2*-110;
p1d = exp(Te*p1c);

%% Pôle du polynome auxiliaire
p0c = 4*p1c;
p0d = exp(Te*p0c);

DD = exp(Te*-110);
K_Omega = 1.75E-3/(2*pi/60);
Ke = 1/(585*2*pi/60);
Kv = K_Omega/Ke;

% poly. S(z) = s1*z+s0
s1 = (1+DD-p0d-p1d)/(Kv*(1-DD));
s0 = (p0d*p1d-DD)/(Kv*(1-DD));

% Poly. T(z) = t1*z+t0
t1 = (1-p1d)/(Kv*(1-DD));
t0 = -(1-p1d)*p0d/(Kv*(1-DD));




