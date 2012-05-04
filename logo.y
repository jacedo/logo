%{
/* Intérprete para una versión sencilla de Logo */
/*Julio Acedo Durán*/
/*Héctor Molano Macías*/

#include <stdio.h>
#include <string.h>
#include <math.h>
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

int tipoexp=0;  //2 si el logica

//vector de comandos
instruccion cmd[MAXCMD];
int contador_cmd=0;


int bucle=0;



//extern FILE * yyout;
extern FILE *yyin;

//void yyerror(FILE * yyout,const char * );
void yyerror(const char *);
%}

%union {
	int c_entero;
	float c_real;
	char c_cadena[100];
}

%token AV RE GD GI BL SL MT OT ES 
%token REPITE ESCRIBE
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




//utilizado para pasarselo a yyparse()
//%parse-param {FILE * yyout}

%%

entrada:linea
	|entrada linea
	;
linea: 	'\n'
    	|comandos '\n'
    	|error '\n' {yyerrok;}
	 ;

comandos:comando
	|comandos comando
			;

expr: 	N_ENTERO							{$$ = $1;}
		| N_REAL			      			{$$ = $1;}
       	| '-' expr  %prec MENOSUNARIO  		{$$ = - $2;}
       	| expr '+' expr                		{$$ = $1 + $3;}
       	| expr '-' expr                		{$$ = $1 - $3;}
       	| expr '*' expr                		{$$ = $1 * $3;printf("Multiplacion %.8g\n",$$ );}
       	| expr '/' expr						{$$ = $1 / $3;}
		| '(' expr ')'		      			{$$ = ( $2 );}
	 ;

exprlog: '(' exprlog ')' 		  { $$ = $2; }
	   | expr '<' expr		      { if($1 < $3) $$ = 1; else $$ = 0;}
       | expr '>' expr		      { if($1 > $3) $$ = 1; else $$ = 0;}
       | expr '<''=' expr	      { if($1 <= $4) $$ = 1; else $$ = 0;}
       | expr '>''=' expr	      { if($1 >= $4) $$ = 1; else $$ = 0;}
       | expr '!''=' expr	      { if($1 != $4) $$ = 1; else $$ = 0;}
       | expr '=' expr	      	  { if($1 == $3) $$ = 1; else $$ = 0;}
       | 'n''o' exprlog		      { if($3) $$ = 0; else $$ = 1;}
       | exprlog '&' exprlog	  { if($1 && $3) $$ = 1; else $$ = 0;}
       | exprlog 'o' exprlog	  { if($1 || $3) $$ = 1; else $$ = 0;}
	;

dato:expr        	{sprintf($$,"%.8g\n",$1);
					}
	|exprlog		{	if($1==0){
							strcpy($$,"falso");
						}else{
							strcpy($$,"cierto");	
						}
					}
	|CADENA    		{strcpy($$,$1);
					}
	;

comando: AV expr 	{
						if(bucle==1){
							cmd[contador_cmd].comando=0;
							cmd[contador_cmd].parametro.numero=$2;
							contador_cmd++;
						}
						cmdAvanza(&columna,&fila,$2,lapiz,oculta,orientacion);}
	|RE expr 		{
						if(bucle==1){
							cmd[contador_cmd].comando=1;
							cmd[contador_cmd].parametro.numero=$2;
							contador_cmd++;
						}
						cmdRetrocede(&columna,&fila,$2,lapiz,oculta,orientacion);}
	|GD expr 		{
						if(bucle==1){
							cmd[contador_cmd].comando=2;
							cmd[contador_cmd].parametro.numero=$2;
							contador_cmd++;
						}
						cmdGiraDerecha(columna,fila,$2,oculta, &orientacion);}
	|GI expr 		{
						if(bucle==1){
							cmd[contador_cmd].comando=3;
							cmd[contador_cmd].parametro.numero=$2;
							contador_cmd++;
						}
						cmdGiraIzquierda(columna,fila,$2,oculta, &orientacion);}
	|BL				{
						if(bucle==1){
							cmd[contador_cmd].comando=4;
							contador_cmd++;
						}
						cmdBajaLapiz(&lapiz);}
	|SL				{
						if(bucle==1){
							cmd[contador_cmd].comando=5;
							contador_cmd++;
						}
						cmdSubeLapiz(&lapiz);}
	|MT				{
						if(bucle==1){
							cmd[contador_cmd].comando=6;
							contador_cmd++;
						}
						cmdMuestraTortuga(columna,fila,orientacion, &oculta);}
   	|OT				{
   						if(bucle==1){
							cmd[contador_cmd].comando=7;
							contador_cmd++;
						}
   						cmdOcultaTortuga(columna,fila,orientacion, &oculta);} 
	|REPITE expr '[' {	printf("repite %d\n",(int)$2);bucle=1;} comandos ']' {bucle=0;
						ejecutarBucle((int)$2,cmd,contador_cmd,&columna,&fila,&lapiz,&oculta,&orientacion);
						reinicilizaCmd(cmd,&contador_cmd);
					}
	|REPITE N_REAL 	{yyerrok;} 
   	|ESCRIBE dato {	if(bucle==1){
							cmd[contador_cmd].comando=8;
							strcpy(cmd[contador_cmd].parametro.cadena,$2);
							contador_cmd++;
						}
						printf("Va a escribir %s\n", $2);
   					muestra_mensaje($2);readkey();}
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
    // y le concateno el .cpp, queda pruebaX.cpp
    strcat(nombre_cpp,".cpp");
	
//	yyout=fopen(nombre_cpp,"wt");
	yyin=fopen(nombre_lgo,"rt");
		

    cmdInicio();
    //inicializamos allegro
   // inicio();
    


  //  yyparse(yyout);
  	  yyparse();

    cmdFin();


   // printf("Generando la salida.Pulse una tecla para continuar...\n");
    //getchar();
     
	fclose(yyin);
//	fclose(yyout);

	if (error == 1){
		remove(nombre_cpp);
		printf("Archivo de salida eliminado por errores de sintaxis\n");
	}  
	else{
		printf("Archvo de salida generado correctamente\n");
	}  

 	return 0;
}



//void yyerror(FILE * yyout, const char *s )             /* llamada por error sintactico de yacc */
void yyerror( const char *s)
{
	printf("\nError sintáctico en la línea %d\n",numlinea );
	error = 1;	
}



