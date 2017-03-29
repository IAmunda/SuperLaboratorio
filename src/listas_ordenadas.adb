with Ada.Unchecked_Deallocation;
--  with Ada.Text_Io;
package body Listas_Ordenadas is

   procedure Liberar_Nodo is new Ada.Unchecked_Deallocation (
                                 Object => Nodo,
                                 Name   => Lista);

   procedure Crear_Vacia (L : out Lista) is
   begin
      L := null;
   end Crear_Vacia;

   procedure Colocar (L : in out Lista; E : in Componente) is
      Aux : Lista;
      C1, C2  : Clave;
   begin
      if L = null then
           L := new Nodo;
           Copiar(L.Info, E);
           L.Siguiente := null;
      else
         Obtener_Clave(E, C1);
         Obtener_Clave(L.Info, C2);
         if Mayor_Clave(C1, C2)then
            Aux := L;
            L := new Nodo;
            Copiar(L.Info, E);
            L.Siguiente := Aux;  -- Colocar al comienzo
         else
            Colocar (L.Siguiente, E);
         end if;
      end if;
   exception
      when Storage_Error => raise Lista_Llena;
   end Colocar;

   procedure Obtener_Primero (L : in Lista; P : out Componente) is
   begin
      if L = null then raise Lista_Vacia;
      else Copiar(P, L.Info);
      end if;
   end Obtener_Primero;

   function Resto (L : in Lista) return Lista is
   begin
      if L = null then raise Lista_Vacia;
      else return L.Siguiente;
      end if;
   end Resto;

   function Esta (L : in Lista; C : in Clave) return Boolean is
      C1: Clave;
   begin
      if L = null then return False;
      end if;
      Obtener_Clave(L.Info, C1);
      if Igual(C1, C) then return True;
      else return Esta (L.Siguiente, C);
      end if;
   end Esta;

   procedure Borrar_Primero (L : in out Lista) is
      Aux : Lista := L;
   begin
      if L = null then raise Lista_Vacia;
      else L := L.Siguiente;
      end if;
      Liberar_Nodo (Aux);
   end Borrar_Primero;

   function Sublista (L : in Lista; C : in  Clave) return Lista is
      L_Aux : Lista;
      La_Clave: Clave;
   begin -- solucion recursiva
      if L = null then return null;
      else
         Obtener_Clave(L.Info, La_Clave);
         if Igual(La_Clave, C) then
            L_Aux := new Nodo;
            Copiar(L_Aux.Info, L.Info);
            L_Aux.Siguiente := Sublista (L.Siguiente, C);
            return L_Aux;
         else return Sublista (L.Siguiente, C);
         end if;
      end if;
   end Sublista;

   function Es_Vacia (L : in Lista) return Boolean is
   begin
      return L = null;
   end Es_Vacia;

   function "=" (L1, L2 : in Lista) return Boolean is
      Aux1 : constant Apuntador_Nodo := Apuntador_Nodo (L1);
      Aux2 : constant Apuntador_Nodo := Apuntador_Nodo (L2);
   begin
      if Aux1 = null
      then
         if Aux2 = null then return True;
         else return False;
         end if;
      else
         if Aux2 = null then return False;
         else
            return Igual(Aux1.Info, Aux2.Info) and
                   (L1.Siguiente = L2.Siguiente); -- Llamada recursiva!
         end if;
      end if;
   end "=";

   procedure Copiar (L1 : out Lista; L2 : in Lista) is
      Aux1, Aux2 : Lista;
   begin
      if L2 = null then L1 := null;
      else
         L1 := new Nodo;
         Copiar (L1.Info, L2.Info);
         L1.Siguiente := null; -- Primer nodo
         Aux1 := L1;
         Aux2 := L2.Siguiente;
         while Aux2 /= null loop
            Aux1.Siguiente := new Nodo;
            Copiar (Aux1.Siguiente.Info, Aux2.Info);
            Aux1.Siguiente.Siguiente := null;
            Aux1 := Aux1.Siguiente;
            Aux2 := Aux2.Siguiente;
         end loop;
      end if;
   end Copiar;

   procedure Liberar (L : in out Lista) is
      Aux : Lista := L;
   begin
      while Aux /= null loop
         L := L.Siguiente;
         Liberar_Nodo (Aux);
         Aux := L;
      end loop;
   end Liberar;

end Listas_Ordenadas;








