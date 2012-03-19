//============================================================================
// Name        : Entorno.h
// Author      : Profesoras de TALF
// Version     :
// Copyright   : Your copyright notice
// Description : Hello World in C++, Ansi-style
//============================================================================
#include <allegro.h>

using namespace std;


void linea(int x1,int y1,int x2,int y2);
/*Dibuja una línea desde las coordenadas (x1,y1) hasta (x2,y2)*/

void pon_tortuga(int x1,int y1,int orientacion);
/*Dibuja una tortuga en la posición (x1,y1), según el siguiente valor de "orientación" */
/* 0: Norte, 1: Este, 2:Sur. 3: Oeste*/

void borra_tortuga(int x1,int y1);
/*Borra la toruga situada en el punto (x1, x2)*/

void inicio();
/* Inicia todas las variables necesarias para el resto de los módulos*/

void fin();
/*Finaliza el entorno allegro*/
