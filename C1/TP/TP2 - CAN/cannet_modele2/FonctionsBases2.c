/*----------------------------------------------------------------------*/
/*                                                                      */
/*      Source file:            code1.C                                 */
/*      Package:                basic                                   */
/*      Software version:       1.4                                     */
/*      Date:                   October 2020                            */
/*      Authors:                A. ELOUARDI & S. BOUAZIZ & Ch. JOUVRAY	*/
/*		      based on	Jens-Ulf Pehrs                          		*/
/*            Philips Semiconductors RHW-PCALH/AI			    		*/
/*                                                                      */
/*                                                                      */
/************************************************************************/

/************************************************************************/
/*      INCLUDES      D E F I N I T I O N S                             */
/************************************************************************/
#include <reg592.h>
#include <stdio.h>
#include <intrins.h>
#include "candefs.h"
#include "FonctionsBases2.h"
#include "libtp2.h"




/************************************************************************/
/************************************************************************/
/*							FONCTIONS									*/
/************************************************************************/
/************************************************************************/

/************************************************************************/
/*......................................................................*/
/*		Fonctions pour la configuration et l'initialisation de CAN		*/
/*......................................................................*/
/************************************************************************/

/************************************************************************/
/*      procedure:      can_config                                      */
/*      input:          ---                                             */
/*      output:         ---                                             */
/*      calls:          ---                                             */
/************************************************************************/

xdata unsigned int LEDS _at_ 0XfD00;

//La reference de tension n'est pas active ... à voir !
unsigned char    can_config ()
{   unsigned char retour=0;
    EA = FALSE;
    can_com=0;
    do    {
        CANADR = CONTROL;
        CANDAT = RESET_REQUEST;
    }   while  ( !(CANDAT & RESET_REQUEST) );
    CANADR = AUTO_ACC_CODE;
    CANDAT = ACCEPT_CODE;
    CANDAT = ACCEPT_MASK;
    CANDAT = BUS_TIM_0;
    CANDAT = BUS_TIM_1;
    CANDAT = OUT_CONTROL;
    CANCON = DIFFERENTIAL;
    do    {
        CANADR = CONTROL;
        CANDAT = 0;
    }   while  ( CANDAT & RESET_REQUEST );
    CANDAT = CAN_INT_ENABLE;

    if  ( CAN_ERROR_STAT )
	        retour=1; //printf("erreur_stat\n");
    PS1 = TRUE;
    ES1 = TRUE;
    EA  = TRUE;
	return retour;
}

/************************************************************************/
/*      procedure:      can_contr_init                                  */
/*      input:          ---                                             */
/*      output:         ---                                             */
/*      calls:          led_init, can_config, slio_init                 */
/************************************************************************/

void can_contr_init()
{
    can_config ();
}


/************************************************************************/
/*      procedure:      CANInitialisation                               */
/*      input:          ---                                             */
/*      output:         ---                                             */
/*      calls:          can_contr_init					                */
/************************************************************************/

void CANInitialisation()
{
	can_contr_init();
    can_init_request=FALSE;
	int_save = CANCON;
	can_tx_ready=1;
}





/************************************************************************/
/*......................................................................*/
/*			Fonction en cas de problème sur le CAN						*/
/*......................................................................*/
/************************************************************************/



/************************************************************************/
/*      procedure:      can_int_error                                   */
/*      input:          ---                                             */
/*      output:         ---                                             */
/*      calls:          ---                                             */
/*----------------------------------------------------------------------*/
/*      running on interrupt level, called from "can_int ()"            */
/************************************************************************/

void    can_int_error ()
{
    if  ( CAN_ERROR_STAT )  {
        can_event       = TRUE;
        if  ( CAN_BUS_STATUS )
            can_system_error = TRUE;
    }
    else  {
        can_event   = FALSE;
    }
}

/************************************************************************/
/*......................................................................*/
/*			Fonctions pour la réception de messages sur le CAN			*/
/*......................................................................*/
/************************************************************************/

