%{
/* Intérprete para una versión sencilla de Logo */
/*Julio Acedo Durán*/
/*Héctor Molano Macías*/

#include <stdio.h>
#include <string.h>
#include "simbolos.h"
#include "Entorno.h"

#include "comandos.h"


extern int yylex();

 simbolo sim[TAM];

simbolo aux;
tipoValor valor;
int esdatovar;
char nombrevar[100];

char cad[100];

//variable para saber el tipo de la variable $$ en dato:
//1-entero;2-real;3-cadena;4-exprlog
int tipodato;

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

//fichero (1) o consola (0)
int modo;

void prompt(void);
void yyerror(const char *);
%}

%union {
	int c_entero;
	float c_real;
	char c_cadena[100];
}

%token SALIR
%token AV RE GD GI BL SL MT OT BP PC
%token NO
%token REPITE ESCRIBE SI HAZ
%token <c_entero> N_ENTERO 
%token <c_real> N_REAL 
%token <c_cadena> CADENA
%token <c_cadena> ASIG_IDENT
%token <c_cadena> RECUP_IDENT

%type <c_cadena> dato
%type <c_entero> exprlog
%type <c_real> expr


%left '+' '-' 
%left '*' '/'  	
%left MENOSUNARIO 
%left '('

%%

entrada:{}
		|entrada linea
		|'[' {if(ejecutar==2){ejecutar=1;}else{ejecutar=0;}}entrada ']'{ejecutar=1;}
		;
linea: 	'\n' 								{numlinea++;if(modo==0) prompt();}
    	|comando							
    	|error '\n' 						{numlinea++;yyerrok;}
    	|SALIR '\n'							{return(0);}
	 	;


expr: 	N_ENTERO							{$$ = $1;tipodato=1;}
		|N_REAL			      				{$$ = $1;tipodato=2;}
       	|'-' expr  %prec MENOSUNARIO  		{$$ = - $2;}
       	|expr '+' expr                		{$$ = $1 + $3;}
       	|expr '-' expr                		{$$ = $1 - $3;}
       	|expr '*' expr                		{$$ = $1 * $3;}
       	|expr '/' expr						{$$ = $1 / $3;}
		|'(' expr ')'		      			{$$ = ( $2 );}
		|RECUP_IDENT						{
												if(tipodato==1)
												{
													$$ = (obtenerSimbolo(sim,$1)).valor.entero;
												}else
												{
													if(tipodato==2)
													{
														$$ = (obtenerSimbolo(sim,$1)).valor.real;
													}else{
														strcpy(cad,(obtenerSimbolo(sim,$1)).valor.cadena);
													}
												}
											}
	 ;

exprlog:'(' exprlog ')' 		  			{ $$ = ( $2 ); }
	   |expr '<' expr		      			{ if($1 < $3) $$ = 1; else $$ = 0;}
       |expr '>' expr		      			{ if($1 > $3) $$ = 1; else $$ = 0;}
       |expr '<''=' expr	     			{ if($1 <= $4) $$ = 1; else $$ = 0;}
       |expr '>''=' expr	      			{ if($1 >= $4) $$ = 1; else $$ = 0;}
       |expr '!''=' expr	      			{ if($1 != $4) $$ = 1; else $$ = 0;}
       |expr '=' expr	      	  			{ if($1 == $3) $$ = 1; else $$ = 0;}
       |NO exprlog		      			{ if($2 == 1) $$ = 0; else $$ = 1;}
       |exprlog '&' exprlog	  				{ if($1 && $3) $$ = 1; else $$ = 0;}
       |exprlog '|' exprlog	  				{ if($1 || $3) $$ = 1; else $$ = 0;}
	;

dato:expr        							{	if(tipodato==3){
                                                  	strcpy($$,cad);
												}else{
													esdatovar=0;sprintf($$,"%2.8g",$1);
												}
											}
		|exprlog							{	
												esdatovar=0;
												tipodato=4;
												if($1==0)
												{
													strcpy($$,"falso");
												}else{
													strcpy($$,"cierto");	
												}
											}
		|CADENA    							{esdatovar=0;strcpy($$,$1);tipodato=3;}
		
		;

