with GWindows.Windows;
with GWindows.Buttons;
with GWindows.Static_Controls;
with GWindows.Base;
with GWindows.Application;
with GWindows.Constants;
with GWindows.List_Boxes;

package body Lista_Jugadores.Interfaz is

   -- Dialog y controles para mostrar el panel de los mejores ---------------
   Panel: GWindows.Windows.Window_Type;
   Caja_Nombres : GWindows.List_Boxes.List_Box_Type;
   Boton_Aceptar : GWindows.Buttons.Button_Type;


   -- operaciones de eventos-------------------------------------------

   procedure Aceptar
      (Ventana : in out Gwindows.Base.Base_Window_Type'Class) is
   begin
      GWindows.Windows.End_Dialog (Panel, GWindows.Constants.IDOK);
   end Aceptar;


   -- operaciones públicas -------------------------------------------

   procedure Crear_Panel_Mejores is
   begin
      GWindows.Windows.Create_as_Dialog
         (Panel, "SUDOKU: Los mejores!",
          Width => 300, Height => 300);  --- cambio 275 por 300
      Gwindows.Static_Controls.Create_Label
         (Panel, "Los 10 mejores jugadores son:",
          Left => 10, Top => 10,
          Width => Gwindows.Windows.Client_Area_Width (Panel) - 20,
          Height => 25,
          Alignment => Gwindows.Static_Controls.Center);
      GWindows.List_Boxes.Create
         (List => Caja_Nombres,
          Parent => Panel,
          Left => 10,
          Top => 40,
          Width => Gwindows.Windows.Client_Area_Width (Panel) - 20,
          Height => 185);
      GWindows.Buttons.Create
         (Boton_Aceptar, Panel, "&Aceptar",
          Left => 112, Top => 215, Width => 75, Height => 25);

      Gwindows.Buttons.On_Click_Handler (Boton_Aceptar,
                                         Aceptar'Unrestricted_Access);
   end Crear_Panel_Mejores;

   procedure Anadir_Fila_Panel (Jugador : in String;
                                     Puntos : in Integer;
                                     Posicion : in Positive) is
   begin
      GWindows.List_Boxes.Add
         (Caja_Nombres,
          Posicion,
          Integer'Image (Puntos) & "  " & Jugador);
   end Anadir_Fila_Panel;

   procedure Ver_Panel_Mejores is
   begin
      GWindows.Application.Show_Dialog (Panel);
   end Ver_Panel_Mejores;

end Lista_Jugadores.Interfaz;
