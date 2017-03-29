with Ada.Unchecked_Deallocation;
package body Palabras is

   procedure Liberar_Palabra is new Ada.Unchecked_Deallocation
             (Object => String,
              Name => Palabra);

   procedure Crear (P: out Palabra; S: String) is
   begin
      P := new String'(S);
   end Crear;
      
   function Valor (P: Palabra) return String is
   begin
      return P.all;
   exception
      when Constraint_Error => raise Sin_Inicializar;
   end Valor;
   
   function Longitud (P: Palabra) return Positive is
   begin
      return P.all'Length;
   exception
      when Constraint_Error => raise Sin_Inicializar;
   end Longitud;
   
   function "<" (P1, P2: Palabra) return Boolean is
   begin
      return P1.all < P2.all;
   exception
      when Constraint_Error => raise Sin_Inicializar;
   end "<";
   
   function "=" (P1, P2: Palabra) return Boolean is
   begin 
       If P1.all'Length /= P2.all'Length 
       then return false;
       else return P1.all = P2.all;
       end if;
   exception
      when Constraint_Error => raise Sin_Inicializar;
   end "=";
   
   function Identidad (P1: Palabra) return Palabra is
   begin
      return P1;
   end Identidad;

   procedure Copiar (P1: out Palabra; P2: Palabra) is
   begin
      P1 := new String'(P2.all);
   exception
      when Constraint_Error => raise Sin_Inicializar;
   end Copiar;

   procedure Liberar (P1: in out Palabra) is
   begin
      Liberar_Palabra(P1);
   end Liberar;
   
end Palabras;
