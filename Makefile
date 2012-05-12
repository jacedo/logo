#fichero Makefile

logo: sintaxis.o lexico.o Entorno.o comandos.o simbolos.o
	g++ -ologo -lm lexico.o sintaxis.o Entorno.o comandos.o simbolos.o -lalleg -lX11 -lXpm -lXext -lXcursor -lpthread -lXxf86vm

sintaxis.o: sintaxis.c 
	g++ -c sintaxis.c

comandos.o: comandos.c comandos.h
	g++ -c comandos.c 

lexico.o:lexico.c sintaxis.h
	g++ -c lexico.c

simbolos.o: simbolos.c
	g++ -c simbolos.c

Entorno.o: Entorno.cpp
	g++ -c Entorno.cpp

sintaxis.c: sintaxis.y 
	bison -d -osintaxis.c sintaxis.y

lexico.c: lexico.l
	flex -olexico.c lexico.l

clean: 
	rm  -f  *.o lexico.c sintaxis.h sintaxis.c logo
