% Charger une image RGB
rgbImage = imread('image_001.jpg');

% Convertir l'image en YCbCr
hsvImage = rgb2hsv(rgbImage);

% Récupérer les canaux H, S et V
H = hsvImage(:,:,1);
S = hsvImage(:,:,2);
V = hsvImage(:,:,3);

figure;
imshow(hsvImage);
figure;
imshow(H);
figure;
imshow(S);
figure;
imshow(V);
% H>0.6
% S>0.2
% V<0.25





