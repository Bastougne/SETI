close all;

%Ouverture d'une image au format couleur
ima=single(imread('ferrari.jpg'));
ima=ima./255;

%Affichage d'une image couleur avec image
figure('name','RGB in','numbertitle','off');image(ima);

%Taille d'une image
taille=size(ima);
display(taille);

ima_r=ima(:,:,1);
ima_g=ima(:,:,2);
ima_b=ima(:,:,3);

%Affichage d'un niveau de couleur de l'image
figure('name','R','numbertitle','off');imagesc(ima_r);colormap gray  %Niveau de rouge
figure('name','G','numbertitle','off');imagesc(ima_g);colormap gray  %Niveau de vert
figure('name','B','numbertitle','off');imagesc(ima_b);colormap gray  %Niveau de bleu

%Taille d'une image
taille=size(ima);
display(taille);

imaSeuil = ima;
ima2 = ima;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%tic toc pour mesurer le temps de calcul
tic;

for i = 1:taille(1) % Parcours de la longueur de l'image
    for j = 1:taille(2) % Parcours de la largeur de l'image
        n = ima(i,j,1)/(sqrt(ima(i,j,1).^2+ima(i,j,2).^2+ima(i,j,3).^2)); %calcul niv de rouge
        if n <= 0.7
            imaSeuil(i,j,:) = 0;
        end
    end
end

ima_out=ima;

toc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%V2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tic;

ima_out2 = ima2; % Récupère l'image initiale
niveauRouge = ima_r./(sqrt(ima_r.^2+ima_g.^2+ima_b.^2)); % Calcul du niveau de rouge
masque = niveauRouge > 0.7; % Création d'un masque, remplace le if
ima_g(masque)=ima_g(masque)+ima_r(masque); % Jaune = rouge + vert
ima_out2(:,:,2)=ima_g; % On récupère le résultat

toc;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure('name','Ferrari jaune non optimisé','numbertitle','off');image(ima_out);
figure('name','Ferrari rouge','numbertitle','off');image(imaSeuil);
figure('name','Ferrari jaune optimisé','numbertitle','off');image(ima_out2);

%Sauvegarde d'une image au format jpg
imwrite(ima_out,'ferrari_out.jpg','jpg');
imwrite(imaSeuil,'ferrari_outSeuil.jpg','jpg');
imwrite(ima_out2,'ferrari_out2.jpg','jpg');

%Sauvegarde d'une image au format raw
fid = fopen('ferrari_out.raw', 'w');
fwrite(fid, ima_out, 'single');
fclose(fid);

fidSeuil = fopen('ferrari_outSeuil.raw', 'w');
fwrite(fidSeuil, imaSeuil, 'single');
fclose(fidSeuil);

fid2 = fopen('ferrari_out2.raw', 'w');
fwrite(fid2, ima_out2, 'single');
fclose(fid2);
