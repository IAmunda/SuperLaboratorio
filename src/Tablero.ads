with Sudokus, Casillas, Indices, Numeros;
package Tablero is

   procedure Cargar_Sudoku(S: in Sudokus.Sudoku);
-- Guarda el sudoku S como Sudoku_Actual

   procedure Jugar (Nombre_Jugador: in String; Fin_Correcto: out Boolean);
   -- Esta operación realiza los siguientes pasos:
   -- 1. visualiza el nombre del jugador, la identificación del sudoku en curso y su grado de dificultad;
   -- 2. inicializa el Tablero_de_juego, para ello sitúa en él los valores iniciales a partir de la información del Sudoku_Actual.
   --  Además, por cada casilla que contenga un número inicial solicita su visualización a la operación correspondiente de la Interfaz;
   -- 3.  da comienzo al juego llamando a la operación Interfaz.Comenzar. A partir de este momento la interfaz gráfica toma el control para interpretar las acciones que realiza el usuario.
   -- 4. felicita al jugador (a través de la Interfaz) si los valores del Tablero_de_juego coinciden con la solución del Sudoku_Actual,
   --  y da el valor True al parámetro de salida Fin_Correcto; si las dos matrices no coinciden, envía un mensaje de fracaso al usuario y da el valor False al parámetro Fin_Correcto.
   -- 5. Por último, libera los recursos gráficos utilizados llamando a la operación que existe para tal efecto en la interfaz gráfica.

   function Solucion_Correcta return Boolean;
   -- Si la matriz del Tablero_de_juego coincide con la contenida en el Sudoku_Actual devuelve el valor True, en caso contrario devuelve False.

   procedure Anotar_Numero (F, C: in Indices.Indice; N: in Numeros.Numero);
   --  Coloca el número N en las coordenadas F y C del Tablero_de_juego.

   procedure Borrar_Numero (F, C: in Indices.Indice);
   -- : Elimina el número de las coordenadas F y C del  Tablero_de_juego.

   procedure Ayudar;
   -- 1. refresca interfaz gráfica llamando a la operación creada a tal efecto.
   -- 2. examina el Tablero_de_juego y calcula el número de elementos no coincidentes con los del sudoku solución;
   -- 3. si hay errores, los visualiza a través de la interfaz mediante la etiqueta de errores e indica el número de errores encontrados;
   -- 4. examina las inconsistencias de las áreas del Tablero_de_juego (filas, columnas y zonas cuadradas) y marca de manera especial en la interfaz (en rojo) cada área inconsistente detectada.
   --  Debe indicar con un mensaje (etiqueta) que hay inconsistencias (si no es así no se mostrará dicha etiqueta);
   -- 5. finalmente, si no encuentra ningún error, comunica el mensaje de que todo va bien al usuario a través de la interfaz

end Tablero;