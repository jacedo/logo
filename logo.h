#ifndef LOGO_H_
#define LOGO_H_

#include "Entorno.h"


typedef enum Orientacion{Norte, Este, Sur, Oeste};

typedef struct Tortuga{
	int fila;
	int columna;
	Orientacion orientacion;
	bool lapiz;
	bool oculta;
}Tortuga;


//Inicia todas las variables necesarias para que el resto de los módulos puedan ejecutarse correctamente. Crea una ventana de trabajo de 800*600
void Inicio();

//finaliza el entorno allegro
void Fin();

Tortuga CrearTortuga (int f, int c, Orientacion o);

void MostrarTortuga (Tortuga T);

void OcultarTortuga (Tortuga T);

//calcula la nueva posicion de la tortuga tras avanzar n posiciones el la orientacion de la misma y llama a MoverTortuga
void DesplazarTortuga (Tortuga T, int n);
//mueve la tortuga desde la posicion origen a la posicion destino
void MoverTortuga (Tortuga Origen, Tortuga Destino);

//devuelve el valor del angulo correspondiente a la orientacion
int  obtenerAngulo(Orientacion o);
//devuelve la orientacion correspondiente al valor del angulo
Orientacion obtenerOrientacion(int angulo);

//calcula la nueva orientacion de la tortuga, añadiendo el angulo hacia el lado que indique l: 0 derecha, 1 izquierda. 
//Despues gira la tortuga hacia la nueva orientacion
void CambiarDireccion(Tortuga T, int angulo, int l);



#endif /* LOGO_H_ */
