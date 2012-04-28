/*Julio Acedo Durán*/
/*Héctor Molano Macías*/

%{

#include<stdlib.h>
#include "logo.h"

extern int numlinea;

%}

%option noyywrap
%x  COM1

digito		[0-9]	
num_entero	{digito}+	
num_real	{num_entero}[.]{num_entero}
cadena		["][^"]*["]

%%


"#"		BEGIN(COM1);
<COM1>"\n"	BEGIN(0);

<COM1>.				;

[aA][vV][aA][nN][zZ][aA]					{return AV;}
[aA][vV]							{return AV;}
[rR][eE][tT][rR][oO][cC][eE][dD][eE]				{return RE;}
[rR][eE]							{return RE;}
[Gg][Ii][Rr][Aa][Dd][Ee][Rr][Ee][Cc][Hh][Aa]			{return GD;}
[gG][dD]							{return GD;}
[Gg][Ii][Rr][Aa][Ii][Zz][Qq][Uu][Ii][Ee][Rr][Dd][Aa]		{return GI;}
[gG][iI]							{return GI;}
[Ss][Uu][Bb][Ee][Ll][Aa][Pp][Ii][Zz] 				{return SL;}
[sS][lL]							{return SL;}
[Bb][Aa][Jj][Aa][Ll][Aa][Pp][Ii][Zz] 				{return BL;}
[bB][lL]							{return BL;}
[Mm][Uu][Ee][Ss][Tt][Rr][Aa][Tt][Oo][Rr][Tt][Uu][Gg][Aa] 	{return MT;}
[mM][tT]							{return MT;}
[Oo][Cc][Uu][Ll][Tt][Aa][Tt][Oo][Rr][Tt][Uu][Gg][Aa] 		{return OT;}
[oO][tT]							{return OT;}
[rR][eE][pP][iI][tT][eE]					{printf("envio repite \n");return REPITE;}
[eE][sS][cC][rR][iI][bB][eE]		{return ESCRIBE;}
[eE][sS]							{return ESCRIBE;}

{num_entero}            	{yylval.c_entero=atof(yytext);
								return N_ENTERO;
							}
{num_real}					{yylval.c_real = atof(yytext);
								return N_REAL;
							}
				
{cadena}					{strcpy(yylval.c_cadena,yytext);
								return CADENA;
							}					
							
\t 				; 

\n                  		{numlinea++;
							return yytext[0];
							}

[ ]                 		;

.                   		{return yytext[0];
							}

%% 
