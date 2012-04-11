#fichero Makefile

logo: lexico.o logo.o
	gcc -ologo -lm lexico.o logo.o

logo.o: logo.c 
	gcc -c logo.c

lexico.o :lexico.c logo.h
	gcc -c lexico.c

logo.c : logo.y 
	bison -d -ologo.c logo.y

lexico.c : lexico.l
	flex -olexico.c lexico.l

clean : 
	rm  -f  *.o *.c
