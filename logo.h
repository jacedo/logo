#ifndef TORTUGA_H_
#define TORTUGA_H_

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

//calcula la nueva posicion de la tortuga tras avanzar n posiciones el la orientacion de la misma y llama a mover tortuga
void DesplazarTortuga (Tortuga T, int n);
//mueve la tortuga desde la posicion origen a la posicion destino
void MoverTortuga (Tortuga Origen, Tortuga Destino);


void GirarTortuga (Tortuga Origen, Tortuga Destino);








#endif /* TORTUGA_H_ */
