with Ada.Text_Io, Niveles_Dificultad;
with Matrices_Casillas; use Matrices_Casillas;


package Sudokus is

   type Sudoku is private;

   procedure Leer (Fich: in out Ada.Text_IO.File_Type; S: out Sudoku);


   function Identificador (S: in Sudoku) return String;
   -- Devuelve el identificador de un sudoku S dado.

   function Dificultad (S: in Sudoku)
                        return Niveles_Dificultad.Nivel;
   -- Devuelve la dificultad de un sudoku S dado.

   function Matriz (S: in Sudoku) return Matrices_Casillas.Matriz;
   -- Devuelve la matriz de casillas de un sudoku S dado.

   procedure Copiar (S1: out Sudoku; S2: in Sudoku);
   -- Copia el contenido del sudoku S2 en S1.

private
   type Sudoku is record
      Identificacion: String (1..4);
      Niveles_De_Dificultad: Niveles_Dificultad.Nivel;
      Valores_Numericos: Matrices_Casillas.Matriz;
   end record;
end Sudokus;





