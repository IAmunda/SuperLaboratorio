with Matrices_Casillas, Ids_Grupo_Casillas, Casillas, Indices;
with Numeros;
with Ada.Text_IO;
procedure Probar_Matrices_casillas is
   M : Matrices_casillas.Matriz;
   F_Prueba : Ada.Text_IO.File_Type;
   Cas : Casillas.Casilla;
   IG : Ids_Grupo_Casillas.Id_Grupo;

   -- Entrada: M Matriz
   -- Efecto: Escribe la matriz por la salida estandard
   -- Nota:  La siguiente implementación se ha construido especialmente
   --         para esta prueba. Una operación de este tipo debería estar
   --         incluida en el propio paquete Matrices_Casilla, pero como
   --         allí no hace falta, se ha implementado aquí

   procedure Escribir_Matriz (M : in Matrices_casillas.Matriz) is
   begin
      for F in Indices.Indice loop
         for C in Indices.Indice loop
            if Casillas.Esta_Libre (Matrices_casillas.Casilla (M, F, C)) then
              Ada.Text_IO.Put ('0');
            else
              Ada.Text_IO.Put(Numeros.Numero'Image
              (Casillas.Valor(Matrices_casillas.Casilla (M, F, C))) (2));
            end if;
         end loop;
         Ada.Text_IO.New_Line;
      end loop;
   end Escribir_Matriz;

begin
   Ada.Text_IO.Open (F_Prueba, Ada.Text_IO.In_File, "matrices_de_prueba.txt");

   -- Se carga la matriz inicial (primera matriz del fichero)
   Matrices_casillas.Leer_Inicial (F_Prueba, M);

   -- Se imprime la matriz leida
   Ada.Text_IO.Put_Line
     ("Esta es la primera matriz leida (Comprueba que es correcta");
   Ada.Text_IO.Put_Line("comparandola con la primera matriz " &
                          "del fichero 'prueba_matrices.txt'):");
   Ada.Text_IO.New_Line;
   Escribir_Matriz (M);
   Ada.Text_IO.New_Line (2);

   -- Salta la linea en blanco que separa las matrices en el fichero
   Ada.Text_IO.Skip_Line (F_Prueba);

   -- Se carga la matriz final (segunda matriz del fichero)
   Matrices_casillas.Leer_Final (F_Prueba, M);

   -- Se imprime la matriz leida
   Ada.Text_IO.Put_Line
     ("Esta es la segunda matriz leida (Comprueba que es correcta");
   Ada.Text_IO.Put_Line("comparandola con la segunda matriz " &
                          "del fichero 'prueba_matrices.txt')");

   Ada.Text_IO.New_Line;
   Escribir_Matriz (M);
   Ada.Text_IO.New_Line (2);
   --end loop;

   -- Cerrar fichero
   Ada.Text_IO.Close (F_Prueba);

   -- Llenar la matriz de 9s e imprimir de nuevo
   Casillas.Asignar_Valor (Cas, 9);
   for F in Indices.Indice loop
      for C in Indices.Indice loop
         Matrices_casillas.Copiar_Casilla (M, F, C, Cas);
      end loop;
   end loop;
   Ada.Text_IO.Put_Line ("Matriz llena de 9's:");
   Ada.Text_IO.New_Line;
   Escribir_Matriz (M);
   Ada.Text_IO.New_Line (2);

   -- Se rellena la tercera fila de la matriz con los numeros del 1 al 9,
   -- y se imprime
   for C in Indices.Indice loop
      Casillas.Asignar_Valor (Cas, C);
      Matrices_casillas.Copiar_Casilla (M, 3, C, Cas);
   end loop;
   Ada.Text_IO.Put_Line ("La matriz con la tercera fila modificada:");
   Ada.Text_IO.New_Line;
   Escribir_Matriz (M);
   Ada.Text_IO.New_Line (2);

   -- Buscar e imprimir inconsistencias
   Ada.Text_IO.Put_Line
     ("La matriz, quitando la tercera fila, esta llena de 9's. ");
   Ada.Text_IO.Put_Line("Por lo tanto, hay inconsistencias en todas las columnas, en todas las ");
   Ada.Text_IO.Put_Line("zonas cuadradas y en todas la filas menos la tercera.");
   Ada.Text_IO.Put_Line("Compruebalo con el resultado que aparece a continuacion.");
   Ada.Text_IO.New_Line;
   for T_grupo in Ids_Grupo_Casillas.Tipo_Grupo loop
      for Ord in Indices.Indice loop
         IG := Ids_Grupo_Casillas.Nuevo (T_grupo, Ord);
         begin
            if Matrices_casillas.Hay_Inconsistencias (M, IG) then
               Ada.Text_IO.Put ("HAY INCONSISTENCIA EN");
            else
               Ada.Text_IO.Put("NO HAY INCONSISTENCIAS EN");
            end if;
            Ada.Text_IO.Put_Line
              (Indices.Indice'Image(Ids_Grupo_Casillas.Orden (IG)) & ". " &
                 Ids_Grupo_Casillas.Tipo_Grupo'Image
                 (Ids_Grupo_Casillas.Tipo(IG)));
         end;
      end loop;
   end loop;
   Ada.Text_IO.New_Line (2);

   Ada.Text_IO.Put_Line ("Fin de la prueba del paquete matrices_casillas!");


exception
   when Matrices_casillas.Error_de_Lectura =>
      Ada.Text_IO.Put_Line ("Error al leer la matriz");
   when Matrices_casillas.Numero_Erroneo =>
      Ada.Text_IO.Put_Line ("Error: algun numero incorrecto en la matriz");
end Probar_Matrices_casillas;
