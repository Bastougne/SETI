// ConsoleApplication1.cpp : Ce fichier contient la fonction 'main'. L'exécution du programme commence et se termine à cet endroit.

#include <iostream>
#include <windows.h>
#include "Dask.h"
#include <vector>
#include <chrono>
#include <bits.h>

using namespace std;
using namespace chrono;

short ID;
unsigned short value;
int x = 0;
int compteur = 0;
std::vector<int> myBuffer;

int main()
{
	ID = Register_Card(PCI_9112, 0);
	if (ID < 0)
		std::cout << "Pas de carte" << std::endl;
	else
		std::cout << "carte trouvee" << std::endl;

	AI_9112_Config(ID, TRIG_INT_PACER);
	AO_9112_Config(ID, 0, AD_B_5_V);

	value = 1;

	long sum = 0;
	long moyenne;
	double count = 0;
	double tpsPeriode, freq;
	short max;

	while (1)
	{
		//Q1
		/*
		AI_ReadChannel(ID, 0, AD_B_5_V, &value);
		value = value >> 4;
		AO_WriteChannel(ID, 0, value);
		*/

		//Q2
		/*
		if (value >= 4094)
			compteur = 1;

		if (value <= 0)
			compteur = 0;

		if (compteur == 0)
			value+=30;
		else
			value-=30;

		if(value>0&&value < 4095)
			AO_WriteChannel(ID, 0, value);
		*/

		//Q3
		auto start = high_resolution_clock::now();
		auto end = high_resolution_clock::now();
		while (duration_cast<seconds> (end - start).count() < 1)
		{
			AI_ReadChannel(ID, 0, AD_B_5_V, &value);
			value = value >> 4;
			myBuffer.push_back(value);
			AO_WriteChannel(ID, 0, value);
			end = high_resolution_clock::now();
		}

		max = myBuffer[0];
		for (size_t i = 0; i < myBuffer.size(); i++)
		{
			sum += myBuffer[i];
			if (i != 0)
				if (((myBuffer[i] > 2048) && (myBuffer[i - 1] < 2048)) || ((myBuffer[i] < 2048) && (myBuffer[i - 1] > 2048)))
					count++;

			if (myBuffer[i] > max)
				max = myBuffer[i];
		}

		count = count / 2;
		tpsPeriode = 1 / count;
		freq = 1 / tpsPeriode;
		moyenne = sum / myBuffer.size();
		std::cout << "moy : " << moyenne << " freq : " << freq << " Amp max : " << max << std::endl;

		sum = 0;
		count = 0;
		myBuffer.clear();
	}

	//Release_Card(ID);
	return 0;

}

// Exécuter le programme : Ctrl+F5 ou menu Déboguer > Exécuter sans débogage
// Déboguer le programme : F5 ou menu Déboguer > Démarrer le débogage

// Astuces pour bien démarrer :
//   1. Utilisez la fenêtre Explorateur de solutions pour ajouter des fichiers et les gérer.
//   2. Utilisez la fenêtre Team Explorer pour vous connecter au contrôle de code source.
//   3. Utilisez la fenêtre Sortie pour voir la sortie de la génération et d'autres messages.
//   4. Utilisez la fenêtre Liste d'erreurs pour voir les erreurs.
//   5. Accédez à Projet > Ajouter un nouvel élément pour créer des fichiers de code, ou à Projet > Ajouter un élément existant pour ajouter des fichiers de code existants au projet.
//   6. Pour rouvrir ce projet plus tard, accédez à Fichier > Ouvrir > Projet et sélectionnez le fichier .sln.
