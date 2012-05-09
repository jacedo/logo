#define MAXCMD 100

typedef union{
	float numero;
	char cadena[100];
}param;

typedef struct {
	int  comando;
	param parametro;
}instruccion;

void cmdAvanza(int *columna,int *fila,int valor, int lapiz, int oculta, int orientacion,int R, int G, int B,int modo);
void cmdRetrocede(int *columna,int *fila,int valor, int lapiz, int oculta, int orientacion,int R, int G, int B, int modo);
void cmdGiraDerecha(int columna,int fila,int valor, int oculta, int *orientacion,int modo);
void cmdGiraIzquierda(int columna,int fila,int valor, int oculta, int *orientacion, int modo);
void cmdBajaLapiz(int *lapiz);
void cmdSubeLapiz(int *lapiz);
void cmdMuestraTortuga(int columna, int fila, int orientacion, int *oculta, int modo);
void cmdOcultaTortuga(int columna, int fila, int orientacion, int *oculta,int modo);
void cmdInicio(int modo);
void cmdFin();
void ejecutarBucle(int veces,instruccion cmd[],int num_cmd,int *columna,int *fila,int *lapiz, int *oculta, int *orientacion,int R, int G, int B,int modo);
void reinicilizaCmd(instruccion cmd[],int *contador_cmd);
void cmdBorrarPantalla(int modo);