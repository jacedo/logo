%{
/* Intérprete para una versión sencilla de Logo */
/*Julio Acedo Durán*/
/*Héctor Molano Macías*/

#include <stdio.h>
#include <string.h>
#include "Entorno.h"
#include "bucle.h"

extern int yylex();

int numlinea = 1;
int error = 0;
int fila=300;
int columna=400;
int orientacion=0; //0:Norte 1:Este 2:Sur 3:Oeste
int lapiz=1;  //true pinta, false no
int oculta=0; //true oculta, false visible

//vector de comandos
instruccion cmd[100];


int bucle=0;



extern FILE * yyout;
extern FILE *yyin;

void yyerror(FILE * yyout,const char * );

%}

%union {
	int c_entero;
	float c_real;
}

%token AV RE GD GI BL SL MT OT ES 
%token REPITE
%token <c_entero> N_ENTERO 
%token <c_real> N_REAL 

%type <c_real> expr

%left '+' '-' 
%left '*' '/'  	
%left MENOSUNARIO 
%left '(' 




//utilizado para pasarselo a yyparse()
%parse-param {FILE * yyout}

%%

entrada:linea
	|entrada linea   
      ;
      
bloque:linea 
	|bloque linea
	;
linea: 	'\n'
	|'\t'
    	|comandos '\n'
    	|comandos '\t'	
    	|error '\n' {yyerrok;}
	 ;

comandos:comando
	|comandos comando
			;

expr: 	N_ENTERO				{$$ = $1;}
	| N_REAL			      	{$$ = $1;}
       	| '-' expr  %prec MENOSUNARIO  		{$$ = - $2;}
       	| expr '+' expr                		{$$ = $1 + $3;}
       	| expr '-' expr                		{$$ = $1 - $3;}
       	| expr '*' expr                		{$$ = $1 * $3;}
       	| expr '/' expr				{$$ = $1 / $3;}
	| '(' expr ')'		      		{$$ = ( $2 );}
        ;	    

comando: AV expr 	{
				
				cmdAvanza(yyout,&columna,&fila,$2,lapiz,oculta,orientacion);
			
			}
	|RE expr 	{
				cmdRetrocede(yyout,&columna,&fila,$2,lapiz,oculta,orientacion);
			}
	|GD expr 	{	
				if(oculta==0){
					fprintf(yyout,"borra_tortuga(%d,%d);\n",columna,fila);
				}
				orientacion=(orientacion+((int)$2/90))%4;
				if(oculta==0){
					fprintf(yyout,"pon_tortuga(%d,%d,%d)\n",columna,fila,orientacion);
				}
				fprintf(yyout,"readkey();\n\n");
			}
	|GI expr 	{	
				if(oculta==0){
					fprintf(yyout,"borra_tortuga(%d,%d);\n",columna,fila);
				}
				orientacion=(orientacion+(int)($2/90))%4;
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
	|REPITE N_ENTERO '[' {	printf("repite %d\n",(int)$2);bucle=1;}  bloque ']' {bucle=0;}      	
   	;





%%



int main( int argc, char **argv )
{
	char nombre_cpp[50];
    char nombre_lgo[50];

     if (argc !=2){
     	printf("Sintaxis incorrecta\n");
     	return(-1);
     }    

    // copio primero, porque strtok modifica argv[1] 
    strcpy(nombre_lgo,argv[1]);
    // separo por el punto, queda pruebaX
    strcpy(nombre_cpp,strtok(argv[1],"."));

    //printf("%s\n", nombre_cpp);
    // y le concateno el .cpp, queda pruebaX.cpp
    strcat(nombre_cpp,".cpp");

	//printf("%s\n", nombre_cpp);	
	yyout=fopen(nombre_cpp,"wt");
	//printf("%s\n",nombre_lgo );
	yyin=fopen(nombre_lgo,"rt");
			
    fprintf(yyout,"#include \"entorno.h\"\n\n");
    fprintf(yyout,"int main(){\n");
	fprintf(yyout,"inicio();\n");
	fprintf(yyout,"pon_tortuga(400,300,0);\n");
	fprintf(yyout,"readkey();\n\n");

    yyparse(yyout);

    fprintf(yyout,"fin();\n");
	fprintf(yyout,"return(0);\n");
    fprintf(yyout,"}\n");

    printf("Generando la salida.Pulse una tecla para continuar...\n");
    getchar();
     
	fclose(yyin);
	fclose(yyout);

	if (error == 1){
		remove(nombre_cpp);
		printf("Archivo de salida eliminado por errores de sintaxis\n");
	}  
	else{
		printf("Archvo de salida generado correctamente\n");
	}  

 	return 0;
}



void yyerror(FILE * yyout,const char *s )             /* llamada por error sintactico de yacc */
{
	
	printf("\nError sintáctico en la línea %d\n",numlinea );
	error = 1;
	
}



