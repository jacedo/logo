//Hector Molano Macias

#include <stdio.h>
#include <string.h>
#include "bucle.h"
#include "Entorno.h"


void cmdInicio(int modo){

	inicio();
    pon_tortuga(400,300,0);
	if(modo)readkey();
}

void cmdFin(){
	fin();
}
 	
void cmdAvanza(int *columna,int *fila,int valor, int lapiz, int oculta, int orientacion,int R, int G, int B, int modo){

	if(oculta==0){
					borra_tortuga(*columna,*fila);
				}

				switch(orientacion){
					case 0:		if(lapiz==1){
								linea(*columna,*fila,*columna,*fila-(int)valor,R,G,B);
							}								
							*fila=*fila-(int)valor;
							break;//norte
					case 1: 	if(lapiz==1){
								linea(*columna,*fila,*columna+(int)valor,*fila,R,G,B);
							}
							*columna=*columna+(int)valor;
							break;//este
					case 2: 	if(lapiz==1){
								linea(*columna,*fila,*columna,*fila+(int)valor,R,G,B);
							}
							*fila=*fila+(int)valor;
							break;//sur
					case 3:		if(lapiz==1){
								linea(*columna,*fila,*columna-(int)valor,*fila,R,G,B);
							}
							*columna=*columna-(int)valor;
							break;//oeste
				};
					
				
				
				if(oculta==0){
					pon_tortuga(*columna,*fila,orientacion);
				}
				if(modo)readkey();
}

void cmdRetrocede(int *columna,int *fila,int valor, int lapiz, int oculta, int orientacion,int R, int G, int B,int modo){

	if(oculta==0){
					borra_tortuga(*columna,*fila);
				}
			
				switch(orientacion){
					case 0:		if(lapiz==1){
								linea(*columna,*fila,*columna,*fila+(int)valor,R,G,B);
							}
							*fila=*fila+(int)valor;
							break;//norte
					case 1: 	{
								linea(*columna,*fila,*columna-(int)valor,*fila,R,G,B);
							}
							*columna=*columna-(int)valor;
							break;//este
					case 2: 	if(lapiz==1){
								linea(*columna,*fila,*columna,*fila-(int)valor,R,G,B);
							}
							*fila=*fila-(int)valor;
							break;//sur
					case 3:		if(lapiz==1){
								linea(*columna,*fila,*columna+(int)valor,*fila,R,G,B);
							}
							*columna=*columna+(int)valor;
							break;//oeste
				};
					
				
				if(oculta==0){
					pon_tortuga(*columna,*fila,orientacion);
				}
				if(modo)readkey();
}

void cmdGiraDerecha(int columna,int fila,int valor, int oculta, int *orientacion,int modo){

	if(oculta==0){
		borra_tortuga(columna,fila);
	}
	*orientacion=(*orientacion+(int)(valor/90))%4;
	if(oculta==0){
		pon_tortuga(columna,fila,*orientacion);
	}
	if(modo)readkey();

}

void cmdGiraIzquierda(int columna,int fila,int valor, int oculta, int *orientacion,int modo){

	if(oculta==0){
		borra_tortuga(columna,fila);
	}
	*orientacion=(*orientacion-(int)(valor/90))%4;
	if(*orientacion<0){
		*orientacion=*orientacion+4;
	}
	if(oculta==0){
		pon_tortuga(columna,fila,*orientacion);
	}
	if(modo)readkey();
}

void cmdBajaLapiz(int *lapiz){
	*lapiz=1;
}

void cmdSubeLapiz(int *lapiz){
	*lapiz=0;
}

void cmdMuestraTortuga(int columna, int fila, int orientacion, int *oculta,int modo){

	pon_tortuga(columna,fila,orientacion);
	if(modo)readkey();	
	*oculta=0;
}

void cmdOcultaTortuga(int columna, int fila, int orientacion, int *oculta,int modo){

	borra_tortuga(columna,fila);
	if(modo)readkey();
	*oculta=1;
}

void ejecutarBucle(int veces,instruccion cmd[],int num_cmd,int *columna,int *fila, int *lapiz, int *oculta, int *orientacion,int R, int G, int B,int modo){
	int i=0;
	int j=0;

	//esto se hace porque ya se ha ejecutado una vez
	veces--;

	while(i<num_cmd && j<veces){
		switch(cmd[i].comando){
			case 0: 
					cmdAvanza(columna,fila,cmd[i].parametro.numero,*lapiz,*oculta,*orientacion,R,G,B,modo);
					break;
			case 1: 
					cmdRetrocede(columna,fila,cmd[i].parametro.numero,*lapiz,*oculta,*orientacion,R,G,B,modo);
					break;
			case 2:
					cmdGiraDerecha(*columna,*fila,cmd[i].parametro.numero,*oculta, orientacion,modo);
					break;
			case 3:
					cmdGiraIzquierda(*columna,*fila,cmd[i].parametro.numero,*oculta, orientacion,modo);
					break;
			case 4:
					cmdBajaLapiz(lapiz);
					break;
			case 5:
					cmdSubeLapiz(lapiz);
					break;
			case 6:
					cmdMuestraTortuga(*columna,*fila,*orientacion, oculta,modo);
					break;
			case 7:
					cmdOcultaTortuga(*columna,*fila,*orientacion, oculta,modo);
					break;
			case 8:
					muestra_mensaje(cmd[i].parametro.cadena);if(modo)readkey();
					break;
			default: printf("Comando no reconocido");break;

		};

		i++;
		if(i==num_cmd){
			j++;
			i=0;
		}
	}
}

void reinicilizaCmd(instruccion cmd[],int *contador_cmd){
	int i=0;

	*contador_cmd=0;

	for (int i = 0; i < MAXCMD; ++i)
	{
		cmd[i].comando=-1;
		cmd[i].parametro.numero=-1;
		strcpy(cmd[i].parametro.cadena,"");
	}

}

void cmdBorrarPantalla(int modo){
	borra_pantalla();
    pon_tortuga(400,300,0);
	if(modo)readkey();
}