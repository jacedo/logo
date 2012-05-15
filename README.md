***Fase 3. Enunciado final del Proyecto Logo***

El proyecto Logo consiste en la implementación de un intérprete para una versión
reducida escrita en castellano del lenguaje Logo. La calificación de dicho proyecto
constituye el 40% de la nota final de la asignatura. Además, es necesario aprobar este
proyecto para superar la asignatura. Para superar este proyecto por evaluación continua
es necesario entregarlo antes del 27 de mayo a través de una tarea habilitada en el
campus virtual. La defensa se llevará a cabo la semana del 28 de mayo.

**1. Cuestiones que es importante tener en cuenta**

1. Es necesario entregar el proyecto acompañado por una documentación en la que
se prestará especial atención al diseño de las estructuras de datos auxiliares
utilizadas en la implementación del intérprete. También es importante incluir una
explicación detallada de las ampliaciones realizadas en el proyecto.

2. En el caso de que la gramática presente conflictos(s/r o r/r), estos deben
explicarse y justificarse en la documentación.

3. Es posible escribir varias instrucciones en la misma línea. Una instrucción básica
(ver apartado 2.1) no puede aparecer dividida en dos líneas diferentes, sin
embargo las estructuras de control pueden ocupar varias líneas (utilizando los
corchetes como punto en el que realizar la división).

4. Los comentarios (que aparecen precedidos por el símbolo '#') pueden aparecer
en cualquier punto del programa.

5. Cuando la invocación al intérprete no utiliza ningún parámetro la entrada del
programa se realizará a través del teclado. Sin embargo, si se utiliza un
parámetro, se utilizará un fichero de entrada cuyo nombre será dicho parámetro.

6. En la evaluación del proyecto se valorará:
  1. la claridad de la gramática
  2. la claridad y eficiencia del código C/C++ incluido en el proyecto.
  3. la eficacia de las estructuras de datos definidas
  7. Es conveniente que las dudas acerca del enunciado del proyecto se planteen en
  el foro del aula virtual.


**2. Lenguaje Logo**

*2.1. Instrucciones básicas*

1. avanza n
(av n)

2. retrocede n
(re n)

3. giraderecha n
(gd n)

4. giraizquierda n
(gi n)

En estos casos n es una expresión numérica que admite valores negativos.
Pueden ser de tipo entero o de tipo real pero si el valor de la expresión es
real debe truncarse o redondearse para poder ejecutar correctamente los
procedimientos de la librería “Entorno”.

En el caso de valores negativos:
1. av -n es equivalente a re n (y viceversa)
2. gd -n es equivalente a gi n (y viceversa)

ocultatortuga
(ot)
muestratortuga
(mt)
subelapiz
(sl)
bajalapiz
(bl)
haz “nombre_variable valor
(ver apartado 2.3)


*2.2. Instrucción de escritura*

La instrucción de escritura está formada por la palabra reservada “escribe” (la
abreviatura es “es”) seguida por un parámetro que puede ser:
• una cadena de caracteres (encerrada entre dobles comillas y sin espacios)
• una expresión aritmética
• una expresión lógica
• el nombre de una variable


*2.3. Utilización de variables e instrucciones de asignación. Nuevo*

Para dar un nombre a una variable se pueden utilizar letras, dígitos y la barra baja. La
única restricción a tener en cuenta es que el nombre de una variable no puede ser un
número. Además, Logo no distingue entre mayúsculas y minúsculas.

Para asignarle un valor a una variable se utiliza la palabra reservada “haz” seguida por
el nombre de la variable (que debe ir precedido por el símbolo “) y el valor que se le
asigna. En Logo no existe una instrucción para declarar el tipo de una variable y, por
tanto, el tipo de la variable depende del valor que se le asigne y puede variar a lo largo
de la ejecución del programa. La sintaxis de una instrucción de asignación es:

haz “nombre_variable valor
valor puede ser una expresión numérica, un número, una expresión lógica o una
cadena de caracteres.


