//Hector Molano Macias

#include <stdio.h>
#include <string.h>
#include "bucle.h"
#include "Entorno.h"


void cmdInicio(FILE * yyout){

	inicio();
    pon_tortuga(400,300,0);
	readkey();
	
	//fprintf(yyout,"#include \"entorno.h\"\n\n");
    //fprintf(yyout,"int main(){\n");
	//fprintf(yyout,"inicio();\n");
	//fprintf(yyout,"pon_tortuga(400,300,0);\n");
	//fprintf(yyout,"readkey();\n\n");
}

void cmdFin(FILE * yyout){

	fin();

    //fprintf(yyout,"fin();\n");
	//fprintf(yyout,"return(0);\n");
    //fprintf(yyout,"}\n");
}

void cmdAvanza(FILE * yyout,int *columna,int *fila,int valor, int lapiz, int oculta, int orientacion){

	if(oculta==0){
					borra_tortuga(*columna,*fila);
					//fprintf(yyout,"borra_tortuga(%d,%d);\n",*columna,*fila);
				}

				switch(orientacion){
					case 0:		if(lapiz==1){
								linea(*columna,*fila,*columna,*fila-(int)valor);
								//fprintf(yyout,"linea(%d,%d,%d,%d);\n",*columna,*fila,*columna,*fila-(int)valor);
							}								
							*fila=*fila-(int)valor;
							break;//norte
					case 1: 	if(lapiz==1){
								linea(*columna,*fila,*columna+(int)valor,*fila);
								//fprintf(yyout,"linea(%d,%d,%d,%d);\n",*columna,*fila,*columna+(int)valor,*fila);
							}
							*columna=*columna+(int)valor;
							break;//este
					case 2: 	if(lapiz==1){
								linea(*columna,*fila,*columna,*fila+(int)valor);
								//fprintf(yyout,"linea(%d,%d,%d,%d);\n",*columna,*fila,*columna,*fila+(int)valor);
							}
							*fila=*fila+(int)valor;
							break;//sur
					case 3:		if(lapiz==1){
								linea(*columna,*fila,*columna-(int)valor,*fila);
								//fprintf(yyout,"linea(%d,%d,%d,%d);\n",*columna,*fila,*columna-(int)valor,*fila);
							}
							*columna=*columna-(int)valor;
							break;//oeste
				};
					
				
				
				if(oculta==0){
					pon_tortuga(*columna,*fila,orientacion);
					//fprintf(yyout,"pon_tortuga(%d,%d,%d)\n",*columna,*fila,orientacion);
				}
				readkey();
				//fprintf(yyout,"readkey();\n\n");
}

void cmdRetrocede(FILE * yyout,int *columna,int *fila,int valor, int lapiz, int oculta, int orientacion){

	if(oculta==0){
					borra_tortuga(*columna,*fila);
					//fprintf(yyout,"borra_tortuga(%d,%d);\n",*columna,*fila);
				}
			
				switch(orientacion){
					case 0:		if(lapiz==1){
								linea(*columna,*fila,*columna,*fila-(int)valor);
								//fprintf(yyout,"linea(%d,%d,%d,%d);\n",*columna,*fila,*columna,*fila-(int)valor);
							}
							*fila=*fila-(int)valor;
							break;//norte
					case 1: 	{
								linea(*columna,*fila,*columna,*fila+(int)valor);
								//fprintf(yyout,"linea(%d,%d,%d,%d);\n",*columna,*fila,*columna,*fila+(int)valor);
							}
							*fila=*fila+(int)valor;
							break;//este
					case 2: 	if(lapiz==1){
								linea(*columna,*fila,*columna+(int)valor,*fila);
								//fprintf(yyout,"linea(%d,%d,%d,%d);\n",*columna,*fila,*columna+(int)valor,*fila);
							}
							*columna=*columna+(int)valor;
							break;//sur
					case 3:		if(lapiz==1){
								linea(*columna,*fila,*columna-(int)valor,*fila);
								//fprintf(yyout,"linea(%d,%d,%d,%d);\n",*columna,*fila,*columna-(int)valor,*fila);
							}
							*columna=*columna-(int)valor;
							break;//oeste
				};
					
				
				if(oculta==0){
					pon_tortuga(*columna,*fila,orientacion);
					//fprintf(yyout,"pon_tortuga(%d,%d,%d)\n",*columna,*fila,orientacion);
				}
				readkey();
				//fprintf(yyout,"readkey();\n\n");
}

void cmdGiraDerecha(FILE * yyout,int columna,int fila,int valor, int oculta, int *orientacion){

	if(oculta==0){
		borra_tortuga(columna,fila);
		//fprintf(yyout,"borra_tortuga(%d,%d);\n",columna,fila);
	}
	*orientacion=(*orientacion+((int)valor/90))%4;
	if(oculta==0){
		pon_tortuga(columna,fila,*orientacion);
		//fprintf(yyout,"pon_tortuga(%d,%d,%d)\n",columna,fila,*orientacion);
	}
	readkey();
	//fprintf(yyout,"readkey();\n\n");

}

void cmdGiraIzquierda(FILE * yyout,int columna,int fila,int valor, int oculta, int *orientacion){

	if(oculta==0){
		borra_tortuga(columna,fila);
		//fprintf(yyout,"borra_tortuga(%d,%d);\n",columna,fila);
	}
	*orientacion=(*orientacion+(int)(valor/90))%4;
	if(*orientacion<0){
		*orientacion=*orientacion+4;
	}
	if(oculta==0){
		pon_tortuga(columna,fila,*orientacion);
		//fprintf(yyout,"pon_tortuga(%d,%d,%d)\n",columna,fila,*orientacion);
	}
	readkey();
	//fprintf(yyout,"readkey();\n\n");
}

void cmdBajaLapiz(int *lapiz){
	*lapiz=1;
}

void cmdSubeLapiz(int *lapiz){
	*lapiz=0;
}

void cmdMuestraTortuga(FILE * yyout,int columna, int fila, int orientacion, int *oculta){

	pon_tortuga(columna,fila,orientacion);
	//fprintf(yyout,"pon_tortuga(%d,%d,%d)\n",columna,fila,orientacion);
	readkey();
	//fprintf(yyout,"readkey();\n\n");				
	*oculta=0;
}

void cmdOcultaTortuga(FILE * yyout,int columna, int fila, int orientacion, int *oculta){

	borra_tortuga(columna,fila);
	//fprintf(yyout,"borra_tortuga(%d,%d);\n",columna,fila);
	readkey();
	//fprintf(yyout,"readkey();\n\n");
	*oculta=1;
}