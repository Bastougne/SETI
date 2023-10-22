nbIterations = 100;
compteurIteration = 0;

while (compteurIteration < nbIterations)

    I = imread('banc.png'); % Charger l'image
    if ndims(I) == 3
        I = rgb2gray(I); % Convertir en niveaux de gris
    end

    [hauteur, largeur] = size(I);
    % Calcul de la norme L1 du gradient
    [gradientX,gradientY] = imgradientxy(I);
    E1 = abs(gradientX) + abs(gradientY);



    source_nodes_idx = [hauteur+((hauteur-1)*(largeur-1))*4+(2*(largeur-1))+hauteur];
    destination_nodes_idx = [hauteur+((hauteur-1)*(largeur-1))*4+(2*(largeur-1))+hauteur];
    weights = [hauteur+((hauteur-1)*(largeur-1))*4+(2*(largeur-1))+hauteur];

    boucle = 1;
    compteurBoucle = 0;

    for colonne = 1:hauteur
        compteurBoucle = compteurBoucle + 1;
        source_nodes_idx(compteurBoucle) = boucle;
        destination_nodes_idx(compteurBoucle) = (boucle+1)+((colonne-1)*largeur);
        weights(compteurBoucle) = 2000000;
    end


    for colonne = 1:hauteur-1

        if colonne > 1
           boucle = boucle + 1;
        end

        for ligne = 1:largeur-1

            boucle = boucle + 1;

            compteurBoucle = compteurBoucle + 1;
            source_nodes_idx(compteurBoucle) = boucle;
            destination_nodes_idx(compteurBoucle) = boucle+1;
            weights(compteurBoucle) = E1(colonne,ligne);

            compteurBoucle = compteurBoucle + 1;
            source_nodes_idx(compteurBoucle) = boucle+1;
            destination_nodes_idx(compteurBoucle) = boucle;
            weights(compteurBoucle) = 2000000;

            compteurBoucle = compteurBoucle + 1;
            source_nodes_idx(compteurBoucle) = boucle+1+largeur;
            destination_nodes_idx(compteurBoucle) = boucle;
            weights(compteurBoucle) = 2000000;

            compteurBoucle = compteurBoucle + 1;
            source_nodes_idx(compteurBoucle) = boucle+1;
            destination_nodes_idx(compteurBoucle) = boucle+largeur;
            weights(compteurBoucle) = 2000000;
        end
    end

    boucle = boucle + 1;

    for ligne = 1:largeur-1

        boucle = boucle + 1;

        compteurBoucle = compteurBoucle + 1;
        source_nodes_idx(compteurBoucle) = boucle;
        destination_nodes_idx(compteurBoucle) = boucle+1; % Peux etre (boucle-1+largeur)
        weights(compteurBoucle) = E1(hauteur,ligne);

        compteurBoucle = compteurBoucle + 1;
        source_nodes_idx(compteurBoucle) = boucle+1;
        destination_nodes_idx(compteurBoucle) = boucle; % Peux etre (boucle-1+largeur)
        weights(compteurBoucle) = 2000000;
    end

    boucle = largeur * hauteur + 2;

    for colonne = 1:hauteur
        compteurBoucle = compteurBoucle + 1;
        source_nodes_idx(compteurBoucle) = (1+largeur)+((colonne-1)*largeur);
        destination_nodes_idx(compteurBoucle) = boucle;

        source_nodes_idx(compteurBoucle);
        weights(compteurBoucle) = 2000000;
    end

    G = digraph(source_nodes_idx, destination_nodes_idx, weights); % Construire un graphe à partir de l'im
    [mf,~,cs,ct] = maxflow(G, 1, boucle, 'searchtrees');
    %mf
    %cs
    %ct

    % PARTITION BINAIRE
    n = numnodes(G);
    partition = zeros(n,1);
    for i = 1:n
        if ismember(i,cs)
            partition(i) = 1;
        elseif ismember(i,ct)
            partition(i) = 0;
        end
    end


    % LES INDICES DE LA FRONTIERE
    indices = [];
    for i = 1:n-1
        if partition(i) ~= partition(i+1)
             indices = [indices, i];
        end
    end

    % LES INDICES FILTRES DE LA FRONTIERE
    longueurPartition = length(indices);
    for i = 1:longueurPartition
        for j = 1:hauteur
            if(i < length(indices))
                if (indices(i) == (1+largeur*j))
                    indices(i) = [];
                end
            end
        end
    end

    %LES INDICES FILTRES DE LA FRONTIERE PAR LIGNE
    for i = 1:length(indices)
        if(i > 0)
           indices(i) = indices(i)-largeur*(i-1);
        end
    end

    newImage = uint8(zeros(hauteur,largeur-1,3));

    for i = 1:hauteur
    compteurSuppressionElement = 0;
    compteurBloquant = 0;
        for j = 1:largeur
            compteurSuppressionElement = compteurSuppressionElement + 1;

            if(compteurSuppressionElement ~= indices(i) && compteurBloquant == 0)
               newImage(i,j,:) = I(i,j,:);
            end

            if(compteurSuppressionElement == indices(i))
                compteurBloquant = 1;
            end

            if(compteurSuppressionElement ~= indices(i) && compteurBloquant == 1)
               newImage(i,j-1,:) = I(i,j,:);
            end
        end
    end


    %AFFICHAGE DES LIGNES NOIRS
%      for i = 1:length(indices)
%          x = i;
%          y = indices(i)-largeur*(i-1);
%          I(x,y) = 0;
%      end

    compteurIteration = compteurIteration + 1
    imshow(newImage);
    imwrite(newImage,'banc.png');

end
