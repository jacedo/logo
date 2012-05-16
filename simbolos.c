#include "simbolos.h"


void inicializarSimbolos(simbolo sim[])
{
	int i;
	for (i=0;i<TAM;i++){
		strcpy(sim[i].nombre," ");
		sim[i].tipo=-1;
		sim[i].valor.entero=0;
		sim[i].valor.real=0;
		strcpy(sim[i].valor.cadena,"");
	}
}


void insertarSimbolo(simbolo sim[],char _nombre[],int _tipo, tipoValor  _valor)
{
	int i=0;
	int encontrado=0;
	int vacio=0;
	int pos=0;


	for(i=0;i<TAM && encontrado==0 && vacio==0;i++){
		if(sim[i].tipo==-1){
			vacio=1;
			pos=i;
		} 
		if(strcmp(sim[i].nombre,_nombre)==0){
			encontrado=1;	
			pos=i;
		} 
	}

	
	normalizarNombre(_nombre);
	strcpy(sim[pos].nombre,_nombre);
	sim[pos].tipo=_tipo;
	//1 entero
	//2 real
	//3 cadena
	switch(_tipo){
		case 1:	sim[pos].valor.entero=_valor.entero;
				printf("Inserto %s de tipo %d con valor %d en %d\n", sim[pos].nombre,sim[pos].tipo,sim[pos].valor.entero,pos);
				break;
		case 2: sim[pos].valor.real=_valor.real;
				printf("Inserto %s de tipo %d con valor %f en %d\n", sim[pos].nombre,sim[pos].tipo,sim[pos].valor.real,pos);
				break;
		case 3: strcpy(sim[pos].valor.cadena,_valor.cadena);
				printf("Inserto %s de tipo %d con valor %s en %d\n", sim[pos].nombre,sim[pos].tipo,sim[pos].valor.cadena,pos);
				break;
	}

	
	// getchar();

}


void mostrarSimbolos(simbolo sim[])
{
	int i=0;

	printf("\n=================TABLA DE SIMBOLOS=============\n");

	for(i=0;i<TAM;i++){
			
					if(sim[i].tipo==1){
							printf("La variable %s es de tipo entero y tiene el valor %d\n", sim[i].nombre, sim[i].valor.entero);
					}
					if(sim[i].tipo==2){
							printf("La variable %s es de tipo float y tiene el valor %.8g\n", sim[i].nombre, sim[i].valor.real);
					}
					if(sim[i].tipo==3){
							printf("La variable %s es de tipo cadena y tiene el valor %s\n",	 sim[i].nombre, sim[i].valor.cadena);
					}
	}
}

simbolo obtenerSimbolo(simbolo sim[],char _nombre[]){
	
	int i=0;
	normalizarNombre(_nombre);
	for(i=0;i<TAM;i++){
		if(sim[i].tipo==-1) return sim[i];			
		if(strcmp(sim[i].nombre,_nombre)==0) return sim[i];
	}
}


int existeSimbolo(simbolo sim[],char _nombre[]){
	int i=0;
	normalizarNombre(_nombre);
	 for(i=0;i<TAM;i++){
				
		if(strcmp(sim[i].nombre,_nombre)==0) return 1;
	}
	return 0;
}


void normalizarNombre(char nombre[100]){
	int i;
	for (int i = 0; i < strlen(nombre); ++i)
	{	
		nombre[i]=tolower(nombre[i]);
	}
}
