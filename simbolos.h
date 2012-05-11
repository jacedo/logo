typedef union{
	int entero; //1
	float real; //2
	char cadena[100]; //3
}tipoValor;

typedef struct simbolo{
	char nombre[20];
	int tipo;
	tipoValor valor;
}simbolo;

#define TAM 50

void inicializarSimbolos(simbolo sim[]);
void insertarSimbolo(simbolo sim[],char _nombre[],int _tipo, tipoValor  _valor);
simbolo obtenerSimbolo(simbolo sim[],char _nombre[]);
int existeSimbolo(simbolo sim[],char _nombre[]);