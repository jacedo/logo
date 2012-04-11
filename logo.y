

%{
/* Intérprete para una versión sencilla de Logo */

#include <stdio.h>

extern int yylex();
int  numlinea = 1;

int fila=300;

int columna=400;

int orientacion=0; //0:Norte 1:Este 2:Sur 3:Oeste
int lapiz=1;  //true pinta, false no
int oculta=0; //true oculta, false visible


void yyerror(const char * );


%}

%union {
	int c_entero;
	float c_real;
	char c_cadena[50];
}

%token AV RE GD GI BL SL MT OT ES
%token <c_entero> N_ENTERO 
%token <c_real> N_REAL 
%token <c_cadena> CADENA

 


%%
entrada: 	{
			
		}	
     |entrada linea   
      ;
      
linea: 	'\n' 
      	|comandos '\n'
      	|error '\n' {yyerrok;}
	    ;

comandos:comando
		|comandos comando
			;
        	    
comando: AV N_ENTERO 	{
				if(oculta==0){
					//fprintf(yyout,"borra_tortuga(%d,%d);\n",columna,fila);
				}
				if(lapiz==1){
					switch(orientacion){
						case '0':	//fprintf(yyout,"linea(%d,%d,%d,%d);\n",columna,fila,columna,fila+$2);
								fila=fila+$2;
								break;//norte
						case '1': 	//printf(yyout,"linea(%d,%d,%d,%d);\n",columna,fila,columna,fila-$2);
								fila=fila-$2;
								break;//este
						case '2': 	//printf(yyout,"linea(%d,%d,%d,%d);\n",columna,fila,columna-$2,fila);
								columna=columna-$2;
								break;//sur
						case '3':	//printf(yyout,"linea(%d,%d,%d,%d);\n",columna,fila,columna+$2,fila);
								columna=columna+$2;
								break;//oeste
					};
					
				}
				
				if(oculta==0){
					//fprintf(yyout,"pon_tortuga(%d,%d,%d)\n",columna,fila,orientacion);
				}
				//fprintf(yyout,"readkey();\n");
			//	DesplazarTortuga (T,$2);
			
			}
	|RE N_ENTERO 	{
			//	DesplazarTortuga (T,$2);
			}
	|GD N_ENTERO 	{	
			//	CambiarDireccion(T, $2, 0);
			}
	|GI N_ENTERO 	{
			//	CambiarDireccion(T, $2, 1);
			}
	|BL		{
			//	T.lapiz=true;
			}
	|SL		{
			//	T.lapiz=false;
			}
	|MT		{
			//	MostrarTortuga(T);
			}
       	|OT		{
			//	OcultarTortuga(T);
			}       	
       	;

%%



int main( int argc, char **argv )
{
     if (argc !=2){
     	printf("Sintaxis incorrecta\n");
     	return(-1);
     } 
	
	FILE * yyout=fopen("prueba.cpp","wt");
	FILE * yyin=fopen(argv[1],"rt");

			
     	fprintf(yyout,"#include \"entorno.h\"\n\n");
    	fprintf(yyout,"int main(){\n");
	fprintf(yyout,"inicio();\n");
	fprintf(yyout,"pon_tortuga(400,300,0);\n");
	fprintf(yyout,"readkey();\n");


     	yyparse();

     	getchar();
  
     
	fclose(yyin);
	fclose(yyout);
    
 	return 0;
}



void yyerror(const char *s )             /* llamada por error sintactico de yacc */
{
	printf("\nError sintáctico en la línea %s\n",numlinea );
	
}