/************************************************************************/
/*      procedure:      can_buf_full                                    */
/*      input:          ---                                             */
/*      output:         ---                                             */
/*      calls:          ---                                             */
/*----------------------------------------------------------------------*/
/*      running on interrupt level, called from "can_int ()"            */
/*----------------------------------------------------------------------*/
/*                                                                      */
/*                                                                      */
/************************************************************************/

void    can_buf_full ()
{

//    CANSTA = (char *)tab_rx;
    CANSTA = (unsigned char)(can_buffrx);
	CANADR = DMA_EN|AUTO_RX_BUFFER;
	_nop_();
	_nop_();
	_nop_();
	_nop_();
	_nop_();
    if  ( overrun_int )
        CANCON = RELEASE_RX_BUF | OVERRUN_CLEAR;
    else
        CANCON = RELEASE_RX_BUF;

	can_event   = TRUE;
    can_rx_ready =TRUE;
}

/************************************************************************/
/*......................................................................*/
/*			Fonctions pour l'émission de messages sur le CAN			*/
/*......................................................................*/
/************************************************************************/

/************************************************************************/
/*      procedure:      send_message                                    */
/*      input:          data_table         				*/
/*      output:         ---                                             */
/*      calls:                                                          */
/************************************************************************/

unsigned char send_message ( unsigned char *tabtx ){

  int_save    = CANCON;
  if  ( CAN_TX_BUFFER )   {
    CANSTA = (char)tabtx;
    CANADR = DMA_EN|AUTO_TX_BUFFER;
	_nop_();
	_nop_();
	_nop_();
	_nop_();
	_nop_();
    can_event = TRUE;
    can_tx_ready = FALSE;
    can_tx_sending = TRUE;
    CANCON = TRANSMIT_REQUEST|DIFFERENTIAL;        		/* start CAN transmit to SLIO */
	return 1;
  }
  else   {                                    			/* error exit, if transmit    */

  //ATTENTION ne pas faire ca car cela risque de planter
  // il faut rien faire dans ce cas et prévenir qu'il n'y  pas
  //d'émission...... et emettre à nouveau apres.
    CANCON           = TRANSMIT_ABORT|DIFFERENTIAL;     /*    not possible            */
    can_system_error = TRUE;
    can_init_request = TRUE;
    can_partner      = FALSE;
    can_tx_ready=can_tx_sending=FALSE;
	return 0;
    };
}

/************************************************************************/
/*      procedure:      can_tx_complete                                 */
/*      input:          ---                                             */
/*      output:         ---                                             */
/*      calls:          ---                                             */
/*----------------------------------------------------------------------*/
/*      running on interrupt level, called from "can_int ()"            */
/************************************************************************/

void    can_tx_complete ()
{
    can_event = TRUE;
	can_tx_ready = TRUE;
}


/************************************************************************/
/*......................................................................*/
/*			Fonction gérant les interruptions sur le CAN				*/
/*......................................................................*/
/************************************************************************/
/*      procedure:      can_int                                         */
/*      input:          ---                                             */
/*      output:         ---                                             */
/*      calls:          ---                                             */
/*----------------------------------------------------------------------*/
/*      running on interrupt level, called from "can_int ()"            */
/************************************************************************/

void    can_int (void)  interrupt 5
{
    int_save = CANCON;

    if  ( error_int ){			// due à une erreur
		can_int_error ();
	}
    if  ( receive_int )    							// due à la réception d'un message
	{
		// on stocke la valeur du tps lors de la réception du message NON
		    CANSTA = (unsigned char)(can_buffrx);
			CANADR = DMA_EN|AUTO_RX_BUFFER;
			_nop_();
			_nop_();
			_nop_();
			_nop_();
    		if  ( overrun_int )
        		CANCON = RELEASE_RX_BUF | OVERRUN_CLEAR;
    		else
        		CANCON = RELEASE_RX_BUF;
			can_event   = TRUE;
    		can_rx_ready =TRUE;

	}
    if  ( transmit_int && CAN_TX_COMPLETE ){// due à une transm- correcte et buffer d'emission vide
  		can_tx_complete ();
	}
}


