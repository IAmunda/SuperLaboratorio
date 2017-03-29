package body Ids_Grupo_Casillas is

   function Nuevo (TP : in Tipo_Grupo;
                   Id : in Indices.Indice) return Id_Grupo is
   begin
      return (Tipo => TP, Orden => Id);
   end Nuevo;

   function Tipo (IG : in Id_Grupo) return Tipo_Grupo is
   begin
      return IG.Tipo;
   end Tipo;

   function Orden (IG : in Id_Grupo) return Indices.Indice is
   begin
      return IG.Orden;
   end Orden;

end Ids_Grupo_Casillas;
