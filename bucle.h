typedef struct instruccion{
	char comando[40];
	int orden;
}instruccion;

void cmdAvanza(FILE * yyout,int *columna,int *fila,int valor, int lapiz, int oculta, int orientacion);