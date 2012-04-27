//Hector Molano Macias

#include <stdio.h>
#include <string.h>
#include "bucle.h"


void cmdAvanza(FILE * yyout,int *columna,int *fila,int valor, int lapiz, int oculta, int orientacion){

	if(oculta==0){
					fprintf(yyout,"borra_tortuga(%d,%d);\n",*columna,*fila);
				}

				switch(orientacion){
					case 0:		if(lapiz==1){
								fprintf(yyout,"linea(%d,%d,%d,%d);\n",*columna,*fila,*columna,*fila-(int)valor);
							}								
							*fila=*fila-(int)valor;
							break;//norte
					case 1: 	if(lapiz==1){
								fprintf(yyout,"linea(%d,%d,%d,%d);\n",*columna,*fila,*columna+(int)valor,*fila);
							}
							*columna=*columna+(int)valor;
							break;//este
					case 2: 	if(lapiz==1){
								fprintf(yyout,"linea(%d,%d,%d,%d);\n",*columna,*fila,*columna,*fila+(int)valor);
							}
							*fila=*fila+(int)valor;
							break;//sur
					case 3:		if(lapiz==1){
								fprintf(yyout,"linea(%d,%d,%d,%d);\n",*columna,*fila,*columna-(int)valor,*fila);
							}
							*columna=*columna-(int)valor;
							break;//oeste
				};
					
				
				
				if(oculta==0){
					fprintf(yyout,"pon_tortuga(%d,%d,%d)\n",*columna,*fila,orientacion);
				}
				fprintf(yyout,"readkey();\n\n");
}

void cmdRetrocede(FILE * yyout,int *columna,int *fila,int valor, int lapiz, int oculta, int orientacion){

	if(oculta==0){
					fprintf(yyout,"borra_tortuga(%d,%d);\n",*columna,*fila);
				}
			
				switch(orientacion){
					case 0:		if(lapiz==1){
								fprintf(yyout,"linea(%d,%d,%d,%d);\n",*columna,*fila,*columna,*fila-(int)valor);
							}
							*fila=*fila-(int)valor;
							break;//norte
					case 1: 	{
								fprintf(yyout,"linea(%d,%d,%d,%d);\n",*columna,*fila,*columna,*fila+(int)valor);
							}
							*fila=*fila+(int)valor;
							break;//este
					case 2: 	if(lapiz==1){
								fprintf(yyout,"linea(%d,%d,%d,%d);\n",*columna,*fila,*columna+(int)valor,*fila);
							}
							*columna=*columna+(int)valor;
							break;//sur
					case 3:		if(lapiz==1){
								fprintf(yyout,"linea(%d,%d,%d,%d);\n",*columna,*fila,*columna-(int)valor,*fila);
							}
							*columna=*columna-(int)valor;
							break;//oeste
				};
					
				
				if(oculta==0){
					fprintf(yyout,"pon_tortuga(%d,%d,%d)\n",*columna,*fila,orientacion);
				}
				fprintf(yyout,"readkey();\n\n");
}