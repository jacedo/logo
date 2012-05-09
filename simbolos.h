typedef union{
	int entero;
	float real;
	char cadena[100];
}tipoValor;

typedef struct simbolo{
	char nombre[20];
	int tipo;
	tipoValor valor;
}simbolo;

void iniciarSimbolo(simbolo s[]);
void insertarSimbolo(simbolo s[],char n[],int t, valorTipo v);
simbolo obtenerSimbolo(simbolo[],char n[]);
int existeSimbolo(simbolo[],char n[]);