#define MAXCMD 100

typedef union{
	float numero;
	char cadena[100];
}param;

typedef struct {
	int  comando;
	param parametro;
}instruccion;

void cmdAvanza(int *columna,int *fila,int valor, int lapiz, int oculta, int orientacion);
void cmdRetrocede(int *columna,int *fila,int valor, int lapiz, int oculta, int orientacion);
void cmdGiraDerecha(int columna,int fila,int valor, int oculta, int *orientacion);
void cmdGiraIzquierda(int columna,int fila,int valor, int oculta, int *orientacion);
void cmdBajaLapiz(int *lapiz);
void cmdSubeLapiz(int *lapiz);
void cmdMuestraTortuga(int columna, int fila, int orientacion, int *oculta);
void cmdOcultaTortuga(int columna, int fila, int orientacion, int *oculta);
void cmdInicio();
void cmdFin();
void ejecutarBucle(int veces,instruccion cmd[],int num_cmd,int *columna,int *fila,int *lapiz, int *oculta, int *orientacion);
void reinicilizaCmd(instruccion cmd[],int *contador_cmd);
void cmdBorrarPantalla();