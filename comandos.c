#include "comandos.h"
#include <math.h>


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
				int columna2;
				int fila2;
				int aux=(orientacion*360)/256;
				while(aux>90){
					aux=aux-90;
				}
				aux=90-aux;
				switch(orientacion){
					case 0: 	
							columna2=*columna;				
							fila2=*fila-(int)valor;
							break;//norte
					case 64: fila2=*fila;
							columna2=*columna+(int)valor;
							break;//este
					case 128:
							columna2=*columna;
							fila2=*fila+(int)valor;
							break;//sur
					case 192:	
							fila2=*fila;
							columna2=*columna-(int)valor;
							break;//oeste
					default:if(orientacion<64)
							{	
								fila2=*fila-(int)(valor*sin(aux));
								columna2=*columna+(int)(valor*sin(aux));
							}else{
								if(orientacion<128)
								{
									fila2=*fila+(int)(valor*sin(aux));
									columna2=*columna+(int)(valor*sin(aux));	
								}else{
									if (orientacion<192)
									{
										fila2=*fila+(int)(valor*sin(aux));
										columna2=*columna-(int)(valor*sin(aux));
									}else{
										fila2=*fila-(int)(valor*sin(aux));
										columna2=*columna-(int)(valor*sin(aux));
									}
								}
							}break;
				};
				
				if(lapiz==1){	
					linea(*columna,*fila,columna2,fila2,R,G,B);
				}
				*columna=columna2;
				*fila=fila2;
				
				if(oculta==0){
					pon_tortuga(*columna,*fila,orientacion);
				}
				if(modo)readkey();
}

void cmdRetrocede(int *columna,int *fila,int valor, int lapiz, int oculta, int orientacion,int R, int G, int B,int modo){

	if(oculta==0){
					borra_tortuga(*columna,*fila);
				}
			
				int columna2;
				int fila2;
				int aux=(orientacion*360)/256;
				while(aux>90){
					aux=aux-90;
				}
				aux=90-aux;
				switch(orientacion){
					case 128: 	
							columna2=*columna;				
							fila2=*fila-(int)valor;
							break;//norte
					case 192: fila2=*fila;
							columna2=*columna+(int)valor;
							break;//este
					case 0:
							columna2=*columna;
							fila2=*fila+(int)valor;
							break;//sur
					case 64:	
							fila2=*fila;
							columna2=*columna-(int)valor;
							break;//oeste
					default:if(orientacion<64)
							{	
								fila2=*fila-(int)(valor*sin(aux));
								columna2=*columna+(int)valor*cos(aux);
							}else{
								if(orientacion<128)
								{
									fila2=*fila-(int)(valor*sin(aux));
									columna2=*columna-(int)valor*cos(aux);	
								}else{
									if (orientacion<192)
									{
										fila2=*fila-(int)(valor*sin(aux));
										columna2=*columna+(int)valor*cos(aux);
									}else{
										fila2=*fila+(int)(valor*sin(aux));
										columna2=*columna-(int)valor*cos(aux);
									}
								}
							}break;
				};
				
				if(lapiz==1){	
					linea(*columna,*fila,columna2,fila2,R,G,B);
				}
				*columna=columna2;
				*fila=fila2;	
				
				if(oculta==0){
					pon_tortuga(*columna,*fila,orientacion);
				}
				if(modo)readkey();
}

void cmdGiraDerecha(int columna,int fila,int valor, int oculta, int *orientacion,int modo){

	if(oculta==0){
		borra_tortuga(columna,fila);
	}
	
	int aux;
	aux=(valor*256)/360;
	*orientacion=(*orientacion+aux);
	while(*orientacion>=256){
		*orientacion=*orientacion-256;
	}
	printf("orientacion: %d\n",*orientacion);
	if(oculta==0){
		pon_tortuga(columna,fila,*orientacion);
	}
	if(modo)readkey();

}

