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
#include <math.h>

////////////////////////////////////////////////////////////////////////////////
//! Compute reference data set
////////////////////////////////////////////////////////////////////////////////

    void seuillage_C(float image_out[][SIZE_J][SIZE_I], float image_in[][SIZE_J][SIZE_I])
    {
        float n; // Niveau de rouge
        for(int j = 0; j < SIZE_J; j++) // Boucle de la taille de la longueur
        {
            for(int i = 0; i < SIZE_I; i++) // Boucle de la taille de la largeur
            {
                // Calcul du niveau de rouge d'après la formule
                n = image_in[0][j][i]/sqrt((image_in[0][j][i]*image_in[0][j][i])+(image_in[1][j][i]*image_in[1][j][i])+(image_in[2][j][i]*image_in[2][j][i]));
                if(n > 0.7) // Si niveau de rouge > 0.7
                {
                    image_out[0][j][i]=image_in[0][j][i]; // Alors le pixel de l'image en sortie est le même que celui de l'image d'entrée
                    image_out[1][j][i]=image_in[1][j][i];
                    image_out[2][j][i]=image_in[2][j][i];
                }
                else
                {
                    image_out[0][j][i]= 0; // Sinon le pixel devient noir
                    image_out[1][j][i]= 0; // Sinon le pixel devient noir
                    image_out[2][j][i]= 0; // Sinon le pixel devient noir
                }
            }
        }
    }





