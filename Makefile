#fichero Makefile

logo: lexico.o logo.o Entorno.o bucle.o
	g++ -ologo -lm lexico.o logo.o Entorno.o bucle.o -lalleg -lX11 -lXpm -lXext -lXcursor -lpthread -lXxf86vm

logo.o: logo.c 
	g++ -c logo.c

bucle.o : bucle.c bucle.h
	g++ -c bucle.c 

lexico.o :lexico.c logo.h
	g++ -c lexico.c

Entorno.o : Entorno.cpp
	g++ -c Entorno.cpp

logo.c : logo.y 
	bison -d -ologo.c logo.y

lexico.c : lexico.l
	flex -olexico.c lexico.l

clean : 
	rm  -f  *.o 
