/*Julio Acedo Durán*/
/*Héctor Molano Macías*/

%{

#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include "sintaxis.h"

extern int numlinea;

%}

%option noyywrap
%x  COM1 COM2

digito		[0-9]	
num_entero	{digito}+	
num_real	{num_entero}+[.]{num_entero}*
identificador	[a-zA-Z][_a-zA-Z0-9]*
cadena		["][^"][,.?¿!¡*A-Za-z]+["]
%%


^[#]		BEGIN(COM1);
<COM1>"\n"	BEGIN(0);

[#]		BEGIN(COM2);
<COM2>"\n"	BEGIN(0);

<COM1>.+				{return '\n';}
<COM2>.+				{return '\n';}

[aA][vV][aA][nN][zZ][aA][ ]					{return AV;}
[aA][vV][ ]							{return AV;}
[rR][eE][tT][rR][oO][cC][eE][dD][eE][ ]				{return RE;}
[rR][eE][ ]							{return RE;}
[Gg][Ii][Rr][Aa][Dd][Ee][Rr][Ee][Cc][Hh][Aa][ ]			{return GD;}
[gG][dD][ ]							{return GD;}
[Gg][Ii][Rr][Aa][Ii][Zz][Qq][Uu][Ii][Ee][Rr][Dd][Aa][ ]		{return GI;}
[gG][iI][ ]							{return GI;}
[Ss][Uu][Bb][Ee][Ll][Aa][Pp][Ii][Zz]				{return SL;}
[sS][lL]							{return SL;}
[Bb][Aa][Jj][Aa][Ll][Aa][Pp][Ii][Zz] 				{return BL;}
[bB][lL]							{return BL;}
[Mm][Uu][Ee][Ss][Tt][Rr][Aa][Tt][Oo][Rr][Tt][Uu][Gg][Aa] 	{return MT;}
[mM][tT]							{return MT;}
[Oo][Cc][Uu][Ll][Tt][Aa][Tt][Oo][Rr][Tt][Uu][Gg][Aa] 		{return OT;}
[oO][tT]							{return OT;}
[rR][eE][pP][iI][tT][eE][ ]					{return REPITE;}
[eE][sS][cC][rR][iI][bB][eE][ ]		{return ESCRIBE;}
[eE][sS][ ]							{return ESCRIBE;}
[bB][oO][rR][aA][rR][pP][aA][nN][tT][aA][lL][lL][aA] 	{return BP;}
[bB][pP]												{return BP;}
[pP][oO][nN][cC][lL][ ]								{return PC;}
[sS][iI][ ]											{return SI;}
[Hh][Aa][Zz][ ]									{return HAZ;}
[sS][aA][lL][iI][rR]			{	strcpy(yylval.c_cadena, yytext);
								return SALIR;
							}
[nN][oO][ ]					{return NO;
							 }
{num_entero}            	{yylval.c_entero=atoi(yytext);
								return N_ENTERO;
							}
{num_real}					{yylval.c_real = atof(yytext);
								return N_REAL;
							}

["]{identificador}		{
								//Jooooooder strcpy no pone '\0' al final de yylval.c_cadena
								memset (yylval.c_cadena,' ',strlen(yylval.c_cadena));
								strncpy(yylval.c_cadena,yytext+1,strlen(yytext)-1);
								yylval.c_cadena[strlen(yytext)-1]='\0';
								//printf("Identificador con comillas %s",yylval.c_cadena);
								memcpy (yytext,"\0",1);
								return ASIG_IDENT;
							}	

[:]{identificador}                         {
								//Jooooooder strcpy no pone '\0' al final de yylval.c_cadena
								memset (yylval.c_cadena,' ',strlen(yylval.c_cadena));
								strncpy(yylval.c_cadena,yytext+1,strlen(yytext)-1);
								yylval.c_cadena[strlen(yytext)-1]='\0';
								//printf("Identificador con : %s",yylval.c_cadena);
								memcpy (yytext,"\0",1);
								return RECUP_IDENT;
                                                        } 
				
{cadena}					{strcpy(yylval.c_cadena,yytext);
								//printf("pillo cadena");
								return CADENA;
							}
	


							


\t 							; 

\n                  		{
							return yytext[0];
							}

[ ]                 		;

.                   		{return yytext[0];
							}

%% 
