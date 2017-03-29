with Ids_Grupo_casillas;
private
package Tablero.Interfaz is

   type Tipo_Mensaje is (Error, Informacion);

   procedure Visualizar (Nombre_Jugador : in String;
                        Identificador_Sudoku : in String;
                        Dificultad_Sudoku : in Positive);
   -- Entrada: Strings con el nombre del jugador y el identificador del sudoku
   --          numero positivo con la dificultad del sudoku
   -- Efecto: Inicializa la interfaz grafica con los valores dados
    -- Nota:  No visualiza los valores iniciales

   procedure Visualizar_Valor_Inicial
     (Fila, Col : in Indices.Indice;
      Valor : in Numeros.Numero);
   -- Entrada: Fila, numero de fila
   --          Col, numero de columna
   -- Efecto: Muestra (en negro) el valor de la casilla (Fila, Col)

   procedure Comenzar;
   -- Efecto: Da comienzo a la captura de eventos
   --          de la interfaz grafica

   procedure Marcar_Grupo (IG : in Ids_Grupo_casillas.Id_Grupo);
   -- Entrada: IG Grupo_casillas (Fila, Columna o Zona y su Orden)
   -- Efecto: Marca el grupo IG de rojo

   procedure Visualizar_Etiqueta_Inconsistencias;
   -- Efecto: Muestra la etiqueta que avisa de la existencia
   --          de inconsistencias

   procedure Visualizar_Etiqueta_Errores
     (Cantidad_Errores : in Natural);
   -- Entrada: Cantidad_Errores, numero de valores mal colocados
   -- Efecto: Muestra la etiqueta de errores indicando que hay tantos
   --          errores como digamos en Cantidad_Errores

   procedure Mostrar_Mensaje (Mensaje : in String;
                           Tipo : in Tipo_Mensaje := Informacion);
   -- Entrada: Mensaje string
   --          Tipo, tipo del mensaje (error, informacion)
   -- Efecto: Muestra el mensaje en un cuadro de texto,
   --          con el icono que le corresponda segun el tipo de mensaje

   procedure Refrescar;
   -- Efecto: Borra las etiquetas de errores e inconsistencias
   --          e inicializa los fondos de las casillas


   procedure Liberar;
   -- Efecto: Libera los recursos de memoria reservados por la interfaz
   -- Nota: este procedimiento solo sera llamado al destruir el tablero


end Tablero.Interfaz;
