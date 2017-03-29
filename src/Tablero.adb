with Tablero.Interfaz, matrices_casillas, casillas, ids_grupo_casillas;
package body Tablero is

   Tablero_De_Juego: Matrices_Casillas.Matriz;
   Sudoku_Actual: Sudokus.Sudoku;

   procedure Cargar_Sudoku (S: in Sudokus.Sudoku) is
   begin
      Sudokus.Copiar(Sudoku_Actual, S);
   end Cargar_Sudoku;

   procedure Jugar (Nombre_Jugador: in String; Fin_Correcto: out Boolean) is
      Matriz: Matrices_Casillas.Matriz;
      Casilla: Casillas.Casilla;
      Valor: Numeros.Numero;
      begin
      --(1)--
      Interfaz.Visualizar(Nombre_Jugador, Sudokus.Identificador(Sudoku_Actual), sudokus.Dificultad(Sudoku_Actual));
      --(2)--
      Matriz:= Sudokus.Matriz(Sudoku_Actual);
      Tablero_De_Juego:= Matriz;
      for Fila in Indices.Indice loop
         for Columna in Indices.Indice  loop
            Casilla:= Matrices_Casillas.Casilla(MC =>  Matriz,
                                                F  => Fila,
                                                C  => Columna);
            Valor:= Casillas.Valor(C => Casilla);
            if Casillas.Es_Inicial(Casilla) then
               Interfaz.Visualizar_Valor_Inicial(Fila  => Fila,
                                                 Col   => Columna ,
                                                 Valor => Valor);
               end if;
         end loop;
      end loop;
      --(3)--
         Interfaz.Comenzar;
         --(4)--
         for Fila in Indices.Indice loop
            For Columna in Indices.Indice loop



         end loop;
         end loop;
   --(5)--
   Interfaz.Liberar;
   end Jugar;

   function Solucion_Correcta return Boolean is
      Contador: Integer := 0;
      Cas_Tab, Cas_Sud: Casillas.Casilla;
   begin
      for Fila in Indices.Indice loop
         for Columna in Indices.Indice loop
            if not Casillas.Esta_Libre(Matrices_Casillas.Casilla(Tablero_De_Juego, Fila, Columna))then
                                       Cas_Tab := matrices_casillas.Casilla(Tablero_De_Juego, Fila, Columna);Cas_Sud := matrices_casillas.casilla(Sudokus.Matriz(Sudoku_actual),Fila,Columna);
               if casillas.Valor(Cas_Tab) = casillas.Valor(Cas_Sud) then
                                       Contador := Contador +1;
                end if;
             end if;
          end loop;
       end loop;

                   if Contador = 81 then
                     return true;
                    else
                     return false;
                   end if;
   end Solucion_Correcta;

procedure Anotar_Numero (F, C: in Indices.Indice;
                         N: in Numeros.Numero) is
   Matriz: Matrices_Casillas.Matriz;
   Casilla: Casillas.Casilla;
begin
   Matriz:= Sudokus.Matriz(Sudoku_Actual);
   for F in Indices.Indice loop
      for C in Indices.Indice loop
         Casilla:= Matrices_Casillas.Casilla(MC =>  Matriz,
                                             F  => F,
                                             C  => C);
         Casillas.Asignar_Valor(C => Casilla,
                                V => N);
      end loop;
   end loop;
end Anotar_Numero;

procedure Borrar_Numero(F, C: in Indices.Indice) is
   Matriz: Matrices_Casillas.Matriz;
   Casilla: Casillas.Casilla;
begin
   Matriz:= Sudokus.Matriz(Sudoku_Actual);
   for F in Indices.Indice loop
      for C in Indices.Indice loop
         Casilla:= Matrices_Casillas.Casilla(MC =>  Matriz,
                                             F  => F,
                                             C  => C);
         Casillas.Quitar_Valor(C => Casilla);
      end loop;
   end loop;
end Borrar_Numero;

procedure Ayudar is
   Matriz: Matrices_Casillas.Matriz;
   Casilla: Casillas.Casilla;
   Valor: Numeros.Numero;
begin
   --(1)--
   Interfaz.Refrescar;
   --(2)--
      Tablero_De_Juego:= Matriz;

   end Ayudar;

   end Tablero;