Cuando utilizamos el valor de una variable (por ejemplo, en una expresión o en una
instrucción de escritura), su nombre debe ir precedido por el símbolo :.
Cuando se utilicen los símbolos “ y : deben ir directamente concatenados al nombre de
la variable, sin que aparezca ningún espacio en blanco entre ellos.


*2.3.1. La tabla de símbolos*

Para la ejecución y los controles semánticos de las instrucciones que utilizan variables
será necesario gestionar una estructura de datos auxiliar que almacene toda la
información relevante acerca de las variables. Concretamente, será necesario
almacenar su nombre, su valor y su tipo.

Ejemplo de utilización de variables (en la columna de la derecha aparece la salida del
programa):
  haz “num 100
  haz “2num :num*2
  es :num 100
  es :2NUM 200
  haz “num “hola”
  haz “2Num 2<2+1
  escribe :num hola
  escribe :2num cierto
  
*2.4. Instrucción para borrar la pantalla. Nuevo*

El comando “borrapantalla” (la abreviatura es “bp”) borra la pantalla y coloca la tortuga
en la posición inicial. Es necesario ampliar la librería “Entorno”.

*2.5 Cambios de color. Nuevo*

Utilizando la instrucción “poncl N” será posible cambiar el color del rastro que deja la
tortuga. Es necesario modificar la librería “Entorno” (procedimiento “linea”). El color
definido será utilizado hasta que cambie de nuevo:

Ejemplo:
  poncl 0
  poncl 1
  poncl 2
  poncl 3
  poncl 4
  poncl 5
  poncl 6
  poncl 7
  poncl 8
  #la tortuga deja un rastro de color negro (es el color inicial)
  #la tortuga deja un rastro de color rojo
  #la tortuga deja un rastro de color verde
  #la tortuga deja un rastro de color amarillo
  #la tortuga deja un rastro de color azul oscuro
  #la tortuga deja un rastro de color rosa
  #la tortuga deja un rastro de color azul claro
  #la tortuga deja un rastro de color blanco
  #la tortuga deja un rastro de color gris
  
  
*2.6. Expresiones aritméticas y lógicas*
Para definir expresiones aritméticas se pueden utilizar las operaciones: + - * /
Las expresiones aritméticas pueden ser de tipo entero o real y esto deberá tenerse en
cuenta en el control semántico de ciertas operaciones. Por ejemplo, el contador de las
repeticiones en un bucle debe ser de tipo entero. Una expresión será de tipo real si el
valor que resulta de su evaluación es un número real (con decimales).

Para definir expresiones lógicas se pueden utilizar como comparadores tres
operaciones: < > =

Los tres operadores lógicos son: & | (operaciones binarias and y or respectivamente) no
(operación unitaria). Ejemplo:
  3<4 & no 2=1+1

*2.7. Estructuras de control*

*2.7.1. Bucle “repite”*

La sintaxis es:

  repite n [ instrucción1 instruccion2 ... ]
n es una expresión numérica de tipo entero, e indica el número de veces que se repiten
las instrucciones del bucle. Si el valor de n es real, es decir, un número con decimales,
se debe mostrar un mensaje de error (ver apartado 3) y no ejecutar el bucle.

*2.7.2. Estructura alternativa o condicional. Nuevo*

Esta estructura de control puede utilizarse de dos formas diferentes:
  • si condición [ instrucción1 instruccion2 ... ]
  • si condición [ instr1 instr2 ... ] [ instr1' instr2' ... ]
  
En cualquier caso las acciones encerradas entre el primer par de corchetes se
ejecutarán si la condición es cierta y, en el segundo caso, las que están encerradas
entre el segundo par de corchetes se ejecutarán si la condición es falsa.

Hay que tener en cuenta que “condición” representa una expresión lógica o booleana y
que “si” es una palabra reservada del lenguaje.

*3. Errores semánticos+
El analizador semántico, se ocupará de controlar, utilizando para ello la información
almacenada en la tabla de símbolos, la correcta utilización de las variables. A
continuación se detallan diferentes errores semánticos y los mensajes que, en cada
caso, aparecerían en la pantalla. Por supuesto, una instrucción que tenga errores
semánticos no se ejecutará.

