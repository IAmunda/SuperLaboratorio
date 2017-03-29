with Casillas, Ids_Grupo_Casillas, Indices;
with Ada.Text_IO;
package Matrices_Casillas is

   type Matriz is private;

   procedure Leer_Inicial (Fich : in out Ada.Text_IO.File_Type; MC: out Matriz);
   -- Construye una matriz de casillas de 9x9 (MC) con valores iniciales a partir de la informaci�n de un fichero de entrada. El fichero consta de 9 l�neas (1 por cada fila) de 9 n�meros (uno por cada columna) cuyos valores var�an entre 0 y 9. Un 0 indica que la casilla que le corresponde est� libre, mientras que los n�meros entre 1 y 9 se asignan como valores iniciales a las casillas correspondientes. La cabecera de esta operaci�n es la siguiente:

   procedure Leer_Final (Fich: in out Ada.Text_IO.File_Type; MC: out Matriz);
   -- Entrada: Fich, fichero de texto con una serie de numeros. Incluye 9 l�neas con 9 n�meros cada una; todos los n�meros pertenecen al rango Indices.Indice'range
   -- Salida:  MC, matriz de casillas
   -- Efecto:  Construye la matriz de casillas MC a partir del fichero Fich.

   function Casilla (MC: in Matriz; F, C: Indices.Indice) return Casillas.Casilla;
   -- Dada una matriz y dos �ndices del tipo Indice, que identifican una fila y una columna respectivamente, devuelve la casilla correspondiente.

   procedure Copiar_Casilla (M: in out Matriz; F, C: in Indices.Indice; Cas: in Casillas.Casilla);
   -- Dada una matriz M, dos �ndices del tipo Indice para representar los n�meros de fila (F) y columna (C), y un objeto Cas del tipo Casilla, modifica la matriz M copiando Cas en las posiciones indicadas por los dos �ndices.

   function Hay_Inconsistencias (M: Matriz; IG: Ids_Grupo_Casillas.Id_Grupo) return Boolean;
   -- Entrada: Una matriz M y un objeto IG del tipo Id_Grupo
   -- Salida:  Un valor booleano
   -- Efecto:  Devuelve True si M tiene inconsistencias en el grupo de casillas IG; y False en otro caso. El grupo IG tiene inconsistencias cuando en el se repite alg�n n�mero

   Error_De_Lectura: exception;
   Numero_Erroneo: exception;

private
   type Matriz is array (Indices.Indice, Indices.Indice) of Casillas.Casilla;
end Matrices_Casillas;