/************************************************************************/
/*      procedure:      main                                            */
/*      input:          ---                                             */
/*      output:         ---                                             */
/*      calls:          CANInitialisation, LireBufferReception          */
/*                      CANEmissionMessage, CANREceptionMessage         */
/************************************************************************/

unsigned int countx;
int taille;
	char message[32] = {'s','a','l','u','t'};
unsigned char can_bufftx[20];
int count=0;
char toucheClavier,touche;
/***************************   MAIN      *********************************/
void main()
{
	short id;
	short dataChange;
	char data1;
	char data2;
	char dlc;
	int i,j,k;



	int indexBuffer=2;
	//Initialisation du CAN
    CANInitialisation();
	printf("initialisation du systeme\n");

	while(1)
	{
		/**** erreur donc demande d'initialisation *****/
		if  ( can_system_error ){
 			printf("CAN ERREUR\n");
			can_init_request = TRUE;
		}
		/**** besoin d'une initialisation *****/
		if  ( can_init_request ){
 			printf("initialisation CAN\n");
		    CANInitialisation();
			can_init_request=FALSE;
    	}

		if (can_rx_ready)
		{
		  can_rx_ready=0;

            /// Réception de l’ID et du DLC d’une trame CAN ///
			/*id = (((unsigned short) can_buffrx[0]) <<3 | can_buffrx[1]>>5);
			  printf("ID : %x\n",id);
			  dlc = can_buffrx[1] & 0x00FF;
			  printf("DLC : %u\n",(unsigned int) dlc);*/

            /// Affichage de deux octets de données sur le barre-graph ///
            /*dataChange = can_buffrx[2]<<8 | can_buffrx[3];
			printf("dataChange %u\n",(unsigned int) dataChange);
			leds = dataChange;*/

			/// Décodage des trames (sauf ID = 0x370) ==> Message secret ///
			if((int) id != 880)
			{
				for(i = 2; i<10; i++)
				{
					printf("%c",can_buffrx[i]);
				}
			}
			if((int) id == 864)
			{
				printf("\n");
			}
		}


		if(can_tx_ready)
        {
            /// Émission de trames CAN en appuyant sur une touche ///
            /*toucheClavier = detect_touche();

            if(toucheClavier!=(char)0xff)
            {
                can_tx_ready = 0;
                can_bufftx[0] =  0x80;
                can_bufftx[1]=  0x01;
                can_bufftx[2] = decode_touche(toucheClavier);
                send_message(can_bufftx);
                for(j=0;j<30000;j++) {};
            }
            */

            /// Envoie d’un message de taille allant jusqu’à 30 octets  ///
            can_tx_ready = 0;
            taille = sizeof(message); /// Taille en octets du message
            can_bufftx[0] = 0x80; /// ID de notre groupe 0x400 en hexadécimal

            for(k = 0; k<taille; k++) /// On parcourt chaque caractère du message
            {
                /// indexBuffer est initialisé à 2
                can_bufftx[indexBuffer] = message[k]; /// On ajoute le caractère dans le prochain octet du buffer Tx
                indexBuffer++; /// On incrémente le buffer pour permettre d'écrire dans le prochain octet

                if(k%8==0||k==taille-1) /// Si on a écrit 8 octets de données, on envoie la 1ère partie du message
                {                       /// Ou si l'on arrive à la fin du message

                    if(taille-k<8)      /// Si on est a la fin du message (et inférieur à 8 bits de données)
                        (int)can_bufftx[1] =  taille-k; /// On définit la taille d'octets de données à envoyer
                    else
                        (int)can_bufftx[1] = 0x08; /// Sinon on définit la taille d'octets de données à envoyer à 8

                    send_message(can_bufftx); /// On envoie le message
                    indexBuffer = 2; /// On définit l'index à 2 pour ré-écrire une nouvelle trame
                    for(j=0;j<30000;j++); /// Temporisation bloquante
                }
            }
		}
	 }
}

