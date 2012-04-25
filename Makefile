#fichero Makefile

logo: lexico.o logo.o Entorno.o
	g++ -ologo -lm lexico.o logo.o Entorno.o -lalleg -lX11 -lXpm -lXext -lXcursor -lpthread -lXxf86vm

logo.o: logo.c 
	g++ -c logo.c

lexico.o :lexico.c logo.h
	g++ -c lexico.c

Entorno.o : Entorno.cpp
	g++ -c Entorno.cpp

lexico.c : lexico.l
	flex -olexico.c lexico.l

logo.c : logo.y 
	bison -d -ologo.c logo.y

clean : 
	rm  -f  *.o *.c
