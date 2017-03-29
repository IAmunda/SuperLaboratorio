private package Lista_Jugadores.Interfaz is

   procedure Crear_Panel_Mejores;
   -- Efecto: Crea el panel de mejores y lo inicializa

   procedure Anadir_Fila_Panel (Jugador : in String;
                                     Puntos : in Integer;
                                     Posicion : in Positive);
   -- Entrada: Jugador: El identificador del jugador
   --          Puntos: Los puntos del Jugador
   --          Posicion: La posicion del jugador en el panel de mejors
   -- Efecto:   Añade en el panel de mejores,
   --         en la posición correspondiente, una línea con
   --          los puntos y el identificador del jugador


   procedure Ver_Panel_Mejores;
   -- Efecto: Muestra el panel de los mejores

end Lista_Jugadores.Interfaz;
