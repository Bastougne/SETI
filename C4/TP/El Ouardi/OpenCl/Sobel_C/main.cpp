/***    	Librairie PNG       ***/
/*** https://lodev.org/lodepng/ ***/
#include "lodepng.h"

/***  Dossier de travail du tp  ***/
#include "readpng.h"

using namespace std;

int main() 
{
	struct_file s_file;
	//On decode ici le png, la structure garde la taille de l'image (en pixels) et l'image sous forme de unsigned char*
	s_file=decodeTwoSteps("sample_image.png");
	//On encode ici pour renvoyer l'image
	encodeTwoSteps("sample_image_c.png",s_file);
	free(s_file.image);
}