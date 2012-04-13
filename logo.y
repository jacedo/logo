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

FILE * yyout;

extern FILE *yyin;

void yyerror(FILE * yyout,const char * );
%}



%union {
	int c_entero;
	float c_real;
}

%token AV RE GD GI BL SL MT OT ES
%token <c_entero> N_ENTERO 
%token <c_real> N_REAL 


%parse-param {FILE * yyout}

%%

entrada: 	{
			
		}	
     |entrada linea   
      ;
      
linea: 	'\n'
		|'\t'
      	|comandos '\n'
      	|comandos '\t'
		|linea comandos
      	|error '\n' {yyerrok;}
	 ;

comandos:comando
	//|comandos comando
			;
        	    
comando: AV N_ENTERO 	{
				if(oculta==0){
					fprintf(yyout,"borra_tortuga(%d,%d);\n",columna,fila);
				}
				if(lapiz==1){
					/*if(orientacion==0){
						fprintf(yyout,"linea(%d,%d,%d,%d);\n",columna,fila,columna,fila+$2);
						fila=fila-$2;
					}*/
					switch(orientacion){

						case 0:	fprintf(yyout,"linea(%d,%d,%d,%d);\n",columna,fila,columna,fila-$2);
								fila=fila-$2;
								break;//norte
						case 1: 	fprintf(yyout,"linea(%d,%d,%d,%d);\n",columna,fila,columna+$2,fila);
								columna=columna+$2;
								break;//este
						case 2: 	fprintf(yyout,"linea(%d,%d,%d,%d);\n",columna,fila,columna,fila+$2);
								fila=fila+$2;
								break;//sur
						case 3:		fprintf(yyout,"linea(%d,%d,%d,%d);\n",columna,fila,columna-$2,fila);
								columna=columna-$2;
								break;//oeste
					};
					
				}
				
				if(oculta==0){
					fprintf(yyout,"pon_tortuga(%d,%d,%d)\n",columna,fila,orientacion);
				}
				fprintf(yyout,"readkey();\n\n");
			
			}
	|RE N_ENTERO 	{
				if(oculta==0){
					fprintf(yyout,"borra_tortuga(%d,%d);\n",columna,fila);
				}
				if(lapiz==1){
					switch(orientacion){
						case 0:		fprintf(yyout,"linea(%d,%d,%d,%d);\n",columna,fila,columna,fila-$2);
								fila=fila-$2;
								break;//norte
						case 1: 	fprintf(yyout,"linea(%d,%d,%d,%d);\n",columna,fila,columna,fila+$2);
								fila=fila+$2;
								break;//este
						case 2: 	fprintf(yyout,"linea(%d,%d,%d,%d);\n",columna,fila,columna+$2,fila);
								columna=columna+$2;
								break;//sur
						case 3:		fprintf(yyout,"linea(%d,%d,%d,%d);\n",columna,fila,columna-$2,fila);
								columna=columna-$2;
								break;//oeste
					};
					
				}
				
				if(oculta==0){
					fprintf(yyout,"pon_tortuga(%d,%d,%d)\n",columna,fila,orientacion);
				}
				fprintf(yyout,"readkey();\n\n");
			}
	|GD N_ENTERO 	{	
				if(oculta==0){
					fprintf(yyout,"borra_tortuga(%d,%d);\n",columna,fila);
				}
				orientacion=(orientacion+($2/90))%4;
				if(oculta==0){
					fprintf(yyout,"pon_tortuga(%d,%d,%d)\n",columna,fila,orientacion);
				}
				fprintf(yyout,"readkey();\n\n");
			}
	|GI N_ENTERO 	{	if(oculta==0){
					fprintf(yyout,"borra_tortuga(%d,%d);\n",columna,fila);
				}
				orientacion=(orientacion+($2/90))%4;
				if(orientacion<0){
					orientacion=orientacion+4;
				}
				if(oculta==0){
					fprintf(yyout,"pon_tortuga(%d,%d,%d)\n",columna,fila,orientacion);
				}
				fprintf(yyout,"readkey();\n\n");
			}
	|BL		{
				lapiz=1;
			}
	|SL		{
				lapiz=0;
			}
	|MT		{	
				fprintf(yyout,"pon_tortuga(%d,%d,%d)\n",columna,fila,orientacion);
				fprintf(yyout,"readkey();\n\n");				
				oculta=0;
			}
       	|OT		{
				fprintf(yyout,"borra_tortuga(%d,%d);\n",columna,fila);
				fprintf(yyout,"readkey();\n\n");
				oculta=1;
			}       	
       	;

%%



int main( int argc, char **argv )
{
     if (argc !=2){
     	printf("Sintaxis incorrecta\n");
     	return(-1);
     } 
     int nastiness, randomness;
	
	yyout=fopen("prueba.cpp","wt");
	yyin=fopen(argv[1],"rt");

			
     	fprintf(yyout,"#include \"entorno.h\"\n\n");
    	fprintf(yyout,"int main(){\n");
	fprintf(yyout,"inicio();\n");
	fprintf(yyout,"pon_tortuga(400,300,0);\n");
	fprintf(yyout,"readkey();\n\n");

     	yyparse(yyout);

     	fprintf(yyout,"fin();\n");
	fprintf(yyout,"return(0);\n");
    	fprintf(yyout,"}");

     	getchar();

     
	fclose(yyin);
	fclose(yyout);
    
 	return 0;
}



void yyerror(FILE * yyout,const char *s )             /* llamada por error sintactico de yacc */
{
	printf("\nError sintáctico en la línea %d\n",numlinea );
	
}



