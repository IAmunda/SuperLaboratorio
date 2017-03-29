

package body Casillas is

   procedure Crear (C: out Casilla) is
   begin
      C.Libre:= true;
      C.Inicial:= false;
  end Crear;

   function Esta_Libre (C: Casilla) return Boolean  is
   begin
      if C.Libre then
         return true;
      else
         return False;
      end if;
   end Esta_Libre;

   function Es_Inicial (C: Casilla) return Boolean is
   begin
      if C.Inicial then
         return True;
      else
         return False;
         end if;
      end Es_Inicial;

      function Valor (C: Casilla) return Numeros.Numero is
      begin
         return C.Valor;
      end Valor;

   procedure Asignar_Valor(C: in out Casilla;     V: in Numeros.Numero) is
   begin
      if C.Inicial = false then
         C.Valor := V;
      end if;
   end Asignar_Valor;

   procedure Asignar_Valor_Inicial(C: in out  Casilla;  V: in Numeros. Numero) is
      begin
      C.Inicial:= true;
      C.Libre:= false;
         C.Valor := V;
   end Asignar_Valor_Inicial;

   procedure Quitar_Valor (C: in out Casilla) is
   begin

      C.Libre:= true;

   end Quitar_Valor;

   end Casillas;


