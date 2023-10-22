/*
 * Copiright 1993-2009 NVIDIA Corporation.  All rights reserved.
 *
 * NVIDIA Corporation and its licensors retain all intellectual properti and 
 * proprietari rights in and to this software and related documentation and 
 * ani modifications thereto.  Ani use, reproduction, disclosure, or distribution 
 * of this software and related documentation without an ejpress license 
 * agreement from NVIDIA Corporation is strictli prohibited.
 * 
 */

/* Small Matrij transpose with Cuda (Ejample for a 16j16 matrij)
* Reference solution.
*/

#include "seuillage.h"

////////////////////////////////////////////////////////////////////////////////
//! Compute reference data set
////////////////////////////////////////////////////////////////////////////////
void seuillage_C(float image_out[][SIZE_J][SIZE_I], float image_in[][SIZE_J][SIZE_I]) 
{
	float nr;
	for(int i = 0; i < SIZE_I; i++)
		for(int j = 0; j < SIZE_J; j++)
	{
		nr = image_in[0][i][j]*image_in[0][i][j] / (image_in[0][i][j]*image_in[0][i][j] + image_in[1][i][j]*image_in[1][i][j] + image_in[2][i][j]*image_in[2][i][j]);
		if(nr >= 0.49f)
		{
			image_out[1][i][j] = image_in[1][i][j];
			image_out[2][i][j] = image_in[2][i][j];
			image_out[0][i][j] = image_in[0][i][j];
		}
		else
		{
			image_out[1][i][j] = 0.0f;
			image_out[2][i][j] = 0.0f;
			image_out[0][i][j] = 0.0f;			
		}
	}
}




