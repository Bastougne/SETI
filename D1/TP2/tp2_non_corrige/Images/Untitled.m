nbIterations = 30;
compteurIteration = 1;

while (compteurIteration < nbIterations)
    if(compteurIteration < 10)
        I = imread(['image_00' num2str(compteurIteration, '%01d') '.jpg']); % Charger l'image
    end
    
    if(compteurIteration >= 10)
        I = imread(['image_0' num2str(compteurIteration, '%02d') '.jpg']);
    end
    
    if ndims(I) == 3
        I = rgb2gray(I); % Convertir en niveaux de gris
    end
    
    
    compteurIteration = compteurIteration + 1
    
end