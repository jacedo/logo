

%{
/* Intérprete para una versión sencilla de Logo */

#include <stdio.h>

extern int yylex();
int  numlinea = 1;

void yyerror(const char * );


%}
%union{
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
				//TODO : aqui se abre el fichero prueba.lgo
				//(que vendra por el 2º argumento al ejecutar)
				//y escribe en prueba.cpp:
				//#include "Entorno.h"
				//int main(){
				//  inicio();
				 // pon_tortuga(400,300,0);
				  //readkey();

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
        	    
comando: AV N_ENTERO {//aqui escribe(teniendo en cuenta el valoe de N_ENTERO):
				//borra_tortuga(400,300);
				  //linea(400,300,400,200);
				  	//pon_tortuga(400,200,0);
				  //readkey();
	}
		|RE N_ENTERO 		{}
		|GD N_ENTERO {}
		|GI N_ENTERO {}
		|BL				{}
		|SL			{}
		|MT			{}
       	|OT			{}       	
       	;

%%



int main( int argc, char **argv )
{
     if (argc !=3){
     	printf("Sintaxis incorrecta\n");
     	exit(-1);
     } 

     printf("\n****************************************************\n");
     printf("*      Este es un compilador del lenguaje  *\n");  
     printf("*        LOGO     *\n");
     printf("****************************************************\n\n\n");
     yyparse();

     printf("\n\nPulse una tecla para salir...\n");
     getchar();
     printf("\n****************************************************\n");
     printf("*       LOGO es un lenguaje sencillo               *\n");
     printf("*                                                  *\n");
     printf("*       ya hemos terminado -- ADIOS!!!!            *\n");
     printf("****************************************************\n");
     
     return 0;
}



void yyerror(const char *s )             /* llamada por error sintactico de yacc */
{
	printf("\nError sintáctico en la línea %s\n",numlinea );
	
}