• Utilización de una variable que no existe.
Ejemplo:
  haz “aa 25
  escribe :a    a no tiene valor

• Utilización en un bucle de una expresión que no tiene un valor entero.
Ejemplo:
  haz “aa 2.5
  repite :aa [gd 90] 2.5 no es un número entero!
  repite :aa*3 [gd 90] 7.5 no es un número entero!
  
• Utilización, en expresiones aritméticas o lógicas, de variables que no tienen el
tipo adecuado.

Ejemplo:
  haz “aa “hola”
  escribe :aa * 2 “hola” no es un número!
  escribe :aa < 23 “hola” no es un número!
  repite :aa [av 100] “hola” no es un número!
  haz “bb 2>3
  repite :bb [av 100]
  falso no es un número!
  
  
**4. Ampliaciones opcionales del proyecto Logo**
Cumpliendo todos los requisitos descritos anteriormente (esto también incluye todos los
aspectos del lenguaje que aparecen en las fases 1 y 2) se puede obtener una
calificación máxima de 6 si el proyecto se ha realizado en pareja o de 8 si se ha
realizado de forma individual. Para poder obtener una calificación mas alta será
necesario realizar alguna de las ampliaciones que se indican a continuación. Las
ampliaciones realizadas deben describirse cuidadosamente en la documentación.


*4.1. Giros con cualquier ángulo (hasta 2 puntos)*

Se elimina la restricción de que los ángulos empleados en el giro deban ser múltiplos de
90 grados. Esto aumenta la complejidad en el cálculo de la nueva posición de la tortuga.
Es necesario modificar la librería “Entorno” (procedimiento “pon_tortuga”). Si los ángulo
saceptados sólo puedes ser múltiplos de 45o la nota aumentará, como máximo, 1 punto.

*4.2. Anidamiento de estructuras de control (hasta 4 puntos)*

Por ejemplo, puede aparecer un bucle dentro de otro, una sentencia si dentro de un
bucle, etc. Desde un punto de vista gramatical, este hecho no representa ninguna
complejidad. Sin embargo, para que las instrucciones incluidas en los bucles puedan
ejecutarse correctamente, será necesario diseñar estructuras de datos jerarquizadas
que permitan almacenarlas convenientemente.
Si las instrucciones incluidas en las estructuras que se anidan son básicas y no
requieren el cálculo de expresiones, esta ampliación sólo sumará 2 puntos como
máximo.

*4.3. Procedimientos (hasta 4 puntos)*

Para definir un procedimiento hay que utilizar la palabra “para” seguida del nombre que
queramos dar al procedimiento y acabar con la palabra “fin”. Una vez definido el
procedimiento, basta escribir su nombre para que se ejecute. El procedimiento puede
tener parámetros (para simplificar el problema supondremos que sólo hay un
parámetro).
Ejemplo de procedimiento sin parámetro:
  para cuadrado
  repite 4 [av 100 gd 90]
  fin
  ot
  cuadrado
  #ésta es la llamada
  Ejemplo de procedimiento con parámetro:
  para cuadrado “lado
  repite 4 [av :lado gd 90]
  fin
  ot
  cuadrado 50
  #ésta es la llamada

Igual que ocurre con los bucles, será necesario almacenar las instrucciones del
procedimiento en una estructura auxiliar.
Si los procedimientos no admiten parámetros, las instrucciones incluidas en él son
básicas y no requieren el cálculo de expresiones, está ampliación sólo sumará 2 puntos
como máximo.

*4.4. Cálculo de expresiones con variables dentro de un bucle (hasta 4 puntos)*

Para poder ejecutar dentro de una estructura de control o de un procedimiento una
instrucción en la que aparece una expresión que incluye variables, será necesario
almacenar en una estructura auxiliar (lo más apropiado es un árbol) la expresión para
que pueda ser evaluada tantas veces como se repita el bucle o cada vez que se invoque
al procedimiento.
Ejemplo:
  haz “a 100
  repite 5 [
  avanza :a
  gd 90
  haz “a :a+100
  ]

