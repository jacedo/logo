typedef struct instruccion{
	char comando[40];
	int orden;
}instruccion;

void cmdAvanza(FILE * yyout,int *columna,int *fila,int valor, int lapiz, int oculta, int orientacion);
void cmdRetrocede(FILE * yyout,int *columna,int *fila,int valor, int lapiz, int oculta, int orientacion);
void cmdGiraDerecha(FILE * yyout,int columna,int fila,int valor, int oculta, int *orientacion);
void cmdGiraIzquierda(FILE * yyout,int columna,int fila,int valor, int oculta, int *orientacion);
void cmdBajaLapiz(int *lapiz);
void cmdSubeLapiz(int *lapiz);
void cmdMuestraTortuga(FILE * yyout,int columna, int fila, int orientacion, int *oculta);
void cmdOcultaTortuga(FILE * yyout,int columna, int fila, int orientacion, int *oculta);