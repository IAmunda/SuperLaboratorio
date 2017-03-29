with listas_ordenadas;
with ada.text_IO;
package body Lista_Sudokus is

   package Lista_Sudokus is new listas_ordenadas(Componente => Sudokus.Sudoku,
                                                 Igual      => Sudokus.Igual ,
                                                 Copiar     => Sudokus.Copiar);

   procedure Inicializar (D: Niveles_Dificultad.Nivel) is
   begin

   end Inicializar;

   procedure Obtener_Siguiente(S: out Sudokus.Sudoku) is
   begin
      null;
   end Obtener_Siguiente;


end Lista_Sudokus;
