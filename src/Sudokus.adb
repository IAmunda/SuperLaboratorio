
package body Sudokus is

   procedure Leer (Fich: in out Ada.Text_IO.File_Type; S: out Sudoku) is
      Identificacion: String(1..4);
      Nivel: string(1..1);
      Matriz: Matrices_Casillas.Matriz;
   begin
      Ada.Text_Io.Get(Fich, Identificacion);Ada.Text_Io.Skip_Line(Fich);
      Ada.Text_Io.Get(Fich, Nivel);Ada.Text_Io.Skip_Line(Fich);
      Matrices_Casillas.Leer_Inicial(Fich, Matriz);
      Matrices_Casillas.Leer_Final(Fich, Matriz);

      S.Identificacion := Identificacion;
      S.Niveles_De_Dificultad:=integer'value(Nivel);
      S.Valores_Numericos:=Matriz;

   exception
      when Ada.Text_Io.End_Error => raise Error_De_Lectura;

   end Leer;

      function Identificador (S: in Sudoku) return String is
      begin
         return S.Identificacion;
      end Identificador;

      function Dificultad (S: in Sudoku) return Niveles_Dificultad.Nivel is
      begin
         return S.Niveles_De_Dificultad;
      end Dificultad;

      function  Matriz (S: in Sudoku) return Matrices_Casillas.Matriz is
      begin
         return S.Valores_Numericos;
      end Matriz;

      procedure Copiar (S1: out Sudoku; S2: in Sudoku) is
      begin
         S1.Identificacion:= S2.Identificacion;
         S1.Niveles_De_Dificultad:= S2.Niveles_De_Dificultad;
         S1.Valores_Numericos:= S2.Valores_Numericos;
   end Copiar;

   end Sudokus;
