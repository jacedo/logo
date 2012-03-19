#fichero Makefile

prueba : prueba.o Entorno.o 
	g++ -oprueba Entorno.o prueba.o -lalleg -lX11 -lXpm -lXext -lXcursor -lpthread -lXxf86vm

Entorno.o : Entorno.cpp
	g++ -c Entorno.cpp

prueba.o : prueba.cpp 
	g++ -c prueba.cpp 

#prueba.cpp : prueba.lgo
#	./logo prueba.lgo 	
