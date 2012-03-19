#include "Entorno.h"
int main(){
  inicio();
  pon_tortuga(400,300,0);
  readkey();

  borra_tortuga(400,300);
  linea(400,300,400,200);
  pon_tortuga(400,200,0);
  readkey();

  borra_tortuga(400,200);
  pon_tortuga(400,200,1);
  readkey();

  borra_tortuga(400,200);
  linea(400,200,500,200);
  pon_tortuga(500,200,1);
  readkey();

  borra_tortuga(500,200);
  pon_tortuga(500,200,2);
  readkey();

  borra_tortuga(500,200);
  linea(500,200,500,300);
  pon_tortuga(500,300,2);
  readkey();

  borra_tortuga(500,300);
  pon_tortuga(500,300,3);
  readkey();

  borra_tortuga(500,300);
  linea(500,300,400,300);
  pon_tortuga(400,300,3);
  readkey();

  borra_tortuga(400,300);
  pon_tortuga(400,300,0);
  readkey();

  fin();
  return 0;
}
