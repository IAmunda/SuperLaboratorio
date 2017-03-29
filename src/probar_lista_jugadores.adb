with Jugadores, Ada.Text_IO, Ada.Integer_Text_IO;
with Lista_Jugadores;
procedure Probar_Lista_Jugadores is
   J1: Jugadores.Jugador;
   Nombre: String(1..80) := (others => ' ');
   N, Puntos: Integer;

begin
   Ada.Text_Io.Put_Line ("Empezamos");
   Lista_Jugadores.Inicializar;
   Ada.Text_Io.Put_Line
      ("Escriba el nombre de cada jugador y sus puntos en lineas diferentes,");
   Ada.Text_Io.Put_Line("acabe la entrada con la palabar FIN");
   while Nombre(1..3) /= "FIN" loop
      Ada.Text_Io.Put_Line("VA A LEER UN JUGADOR");
      Ada.Text_Io.Get_Line(Nombre, N);
      if Nombre(1..3) /= "FIN" then
         Ada.Integer_Text_Io.Get(Puntos);  Ada.Text_Io.Skip_Line;
         Jugadores.Crear(Nombre(1..N), J1);
         Jugadores.Actualizar_Puntos(J1, Puntos);
         Ada.Text_Io.Put_Line("HA CREADO UN JUGADOR");
         Lista_Jugadores.Anadir_Jugador(J1);
         Ada.Text_Io.Put_Line("ANADE EL JUGADOR A LA LISTA");
      end if;
   end loop;

   Ada.Text_Io.Put_Line("Va a visualizar la lista");
   Lista_Jugadores.Visualizar;
   Ada.Text_Io.Put_Line("Va a guardar la lista");
   Lista_Jugadores.Guardar;
   Ada.Text_Io.Put_Line("fin total");

end Probar_Lista_Jugadores;


