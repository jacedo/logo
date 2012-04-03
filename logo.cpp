
#include "logo.cpp"
void Inicio(){
	inicio();
}

void Fin(){
	fin();
}

Tortuga CrearTortuga (int f, int c, Orientacion o){
	Tortuga T;
	T.fila = f;
	T.columna = c;
	T.orientacion = o;
	T.lapiz = true;
	T.oculta = false;
	return T;
}

void MostrarTortuga (Tortuga T){
	pon_tortuga(T.columna,T.fila,T.orientacion);
}

void OcultarTortuga (Tortuga T){
	borra_tortuga(T.columna,T.fila);
}

void DesplazarTortuga (Tortuga T, int n){

	Tortuga aux=T;

	switch(T.orientacion){
		case Norte: 	T.fila=T.fila-n;
				break;
		case Este: 	T.columna=T.columna+n;
				break;
		case Sur: 	T.fila=T.fila+n;
				break;
		case Oeste: 	T.columna=T.columna-n;
				break;
	}	
	MoverTortuga(aux,T);
}

void MoverTortuga ( Tortuga Origen, Tortuga Destino){
	if(Origen.oculta){
		if(Origen.lapiz){
			linea(Origen.columna,Origen.fila,Destino.columna,Destino.fila);
		}
	}else{
		borra_tortuga(Origen.columna,Origen.fila);
		if(Origen.lapiz){
			linea(Origen.columna,Origen.fila,Destino.columna,Destino.fila);
		}
		pon_tortuga(Destino.columna,Destino.fila,Destino.orientacion);
	}
}

int  obtenerAngulo(Orientacion o){
	int angulo;
	switch(o){
		case Norte: 	angulo=90; 
				break;
		case Este: 	angulo=0;
				break;
		case Sur: 	angulo=270;
				break;
		case Oeste: 	angulo=180;
				break;
	}
	return angulo;
}

Orientacion obtenerOrientacion(int angulo){
	Orientacion o;
	switch(o){
		case 0:	 	o=Este;
				break;
		case 90: 	o=Norte;
				break;
		case 180: 	o=Oeste;
				break;
		case 270:	o=Sur;
			 	break;
	}
	return o;
}

void CambiarDireccion(Tortuga T, int angulo, int l){
	Tortuga aux=T;
	
	int a;
	a=obtenerAngulo(T.orientacion);
	//girar a la derecha
	if(l==0){
		a=a-angulo;
	}//girar a la izquierda l=1
	else{
		a=a+angulo;
	}
	while(a<0){
		a=a+360;		
	}
	a=a%360;
	T.orientacion=obtenerDireccion(a);
	GirarTortuga(aux,T);
}

void GirarTortuga (Tortuga Origen, Tortuga Destino){
	if(!Origen.oculta){
		borra_tortuga(Origen.columna,Origen.fila);
		pon_tortuga(Destino.columna,Destino.fila,Destino.orientacion);
	}
}





