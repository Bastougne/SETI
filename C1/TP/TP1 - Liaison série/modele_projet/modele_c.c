/************************************************************************
 **	Programme exemple pour le TP æcontroleur		       **
 **                                                                    **
 ************************************************************************/

#include <reg592.h>                /* registres specifiques au 592 */
#include <stdio.h>
#include "libtp2.h"



/*****************************************/
/* declaration des variables et tableaux */
/*****************************************/
xdata unsigned int LEDS _at_ 0XfD00;
code int TAB[10] = {0x000, 0x001, 0x003,0x00F, 0x010, 0x011, 0x013,0x01F, 0x0FF, 0x0F1};
int i, cpt = 0, flag = 0;
bit sens = 0;

bit FLAG_Timer = 0;
bit transmit = 0;
bit RECEIVED = 0;

int logic_count = 0, logic_countR = 0;
int nb_bit = 0, nb_bitR = 0;
int emet = 0, recept = 0;
char var_tx, char var_rx;

sbit broche_Tx = 0x97; /* broche P1.7 pour l'émission */
sbit broche_Rx = 0x96; /* broche P1.6 pour la réception */
bit Tx,Rx;

/*******************************************/
/* declaration des procedures et fonctions */
/*******************************************/
void tempoBloquante()
{
	for(i =0; i<30000; i++){}
}

////////////////////////////////

int tempoNonBloquante()
{
	cpt++;
	if(cpt==5000)
    {
		cpt = 0;
		return 1;
	}
	else
		return 0;
}

////////////

void chenillard()
{
	if(decode_touche(detect_touche)==9)
		sens = 0;

	if(decode_touche(detect_touche)==8)
		sens = 1;
}

////////////


void automate_emission(){

	switch(emet)
	{
		case 0:
			Tx = 1;
			if(transmit==1)
				emet = 1;
			break;
		case 1:
			Tx=0;
			nb_bit = 0;
			logic_count = 0;
			emet =2;
			break;
		case 2:
			if(logic_count==12)
			{
				 if(nb_bit!=9)
					emet = 3;
				 else
				 	emet = 4;
			 }

			logic_count++;
			break;
		case 3:
			logic_count=0;
			if (nb_bit<8)
            {
				Tx= var_tx & 0x01;
				var_tx = var_tx>>1;
			}
			else
				Tx=1;

			nb_bit++;
			emet=2;
			break;
		case 4:
			transmit=0;
			emet = 0;
			break;
	}
}

///////////

void automate_reception()
{
short Var_loc;

	switch(recept)
	{
		case 0:
			logic_countR =0;
			if(Rx==0)
				recept=1;
			break;
		case 1:
			if(logic_countR==5)
				recept=2;

			logic_countR++;
			break;
		case 2:
			logic_countR = 0;
			nb_bitR = 0;
			recept=3;
			break;
		case 3:
			if(logic_countR==12)
			{
				if(nb_bitR!=8)
					recept = 4;
				else
					recept = 5;
			}

			logic_countR++;
			break;
		case 4:
			nb_bitR++;
			logic_countR =0;
			printf("varloc1=%u\n",(unsigned int)Var_loc);
			Var_loc = Var_loc >> 1;
			printf("varloc2=%u\n",(unsigned int)Var_loc);

			if(Rx==1)
            {
				Var_loc = Var_loc | 0x80;
				printf("varloc3=%u\n",(unsigned int)Var_loc);
			}
			recept = 3;
			break;
		case 5:
			if(RECEIVED==0)
            {
				 var_rx=Var_loc;
				 printf("message recu=%u\n",(unsigned int)Var_loc);
				 RECEIVED=1;
			}
			recept = 0;
			break;
	}
}

////////////
void init_Timer0()
{
	TMOD=TMOD | 2;
	TH0=0; /*tampon pour période maximum ~192µs car quartz µC à 16MHz */
	TL0=0; /* Compteur mis à 0*/
	ET0=1; /* validation de l’interruption Timer0 bit 1 du registre IE */
	EA=1; /* autorisation globale des interruptions bit 7 du registre IE */
	TR0=1;
}

void timer0() interrupt 1
{
	 broche_Tx=Tx;
	 Rx= broche_Rx;
	 automate_emission();
	 automate_reception();
}

/////////////


/***************************************/
/* main program                        */
/***************************************/
char toucheClavier, messageRecu;

void main (void)
{/* debut du programme apres le startup  */
init_Timer0();

while (1)
{
    toucheClavier = detect_touche();
    if(toucheClavier!=(char)0xff)
    {
        var_tx =decode_touche(toucheClavier);
        printf("touche=%u\n",(unsigned int)var_tx);
        transmit = 1;
    }

    if(RECEIVED==1)
    {
        messageRecu = var_rx;
        printf("message recu=%u\n",(unsigned int)messageRecu);
        RECEIVED=0;
    }

    tempoBloquante();

    /*chenillard();
    if(FLAG_Timer==1&&flag==1)
    {
        if(sens==0)
            j++;
        else
            j--;

        leds = tab[j];
        FLAG_Timer = 0;
    }

    if(j==10&&sens==0)
		j=0;

    if(j==0&&sens==1)
		j=10;

    flag = tempoNonBloquante();
    */
  }
}
