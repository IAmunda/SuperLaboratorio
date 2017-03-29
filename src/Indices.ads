package Indices is

   subtype Indice is Positive range 1 .. 9;
   Num_Filas : constant Indice := Indice'Last;
   Num_Columnas : constant Indice := Indice'Last;

end Indices;
