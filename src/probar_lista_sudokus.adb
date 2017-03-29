with Lista_Sudokus, Tablero, Sudokus, Ada.Text_IO;
procedure Probar_Lista_Sudokus is
   S: Sudokus.Sudoku;
   Fin : Boolean;

begin
   Ada.Text_Io.Put_Line("Se crea la lista con nivel 1");
   Lista_Sudokus.Inicializar(1);
   while True loop
   Ada.Text_Io.Put_Line("Obtiene un sudoku");
      Lista_Sudokus.Obtener_Siguiente(S);
   Ada.Text_Io.Put_Line("Imprime un sudoku");
      Tablero.Cargar_Sudoku(S);
      Tablero.Jugar("Pepe",Fin);
   end loop;

exception
--     when Lista_Sudokus.No_Hay_Sudokus =>    Ada.Text_Io.Put_Line("Se ha terminado la lista de sudokus. GRACIAS POR JUGAR");
   when others =>    Ada.Text_Io.Put_Line("Se ha terminado la lista de sudokus. GRACIAS POR JUGAR");

end Probar_Lista_Sudokus;


