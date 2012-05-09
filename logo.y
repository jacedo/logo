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

//parametros para seleccion  de color de la linea 
int R=255;
int G=255;
int B=255;

//vector de comandos
instruccion cmd[MAXCMD];
int contador_cmd=0;

int bucle=0;
int ejecutar=1; 

extern FILE *yyin;

void yyerror(const char *);
%}

%union {
	int c_entero;
	float c_real;
	char c_cadena[100];
}

%token AV RE GD GI BL SL MT OT ES BP PC
%token REPITE ESCRIBE SI
%token <c_entero> N_ENTERO 
%token <c_real> N_REAL 
%token <c_cadena> CADENA

%type <c_cadena> dato
%type <c_entero> exprlog
%type <c_real> expr


%left '+' '-' 
%left '*' '/'  	
%left MENOSUNARIO 
%left '('

%%

entrada:linea 
		|entrada linea
		|'[' {if(ejecutar==2){ejecutar=1;}else{ejecutar=0;}}entrada ']'{ejecutar=1;}
		;
linea: 	'\n' 								{numlinea++;}
    	|comando
    	|error '\n' 						{numlinea++;yyerrok;}
	 	;

expr: 	N_ENTERO							{$$ = $1;}
		|N_REAL			      				{$$ = $1;}
       	|'-' expr  %prec MENOSUNARIO  		{$$ = - $2;}
       	|expr '+' expr                		{$$ = $1 + $3;}
       	|expr '-' expr                		{$$ = $1 - $3;}
       	|expr '*' expr                		{$$ = $1 * $3;}
       	|expr '/' expr						{$$ = $1 / $3;}
		|'(' expr ')'		      			{$$ = ( $2 );}
	 ;

exprlog:'(' exprlog ')' 		  			{ $$ = $2; }
	   |expr '<' expr		      			{ if($1 < $3) $$ = 1; else $$ = 0;}
       |expr '>' expr		      			{ if($1 > $3) $$ = 1; else $$ = 0;}
       |expr '<''=' expr	     			{ if($1 <= $4) $$ = 1; else $$ = 0;}
       |expr '>''=' expr	      			{ if($1 >= $4) $$ = 1; else $$ = 0;}
       |expr '!''=' expr	      			{ if($1 != $4) $$ = 1; else $$ = 0;}
       |expr '=' expr	      	  			{ if($1 == $3) $$ = 1; else $$ = 0;}
       |'n''o' exprlog		      			{ if($3) $$ = 0; else $$ = 1;}
       |exprlog '&' exprlog	  				{ if($1 && $3) $$ = 1; else $$ = 0;}
       |exprlog '|' exprlog	  				{ if($1 || $3) $$ = 1; else $$ = 0;}
	;

dato:expr        							{sprintf($$,"%2.8g",$1);}
		|exprlog							{	if($1==0)
												{
													strcpy($$,"falso");
												}else{
													strcpy($$,"cierto");	
												}
											}
		|CADENA    							{strcpy($$,$1);}
		;

