//Hector Molano Macias

#include <stdio.h>
#include <string.h>
#include "bucle.h"
#include "Entorno.h"


void cmdInicio(){

	inicio();
    pon_tortuga(400,300,0);
	readkey();
}

void cmdFin(){
	fin();
}

void cmdAvanza(int *columna,int *fila,int valor, int lapiz, int oculta, int orientacion){

	if(oculta==0){
					borra_tortuga(*columna,*fila);
				}

				switch(orientacion){
					case 0:		if(lapiz==1){
								linea(*columna,*fila,*columna,*fila-(int)valor);
							}								
							*fila=*fila-(int)valor;
							break;//norte
					case 1: 	if(lapiz==1){
								linea(*columna,*fila,*columna+(int)valor,*fila);
							}
							*columna=*columna+(int)valor;
							break;//este
					case 2: 	if(lapiz==1){
								linea(*columna,*fila,*columna,*fila+(int)valor);
							}
							*fila=*fila+(int)valor;
							break;//sur
					case 3:		if(lapiz==1){
								linea(*columna,*fila,*columna-(int)valor,*fila);
							}
							*columna=*columna-(int)valor;
							break;//oeste
				};
					
				
				
				if(oculta==0){
					pon_tortuga(*columna,*fila,orientacion);
				}
				readkey();
}

void cmdRetrocede(int *columna,int *fila,int valor, int lapiz, int oculta, int orientacion){

	if(oculta==0){
					borra_tortuga(*columna,*fila);
				}
			
				switch(orientacion){
					case 0:		if(lapiz==1){
								linea(*columna,*fila,*columna,*fila-(int)valor);
							}
							*fila=*fila-(int)valor;
							break;//norte
					case 1: 	{
								linea(*columna,*fila,*columna,*fila+(int)valor);
							}
							*fila=*fila+(int)valor;
							break;//este
					case 2: 	if(lapiz==1){
								linea(*columna,*fila,*columna+(int)valor,*fila);
							}
							*columna=*columna+(int)valor;
							break;//sur
					case 3:		if(lapiz==1){
								linea(*columna,*fila,*columna-(int)valor,*fila);
							}
							*columna=*columna-(int)valor;
							break;//oeste
				};
					
				
				if(oculta==0){
					pon_tortuga(*columna,*fila,orientacion);
				}
				readkey();
}

void cmdGiraDerecha(int columna,int fila,int valor, int oculta, int *orientacion){

	if(oculta==0){
		borra_tortuga(columna,fila);
	}
	*orientacion=(*orientacion+((int)valor/90))%4;
	if(oculta==0){
		pon_tortuga(columna,fila,*orientacion);
	}
	readkey();

}

void cmdGiraIzquierda(int columna,int fila,int valor, int oculta, int *orientacion){

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
	readkey();
}

void cmdBajaLapiz(int *lapiz){
	*lapiz=1;
}

void cmdSubeLapiz(int *lapiz){
	*lapiz=0;
}

void cmdMuestraTortuga(int columna, int fila, int orientacion, int *oculta){

	pon_tortuga(columna,fila,orientacion);
	readkey();	
	*oculta=0;
}

void cmdOcultaTortuga(int columna, int fila, int orientacion, int *oculta){

	borra_tortuga(columna,fila);
	readkey();
	*oculta=1;
}

void ejecutarBucle(int veces,instruccion cmd[],int num_cmd,int *columna,int *fila, int *lapiz, int *oculta, int *orientacion){
	int i=0;
	int j=0;

	//esto se hace porque ya se ha ejecutado una vez
	veces--;

	printf("Tipo %d\n", cmd[1].comando);
	printf("Veces %d\n", veces);
	printf("Numero de comandos %d\n",num_cmd );

	while(i<num_cmd && j<veces){
		switch(cmd[i].comando){
			case 0: 
					printf("Ejecuta en el bucle avanza %.8g  \n", cmd[i].parametro.numero);
					cmdAvanza(columna,fila,cmd[i].parametro.numero,*lapiz,*oculta,*orientacion);
					break;
			case 1: 
					printf("Ejecuta en el bucle avanza %.8g  \n", cmd[i].parametro.numero);
					cmdRetrocede(columna,fila,cmd[i].parametro.numero,*lapiz,*oculta,*orientacion);
					break;
			case 2:
					printf("Ejecuta en el bucle GiraDerecha %.8g  \n", cmd[i].parametro.numero);
					cmdGiraDerecha(*columna,*fila,cmd[i].parametro.numero,*oculta, orientacion);
					break;
			case 3:
					printf("Ejecuta en el bucle GiraIzquierda %.8g  \n", cmd[i].parametro.numero);
					cmdGiraIzquierda(*columna,*fila,cmd[i].parametro.numero,*oculta, orientacion);
					break;
			case 4:
					printf("Ejecuta en el bucle BajaLapiz\n" );
					cmdBajaLapiz(lapiz);
					break;
			case 5:
					printf("Ejecuta en el bucle SubeLapiz\n" );
					cmdSubeLapiz(lapiz);
					break;
			case 6:
						printf("Ejecuta en el bucle MuestraTortuga\n");
					cmdMuestraTortuga(*columna,*fila,*orientacion, oculta);
					break;
			case 7:
					printf("Ejecuta en el bucle OcultaTortuga\n");
					cmdOcultaTortuga(*columna,*fila,*orientacion, oculta);
					break;
			case 8:
					
					printf("Ejecuta en el bucle muestramensaje %s\n",cmd[i].parametro.cadena);
					muestra_mensaje(cmd[i].parametro.cadena);readkey();
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