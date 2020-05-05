%option noyywrap // función llamada después del EOF del archivo, el usuario define yywrap(), no se llama de la libreria de flex.

%top{
#include <stdio.h>

#define EOFEXIT "salida\n"
}

DIGIT    [0-9]

%{
static int words = 0;
int chars = 0;
int lines = 0;
int numbers = 0;

void printresult();
%}

%%
{DIGIT}+	{ numbers++; }
[a-zA-Z]+ 	{ words++; chars += strlen(yytext); }
\n 			{ chars++; lines++; }
. 			{ chars++; }
<<EOF>> 	{ printf(EOFEXIT); return 0; }
%%

int main(int argc, char **argv)
{
	yylex();
	printresult();
	return 0;
}

void printresult()
{
	printf("lineas: %d\npalabras: %d\ncaracteres: %d\nnumeros %d\n", lines, words, chars, numbers);
	return;
}

#undef EOFEXIT