comando: AV expr 	{
					if(ejecutar!=0){
						if(bucle==1){
							cmd[contador_cmd].comando=0;
							cmd[contador_cmd].parametro.numero=$2;
							contador_cmd++;
						}
						cmdAvanza(&columna,&fila,$2,lapiz,oculta,orientacion,R,G,B);}
					}
	|RE expr 		{
					if(ejecutar!=0){
						if(bucle==1){
							cmd[contador_cmd].comando=1;
							cmd[contador_cmd].parametro.numero=$2;
							contador_cmd++;
						}
						cmdRetrocede(&columna,&fila,$2,lapiz,oculta,orientacion,R,G,B);}
					}
	|GD expr 		{
					if(ejecutar!=0){
						if(bucle==1){
							cmd[contador_cmd].comando=2;
							cmd[contador_cmd].parametro.numero=$2;
							contador_cmd++;
						}
						cmdGiraDerecha(columna,fila,$2,oculta, &orientacion);}
					}
	|GI expr 		{
					if(ejecutar!=0){
						if(bucle==1){
							cmd[contador_cmd].comando=3;
							cmd[contador_cmd].parametro.numero=$2;
							contador_cmd++;
						}
						cmdGiraIzquierda(columna,fila,$2,oculta, &orientacion);}
					}
	|BL				{
					if(ejecutar!=0){
						if(bucle==1){
							cmd[contador_cmd].comando=4;
							contador_cmd++;
						}
						cmdBajaLapiz(&lapiz);}
					}
	|SL				{
					if(ejecutar!=0){
						if(bucle==1){
							cmd[contador_cmd].comando=5;
							contador_cmd++;
						}
						cmdSubeLapiz(&lapiz);}
					}
	|MT				{
					if(ejecutar!=0){
						if(bucle==1){
							cmd[contador_cmd].comando=6;
							contador_cmd++;
						}
						cmdMuestraTortuga(columna,fila,orientacion, &oculta);}
					}
   	|OT				{
   					if(ejecutar!=0){
   						if(bucle==1){
							cmd[contador_cmd].comando=7;
							contador_cmd++;
						}
   						cmdOcultaTortuga(columna,fila,orientacion, &oculta);
   					} 
   					}
   	|BP 			{
   					if(ejecutar!=0){
   						printf("voy a llamar a la funcion de cmdBorrarPantalla");
   						cmdBorrarPantalla();
   						fila=300;
						columna=400;
						orientacion=0; 
						lapiz=1;  
						oculta=0; 
					}

   					}
   	|PC N_ENTERO	{
   					if(ejecutar!=0){
   						switch((int)$2){
   							case 0: R=0; 	G=0; 	B=0; break;//negro
   							case 1: R=255; 	G=0; 	B=0; 	break;//rojo
   							case 2: R=0; 	G=128; 	B=0; 	break;//verde
   							case 3: R=255; 	G=255; 	B=0; 	break;//amarillo
   							case 4: R=0; 	G=0; 	B=139;	break;//azul oscuro
   							case 5: R=255; 	G=192; 	B=203;	break;//rosa
   							case 6: R=173; 	G=216; 	B=230;	break;//azul claro
   							case 7: R=255; 	G=255; 	B=255;	break;//blanco
   							case 8: R=128; 	G=128; 	B=128;	break;//gris
   						}	
   					}

   					}

	|REPITE expr'[' {bucle=1;} entrada ']' {bucle=0;
						
						if(ejecutar!=0){ejecutarBucle((int)$2,cmd,contador_cmd,&columna,&fila,&lapiz,&oculta,&orientacion,R,G,B);
						reinicilizaCmd(cmd,&contador_cmd);}
					}
	
	|SI exprlog {if(ejecutar!=0){
						if($2==0){
							ejecutar=0;
						}
					}
				}'['entrada']'{
					if(ejecutar==0){
						ejecutar=2;
					}else{
						ejecutar=1;
					}
				} entrada

   	|ESCRIBE dato {	if(ejecutar!=0){
   						if(bucle==1){
							cmd[contador_cmd].comando=8;
							strcpy(cmd[contador_cmd].parametro.cadena,$2);
							contador_cmd++;
						}
   						muestra_mensaje($2);readkey();}
   					}
   	;


%%


int main( int argc, char **argv )
{
    char nombre_lgo[50];

     if (argc !=2){
     	printf("Sintaxis incorrecta\n");
     	return(-1);
     }    

    strcpy(nombre_lgo,argv[1]);

	yyin=fopen(nombre_lgo,"rt");
		

    cmdInicio();
    
	yyparse();

    cmdFin();
     
	fclose(yyin);

	if (error == 1){
		printf("\033[1m \033[31m\nScript logo ejecutado CON errores\n");
	}  
	else{
		printf("\033[1m \033[32m\nScript logo ejecutado SIN errores\n");
	} 

	printf("\033[22m \033[30m");
 	return 0;
}

void yyerror( const char *s)
{
	printf("\033[1m\033[31m\n¡ERROR sintáctico en la línea %d!\n",numlinea);
	printf("\033[22m \033[30m");
	error = 1;	
}



