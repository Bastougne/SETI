#include <stdio.h>
#include <iostream>
#include <stdlib.h>
#include <windows.h>
#include <math.h>

#define M_PI 3.14159265358979323846

/*** Pour l'optimisation      ***/
#include <omp.h>

/*** Pour chronometrer		***/
#include "chrono.h"

/**** Fonctions pour le TP ici *****/

unsigned int thresh = 128;

unsigned int* filter_sobel(const unsigned int *image, const unsigned& width, const unsigned& height)
{
	unsigned int* tmp = (unsigned int*)malloc(width * height * sizeof(unsigned int));

		// Filter coefficients
    int Gx[3][3] = {{-1,-2,-1},{0,0,0},{1,2,1}};
    int Gy[3][3] = {{-1,0,1},{-2,0,2},{-1,0,1}};
    
    for(unsigned int i=0; i<height; i++)
    {
		for(unsigned int j=0; j<width; j++)
		{
			if( (i==0)||(i==height-1)||(j==0)||(j==width-1) )
			{
				tmp[i*width+j] = 0;
			}
			else
			{
				 int x_dir = 0;
				 int y_dir = 0;				 
				 
				 for(int ii=0; ii<3; ii++)
				 {
					 for(int jj=0; jj<3; jj++)
					 {
						unsigned int pixel = image[(i+ii-1)*width + (j+jj-1)];
						unsigned int r = (pixel >> 8) & 0xff;
						unsigned int g = (pixel >> 16 ) & 0xff;
						unsigned int b = (pixel >> 24) & 0xff;

						// RGB -> Luma conversion approximation
						// Avoiding floating point math operators greatly reduces
						// resource usage.
						unsigned int luma = r * 66 + g * 129 + b * 25;
						luma = (luma + 128) >> 8;
						luma += 16;
						 
						x_dir += luma * Gx[ii][jj];
						y_dir += luma * Gy[ii][jj];
					 }
				 }
				 
				 unsigned int temp = abs(x_dir) + abs(y_dir);
				 
				 if (temp > thresh) {
					tmp[i*width+j] = 0xffffffff;
				 } 
				 else {
					tmp[i*width+j] = 0xff000000;
				 }
			}
		}
	}
	return tmp;
}