comando: AV expr 	{
					if(ejecutar!=0){
						if(bucle==1){
							cmd[contador_cmd].comando=0;
							cmd[contador_cmd].parametro1.numero=$2;
							contador_cmd++;
						}
						cmdAvanza(&columna,&fila,$2,lapiz,oculta,orientacion,R,G,B,modo);}
					}
	|RE expr 		{
					if(ejecutar!=0){
						if(bucle==1){
							cmd[contador_cmd].comando=1;
							cmd[contador_cmd].parametro1.numero=$2;
							contador_cmd++;
						}
						cmdRetrocede(&columna,&fila,$2,lapiz,oculta,orientacion,R,G,B,modo);}
					}
	|GD expr 		{
					if(ejecutar!=0){
						if(bucle==1){
							cmd[contador_cmd].comando=2;
							cmd[contador_cmd].parametro1.numero=$2;
							contador_cmd++;
						}
						cmdGiraDerecha(columna,fila,$2,oculta, &orientacion,modo);}
					}
	|GI expr 		{
					if(ejecutar!=0){
						if(bucle==1){
							cmd[contador_cmd].comando=3;
							cmd[contador_cmd].parametro1.numero=$2;
							contador_cmd++;
						}
						cmdGiraIzquierda(columna,fila,$2,oculta, &orientacion,modo);}
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
						cmdMuestraTortuga(columna,fila,orientacion, &oculta,modo);}
					}
   	|OT				{
   					if(ejecutar!=0){
   						if(bucle==1){
							cmd[contador_cmd].comando=7;
							contador_cmd++;
						}
   						cmdOcultaTortuga(columna,fila,orientacion, &oculta,modo);
   					} 
   					}
   	|BP 			{
   					if(ejecutar!=0){
   						//printf("voy a llamar a la funcion de cmdBorrarPantalla\n");
   						cmdBorrarPantalla(modo);
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

	|REPITE expr'[' {if(tipodato==2){ejecutar=0;error=1;yyerrok;printf("\033[1m\033[31m\n%2.8g no es un numero entero!\n",$2);
	printf("\033[22m \033[30m");}else{ bucle=1;}} entrada ']' {ejecutar=1;bucle=0;
						
						if(ejecutar!=0){ejecutarBucle((int)$2,cmd,contador_cmd,&columna,&fila,&lapiz,&oculta,&orientacion,R,G,B,modo,tipodato,sim);
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
							if(esdatovar==1){
								strcpy(cmd[contador_cmd].parametro1.cadena,nombrevar);
								cmd[contador_cmd].parametro3.numero=1;
							}
							else
							{
							strcpy(cmd[contador_cmd].parametro1.cadena,$2);
						}
							contador_cmd++;
						}
   						muestra_mensaje($2);if(modo!=0) readkey();}
   					}
   							 
   	|HAZ ASIG_IDENT dato     {
   								if(bucle==1){
   									cmd[contador_cmd].comando=9;
									strcpy(cmd[contador_cmd].parametro1.cadena,$2);
									if(esdatovar==1){	
										strcpy(cmd[contador_cmd].parametro2.cadena,nombrevar);
										cmd[contador_cmd].parametro3.numero=1;
									}else{
										strcpy(cmd[contador_cmd].parametro2.cadena,$3);	
									}
							
							contador_cmd++;
   								}

   								printf("Inserto simbolo %s con valor %s\n",$2,$3);
   							tipoValor valor;
   							char nombre[100];
   							switch(tipodato){
   								case 1: valor.entero=atoi($3);
   										strcpy(nombre,$2);
   										insertarSimbolo( sim,$2,1, valor);
   										break;	
   								case 2: valor.real=atof($3);
   										strcpy(nombre,$2);
   										insertarSimbolo( sim,$2,2, valor);
   										break;	
   								case 3: strcpy(valor.cadena,$3);
   										strcpy(nombre,$2);
   										insertarSimbolo( sim,$2,3, valor);
   										break;	
   							}
   							}				
   	;


%%


int main( int argc, char **argv )
{
    char nombre_lgo[50];

     if (argc >2){
     	printf("Sintaxis incorrecta\n");
     	return(-1);
     }   

    inicializarSimbolos(sim);

    //esto simplemente para probar si es capaz de recuperar bien los valores de las variables
    //luego hay que quitarlo
    //entero
    tipoValor  valor;
    valor.entero=56;
    char nombre[50];
    strcpy(nombre,"a");
    insertarSimbolo(sim,nombre,1, valor);
    //real
    valor.entero=0;
    valor.real=45.23;
    strcpy(nombre,"b");
    insertarSimbolo(sim,nombre,2, valor);
    //cadena
    valor.real=0;
    strcpy(valor.cadena,"esto es una cadena");
    strcpy(nombre,"c");
    insertarSimbolo(sim,nombre,3, valor);
    //hasta aqui
    
     if(argc == 2){
     	modo=1;
 	   strcpy(nombre_lgo,argv[1]);

		yyin=fopen(nombre_lgo,"rt");
		

	    cmdInicio(modo);
    
		yyparse();

	    cmdFin();
	     
		fclose(yyin);
	}else{

		modo=0;
		prompt();
		cmdInicio(modo);
    
		yyparse();

    	cmdFin();

    }
	if (error == 1){
		printf("\033[1m \033[31m\nScript logo ejecutado CON errores\n");
	}  
	else{
		printf("\033[1m \033[32m\nScript logo ejecutado SIN errores\n");
	} 

	printf("\033[22m \033[30m");
	

	mostrarSimbolos(sim);

 	return 0;
}

void yyerror( const char *s)
{	
	printf("\033[1m\033[31m\n¡ERROR sintáctico en la línea %d!\n",numlinea);
	printf("\033[22m \033[30m");
	error = 1;	
	if(modo==0) prompt();
}

void prompt( void )
{

  printf("LISTO> ");
}

