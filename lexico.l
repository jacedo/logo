%{
#include "logo.hpp"
extern int numlinea;
%}


%option noyywrap

digito		[0-9]	
num_entero	{digito}+	
num_real	{num_entero}[.]{num_entero}


%%


avanza|av		{return AV;}
retrocede|re		{return RE;}
giraderecha|gd		{return GD;}
giraizquierda|gi	{return GI;}
subelapiz|sl		{return SL;}
bajalapiz|bl		{return BL;}
muestratortuga|mt	{return MT;}
ocultatortuga|ot	{return OT;}



{identificador}		{strcpy(yylval.ccadena, yytext);
			printf("Encuentro IDENT %s\n", yylval.ccadena);
			return IDENT;}



\n			{return yytext[0];}
[ ]			;
.			{return yytext[0];}

%%
