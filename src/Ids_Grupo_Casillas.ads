with Indices;
package Ids_Grupo_Casillas is

   type Id_Grupo is private;
   type Tipo_Grupo is (Fila, Columna, Zona);

   function Nuevo (TP : in Tipo_Grupo;
                   Id : in Indices.Indice) return Id_Grupo;
   -- Entrada: M, objeto de Tipo_Grupo y O, valor de tipo Indice
   -- Salida: Objeto de tipo Id_Grupo
   -- Efecto: Se crea el objeto de tipo Id_Grupo correspondiente a M y O
   -- Nota: La primera fila, la septima columna o el noveno cuadrado
   --         son ejemplos de los objetos Id_Grupo que se pueden crear

   function Tipo (IG : in Id_Grupo) return Tipo_Grupo;
   -- Entrada: A, objeto de tipo Id_Grupo
   -- Salida: el Tipo_Area que le corresponde a A

   function Orden (IG : in Id_Grupo) return Indices.Indice;
   -- Entrada: A, objeto de tipo Id_Grupo
   -- Salida: El orden que le corresponde a A (un número entre 1 y 9)

private
   type Id_Grupo is
      record
         Tipo: Tipo_Grupo;
         Orden: Indices.Indice;
      end record;
end Ids_Grupo_Casillas;

