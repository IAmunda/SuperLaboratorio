with Numeros, ada.Text_IO; use ada.Text_IO;
package body Matrices_Casillas is

   procedure Leer_Inicial(Fich: in out Ada.Text_Io.File_Type; MC: out Matriz) is
      Cifra: String(1..1);
      C: Casillas.Casilla;
   begin
      for fila in Indices.Indice loop
         for columna in Indices.Indice loop
            Ada.Text_IO.Get(Fich,Cifra);
            --put(Cifra);
            Casillas.Crear(C);
            if not (Cifra(1) in '0' .. '9') then raise Numero_Erroneo;
            elsif Cifra(1)='0' then
               MC(Fila, Columna):=C;
            else
               Casillas.Asignar_Valor_inicial(C, Numeros.Numero'Value(Cifra));
               MC(Fila, Columna):=C;
            end if;
         end loop;
         Ada.Text_Io.Skip_Line(Fich);--new_line;
      end loop;
   exception
      when others => raise Error_De_Lectura;
   end Leer_Inicial;

   procedure Leer_Final (Fich: in out Ada.Text_IO.File_Type; MC: out Matriz) is
      Cifra: String(1..1);
      --C: Casillas.Casilla;
   begin
      for Fila in Indices.Indice loop
         for Columna in Indices.Indice loop
            Ada.Text_IO.Get(Fich,Cifra);
            --Casillas.Crear(C);
            if not (Cifra(1) in '1' .. '9') then raise Numero_Erroneo;
            else
               Casillas.Asignar_Valor(MC(Fila, Columna), Numeros.Numero'Value(Cifra));
               --MC(Fila, Columna) := C;
            end if;
         end loop;
         Ada.Text_Io.Skip_Line(Fich);
      end loop;
   exception
      when others => raise Error_De_Lectura;
   end Leer_Final;

   function Casilla(MC: in Matriz; F, C: in Indices.Indice) return Casillas.Casilla is
   begin
      return MC(F, C);
   end Casilla;

   procedure Copiar_Casilla (M: in out Matriz; F, C: in Indices.Indice; Cas: in Casillas.Casilla) is
   begin
      M(F, C):=Cas;
   end Copiar_Casilla;

   function Hay_Inconsistencias (M: Matriz; IG: Ids_Grupo_Casillas.Id_Grupo) return Boolean is

      Aux: array (Indices.Indice) of Integer := (others => 0);

      procedure Extraer_Fila (F: Indices.Indice) is
      begin
         for C in Indices.Indice loop
            if not Casillas.Esta_Libre(M(F, C)) then
               Aux(C) := Casillas.Valor(M(F, C));
            end if;
         end loop;
      end Extraer_Fila;

      procedure Extraer_Columna (C: Indices.Indice) is
      begin
         for F in Indices.Indice loop
            if not Casillas.Esta_Libre(M(F, C)) then
               Aux(F) := Casillas.Valor(M(F, C));
            end if;
         end loop;
      end Extraer_Columna;

      procedure Extraer_Zona (Ord: Indices.Indice) is

         Finicio : constant Indices.Indice := (Ord - 1) / 3 * 3 + 1;
         Cinicio : constant Indices.Indice := ((Ord - 1) mod 3) * 3 + 1;
         I : Integer;
      begin
         I := 1;
         for F in Finicio .. Finicio + 2 loop
            for C in Cinicio .. Cinicio + 2 loop
               if not Casillas.Esta_Libre(M(F, C)) then
                  Aux(I) := Casillas.Valor(M(F,C)); I := I + 1;
               end if;
            end loop;
         end loop;
      end Extraer_Zona;

   begin
      case Ids_Grupo_Casillas.Tipo(IG) is
         when Ids_Grupo_Casillas.Fila => Extraer_Fila(Ids_Grupo_Casillas.Orden(IG)) ;-- obtiene datos de fila
         when Ids_Grupo_Casillas.Columna => Extraer_Columna(Ids_Grupo_Casillas.Orden(IG)) ;-- obtiene datos de columna
         when Ids_Grupo_Casillas.Zona => Extraer_Zona(Ids_Grupo_Casillas.Orden(IG)) ;-- obtiene datos de zona cuadrada
      end case;
      for I in Aux'range loop --1 .. 9 loop
         for J in Aux'range loop --1 .. 9 loop
            if (Aux(I) /= 0) and (I /= J) then
               if Aux(I) = Aux(J) then return True;
               end if;
            end if;
         end loop;
      end loop;
      return False;
   end Hay_Inconsistencias;

end Matrices_Casillas;