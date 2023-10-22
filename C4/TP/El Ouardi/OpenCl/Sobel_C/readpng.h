#include "tpc4.h"

struct struct_file
{
	unsigned char* image;
	unsigned width;
	unsigned height;
};

unsigned int* ByteToInt(const unsigned char* image, const unsigned& width, const unsigned& height)
{
	unsigned int* tmp = (unsigned int*)malloc(width * height * sizeof(unsigned int));

	for(unsigned int y = 0; y < height; y++){
	  for(unsigned int x = 0; x < width; x++) {
		tmp[y*width+x] = image[4 * width * y + 4 * x + 0] |
			image[4 * width * y + 4 * x + 1] <<8 |
			image[4 * width * y + 4 * x + 2] <<16 |
			image[4 * width * y + 4 * x + 3] <<24;
	  }
	}

	return tmp;
}

unsigned char* IntToByte(const unsigned int* tmp, const unsigned& width, const unsigned& height)
{
	unsigned char* image = (unsigned char*)malloc(4*width*height*sizeof(unsigned char));
	for(unsigned int y = 0; y < height; y++) {
	  for(unsigned int x = 0; x < width; x++) {
		image[4 * width * y + 4 * x + 0] = tmp[y*width+x]&0xff;
		image[4 * width * y + 4 * x + 1] = (tmp[y*width+x]>>8)&0xff;
		image[4 * width * y + 4 * x + 2] = (tmp[y*width+x]>>16)&0xff;
		image[4 * width * y + 4 * x + 3] = (tmp[y*width+x]>>24)&0xff;
	  }
	}

	return image;
}


void encodeTwoSteps(const char* filename, struct_file &s_file) {
  unsigned char* png;
  size_t pngsize;

  unsigned error = lodepng_encode32(&png, &pngsize, s_file.image, s_file.width, s_file.height);
  if(!error) lodepng_save_file(png, pngsize, filename);

  /*if there's an error, display it*/
  if(error) printf("error %u: %s\n", error, lodepng_error_text(error));

  free(png);
}

/*** Ici on va lancer le filtre souhaité	***/

struct_file decodeTwoSteps(const char* filename) {
  unsigned error;
  unsigned char* image = 0;
  unsigned width, height;
  unsigned char* png = 0;
  size_t pngsize;

  error = lodepng_load_file(&png, &pngsize, filename);
  if(!error) error = lodepng_decode32(&image, &width, &height, png, pngsize);
  if(error) printf("error %u: %s\n", error, lodepng_error_text(error));

  free(png);

  /********/

  printf("Taille de l'image: [%d/%d]\n",width,height);

  unsigned int* tmp = 0;

  tmp = ByteToInt(image,width,height);

  /***Process Here****/

  size_t nb_it = 1;
  DWORD sum = 0;
  for(size_t i=0; i<nb_it; i++)
  {
	  CChrono c;
	  /**************************** Function here *******************************/

		/*** Sobel Filter  ****/	
	  tmp = filter_sobel(tmp,width,height); 
	  /*************************************************************************/
	  sum+=c.GetDelayUs();
  }

  /*******************/

  free(image);
  image=0;
  image = IntToByte(tmp, width, height);

  free(tmp);

  /********/

  struct_file s_file;
  s_file.width=width;
  s_file.height=height;
  s_file.image=image;

  return s_file;
}

/********************************************************************/