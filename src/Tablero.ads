with Sudokus, Casillas, Indices, Numeros;
package Tablero is

   procedure Cargar_Sudoku(S: in Sudokus.Sudoku);
-- Guarda el sudoku S como Sudoku_Actual

   procedure Jugar (Nombre_Jugador: in String; Fin_Correcto: out Boolean);
   -- Esta operaci�n realiza los siguientes pasos:
   -- 1. visualiza el nombre del jugador, la identificaci�n del sudoku en curso y su grado de dificultad;
   -- 2. inicializa el Tablero_de_juego, para ello sit�a en �l los valores iniciales a partir de la informaci�n del Sudoku_Actual.
   --  Adem�s, por cada casilla que contenga un n�mero inicial solicita su visualizaci�n a la operaci�n correspondiente de la Interfaz;
   -- 3.  da comienzo al juego llamando a la operaci�n Interfaz.Comenzar. A partir de este momento la interfaz gr�fica toma el control para interpretar las acciones que realiza el usuario.
   -- 4. felicita al jugador (a trav�s de la Interfaz) si los valores del Tablero_de_juego coinciden con la soluci�n del Sudoku_Actual,
   --  y da el valor True al par�metro de salida Fin_Correcto; si las dos matrices no coinciden, env�a un mensaje de fracaso al usuario y da el valor False al par�metro Fin_Correcto.
   -- 5. Por �ltimo, libera los recursos gr�ficos utilizados llamando a la operaci�n que existe para tal efecto en la interfaz gr�fica.

   function Solucion_Correcta return Boolean;
   -- Si la matriz del Tablero_de_juego coincide con la contenida en el Sudoku_Actual devuelve el valor True, en caso contrario devuelve False.

   procedure Anotar_Numero (F, C: in Indices.Indice; N: in Numeros.Numero);
   --  Coloca el n�mero N en las coordenadas F y C del Tablero_de_juego.

   procedure Borrar_Numero (F, C: in Indices.Indice);
   -- : Elimina el n�mero de las coordenadas F y C del  Tablero_de_juego.

   procedure Ayudar;
   -- 1. refresca interfaz gr�fica llamando a la operaci�n creada a tal efecto.
   -- 2. examina el Tablero_de_juego y calcula el n�mero de elementos no coincidentes con los del sudoku soluci�n;
   -- 3. si hay errores, los visualiza a trav�s de la interfaz mediante la etiqueta de errores e indica el n�mero de errores encontrados;
   -- 4. examina las inconsistencias de las �reas del Tablero_de_juego (filas, columnas y zonas cuadradas) y marca de manera especial en la interfaz (en rojo) cada �rea inconsistente detectada.
   --  Debe indicar con un mensaje (etiqueta) que hay inconsistencias (si no es as� no se mostrar� dicha etiqueta);
   -- 5. finalmente, si no encuentra ning�n error, comunica el mensaje de que todo va bien al usuario a trav�s de la interfaz

end Tablero;