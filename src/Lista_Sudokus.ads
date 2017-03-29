with Niveles_Dificultad, Sudokus;
package Lista_Sudokus is

   procedure Inicializar (D: Niveles_Dificultad.Nivel);
   --(1) inicializa la lista de sudokus con la información contenida en el fichero (el apartado de
   --excepciones describe qué hacer cuando el fichero no existe todavía);
   --(2) asigna el valor de D a la variable del nivel de dificultad actual;
   --(3) crea la primera sublista actual con los sudokus de nivel de dificultad D a partir de la lista

   procedure Obtener_Siguiente (S: out Sudokus.Sudoku);
   --Obtiene el primer sudoku de la sublista actual y lo elimina de la sublista. Si se
   --han terminado los sudokus del nivel de dificultad actual hay que incrementarlo y construir la
   --nueva sublista de sudokus que le corresponde. Si la nueva sublista también está vacía, hay que
   --pasar al siguiente nivel.

   end Lista_Sudokus;

