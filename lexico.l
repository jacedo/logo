%{
#include<stdlib.h>
#include "logo.h"

extern int numlinea;

%}


%option noyywrap

digito		[0-9]	
num_entero	{digito}+	
num_real	{num_entero}[.]{num_entero}



%%


[aA][vV][aA][nN][zZ][aA] | [aA][vV]						{return AV;}
[rR][eE][tT][rR][oO][cC][eE][dD][eE] | [rR][eE]					{return RE;}
[Gg][Ii][Rr][Aa][Dd][Ee][Rr][Ee][Cc][Hh][Aa] | [Gg][Dd]				{return GD;}
[Gg][Ii][Rr][Aa][Ii][Zz][Qq][Uu][Ii][Ee][Rr][Dd][Aa] | [Gg][Ii]			{return GI;}
[Ss][Uu][Bb][Ee][Ll][Aa][Pp][Ii][Zz] | [Ss][Ll]					{return SL;}
[Bb][Aa][Jj][Aa][Ll][Aa][Pp][Ii][Zz] | [Bb][Ll]					{return BL;}
[Mm][Uu][Ee][Ss][Tt][Rr][Aa][Tt][Oo][Rr][Tt][Uu][Gg][Aa] | [Mm][Tt]		{return MT;}
[Oo][Cc][Uu][Ll][Tt][Aa][Tt][Oo][Rr][Tt][Uu][Gg][Aa] | [Oo][Tt]			{return OT;}

 {num_entero}            {yylval.c_entero=atoi(yytext);
			return N_ENTERO;}
 

.	;
%%