void cmdGiraIzquierda(int columna,int fila,int valor, int oculta, int *orientacion,int modo){

	if(oculta==0){
		borra_tortuga(columna,fila);
	}
	int aux;
	aux=(valor*256)/360;
	*orientacion=(*orientacion-aux);
	while(*orientacion<0){
		*orientacion=*orientacion+256;
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

void cmdHaz(char par1[],char par2[],int esvar, int tipodato,simbolo sim[]){
	printf("Inserto simbolo %s con valor %s\n",par1,par2);
							simbolo aux;
   							tipoValor valor;
   							char nombre[100];

   							switch(tipodato){
   								case 1: 
   										//TODO aqui ver si esvar es 1, entonces obtener el simbolo
   										//y si no lo que estaba puesto antes
   										strcpy(nombre,par1);
   										if(esvar==1){
   											if(existeSimbolo(sim,par2)==1)
											{
													aux=obtenerSimbolo(sim,par2);
													valor.entero=aux.valor.entero;
													insertarSimbolo( sim,par1,1, valor);
											}
											else
											{
												printf("La variable %s no tiene valor\n",par2);
											}
   										}
   										else
   										{
   											valor.entero=atoi(par2);
	   										insertarSimbolo( sim,par1,1, valor);
   										}
   										
   										break;	
   								case 2: strcpy(nombre,par1);
   										if(esvar==1){
   											if(existeSimbolo(sim,par2)==1)
											{
													aux=obtenerSimbolo(sim,par2);
													valor.real=aux.valor.real;
													insertarSimbolo( sim,par1,2, valor);
											}
											else
											{
												printf("La variable %s no tiene valor\n",par2);
											}
   										}
   										else
   										{
   											valor.entero=atof(par2);
	   										insertarSimbolo( sim,par1,2, valor);
   										}
   										break;	
   								case 3: 
   										strcpy(nombre,par1);
   										if(esvar==1){
   											if(existeSimbolo(sim,par2)==1)
											{
													aux=obtenerSimbolo(sim,par2);
													strcpy(valor.cadena,aux.valor.cadena);
													insertarSimbolo( sim,par1,3, valor);
											}
											else
											{
												printf("La variable %s no tiene valor\n",par2);
											}
   										}
   										else
   										{
   											strcpy(valor.cadena,par2);
	   										insertarSimbolo( sim,par1,3, valor);
   										}
   										break;	
   								}
}

void ejecutarBucle(int veces,instruccion cmd[],int num_cmd,int *columna,int *fila, int *lapiz, int *oculta, int *orientacion,int R, int G, int B,int modo, int tipodato,simbolo sim[]){
	int i=0;
	int j=0;

	//esto se hace porque ya se ha ejecutado una vez
	veces--;

	while(i<num_cmd && j<veces){
		switch(cmd[i].comando){
			case 0: 
					cmdAvanza(columna,fila,cmd[i].parametro1.numero,*lapiz,*oculta,*orientacion,R,G,B,modo);
					break;
			case 1: 
					cmdRetrocede(columna,fila,cmd[i].parametro1.numero,*lapiz,*oculta,*orientacion,R,G,B,modo);
					break;
			case 2:
					cmdGiraDerecha(*columna,*fila,cmd[i].parametro1.numero,*oculta, orientacion,modo);
					break;
			case 3:
					cmdGiraIzquierda(*columna,*fila,cmd[i].parametro1.numero,*oculta, orientacion,modo);
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
						simbolo aux;
						char cad[100];
					
					if(cmd[i].parametro3.numero==1)
					{
						if(existeSimbolo(sim,cmd[i].parametro1.cadena)==1)
						{
							aux=obtenerSimbolo(sim,cmd[i].parametro1.cadena);
							switch(aux.tipo){
								case 1: sprintf(cad,"%d",aux.valor.entero);
										tipodato=1;
										break;
								case 2: sprintf(cad,"%2.8g",aux.valor.real);
										tipodato=2;
										break;
								case 3: strcpy(cad,aux.valor.cadena);
										tipodato=3;
										break;
								default: printf("La variable %s no tiene valor\n",cad); 
										break;
							}
						}
						else
						{
							printf("La variable %s no tiene valor\n", cad);
						}
					}
					muestra_mensaje(cad);if(modo)readkey();
					break;
			case 9:
					cmdHaz(cmd[i].parametro1.cadena,cmd[i].parametro2.cadena,(int)cmd[i].parametro3.numero,tipodato,sim);if(modo)readkey();
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
		cmd[i].parametro1.numero=-1;
		cmd[i].parametro2.numero=-1;
		strcpy(cmd[i].parametro1.cadena,"");
		strcpy(cmd[i].parametro2.cadena,"");
		cmd[i].parametro3.numero=-1;
		strcpy(cmd[i].parametro3.cadena,"");
	}

}

void cmdBorrarPantalla(int modo){
	borra_pantalla();
    pon_tortuga(400,300,0);
	if(modo)readkey();
}
