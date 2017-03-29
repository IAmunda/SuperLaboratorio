with Sudokus, Tablero;
with Ada.Text_IO;
procedure Probar_Tablero is
   F_Prueba : Ada.Text_IO.File_Type;
   S : Sudokus.Sudoku;
   Fin_Correcto : Boolean := False;
begin
   Ada.Text_Io.Open (F_Prueba, Ada.Text_Io.In_File, "un_sudoku.txt");
   Sudokus.Leer (F_Prueba, S);
   Ada.Text_IO.Close (F_Prueba);

   Tablero.Cargar_Sudoku (S);
   Ada.Text_IO.Put_Line ("Vamos a probar el paquete tablero.");
   Ada.Text_IO.Put_Line ("Para ello, intenta introducir y borrar valores a traves de la interfaz.");
   Ada.Text_IO.Put_Line ("Prueba tambien el boton  Que tal voy?");
   Ada.Text_IO.Put_Line ("Ahora pulsa RETURN !");
   Ada.Text_IO.Skip_Line;
   Tablero.Jugar ("Melquiades", Fin_Correcto);
   Ada.Text_IO.Put_Line ("Fin_Correcto: " &
                         Boolean'Image (Fin_Correcto));

   Ada.Text_IO.Put_Line ("Se ha terminado la prueba del paquete Tablero!");

--  exception
--     when Sudokus.Error_de_Lectura =>
--        Ada.Text_IO.Put_Line ("Error al leer el sudoku");
--     when Sudokus.Numero_Erroneo =>
--        Ada.Text_IO.Put_Line ("Error: Hay algun numero erroneo en el sudoku");
end Probar_Tablero;
