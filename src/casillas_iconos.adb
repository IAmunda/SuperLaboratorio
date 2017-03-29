with Coleccion_Iconos, Punteros_Iconos;
package body Casillas_Iconos is

   Canvas : GWindows.Drawing_Panels.Drawing_Canvas_Type;


   -- metodos adicionales (privados)

   procedure Obtener_Canvas
      (C : in Casilla;
       Canvas : in out GWindows.Drawing_Panels.Drawing_Canvas_Type) is
   begin
      Get_Canvas (Window => C, Canvas => Canvas);
   end Obtener_Canvas;

   procedure Actualizar_Imagen (C : in out Casilla) is
   begin
      Redraw
         (Window => C,
          Erase => False,
          Redraw_Now => True);
   end Actualizar_Imagen;

----------20030513
   procedure Liberar_Canvas
     (Canvas : in out GWindows.Drawing_Panels.Drawing_Canvas_Type) is
   begin
      GWindows.Drawing_Panels.Release (Canvas => Canvas);
   end Liberar_Canvas;
----------20030513


   -- Metodos publicos

   procedure Crear
     (Fila, Col : in Positive;
      Superior, Izquierda : in Natural;

      Ventana :
      in out GWindows.Colored_Control_Window.Colored_Control_Window_Type;
      C : out Casilla) is
      Icono_vacio : Punteros_Iconos.Puntero_Icono;
   begin
      Create_as_Control (Window => C,
                         Parent => Ventana,
                         Left => Izquierda + (Col - 1) * 25,
                         Top => Superior + ((Fila - 1) * 25),
                         Width => 25,
                         Height => 25);
      Border (C, True);
      C.Fila := Fila;
      C.Col := Col;
      C.Puntero_Icono_Fich := new String'(Coleccion_Iconos.Fich_Fondo_Vacio);
      C.Habilitado := True;

     
      Get_Canvas (C, Canvas);
      Coleccion_Iconos.Obtener_Objeto_Icono
         (C.Puntero_Icono_Fich.all, Icono_vacio);
      GWindows.Drawing_Panels.Paint_Icon
         (Canvas,
          Icono_vacio.all,
          -6,
          -5);
      Actualizar_Imagen (C);
   end Crear;

   function Fila (C : in Casilla) return Positive is
   begin
      return C.Fila;
   end Fila;

   function Col (C : in Casilla) return Positive is
   begin
      return C.Col;
   end Col;

   function Fich_Icono (C : in Casilla) return String is
   begin
      return C.Puntero_Icono_Fich.all;
   end Fich_Icono;

   procedure Dibujar_Icono (C : in out Casilla; Fich_Icono : in String) is
      Icono : Punteros_Iconos.Puntero_Icono;
   begin
      Coleccion_Iconos.Obtener_Objeto_Icono (Fich_Icono, Icono);
      Obtener_Canvas (C, Canvas);
      GWindows.Drawing_Panels.Paint_Icon (Canvas, Icono.all, -6, -5);
      Actualizar_Imagen (C);
      Liberar_Canvas (Canvas);
      C.Puntero_Icono_Fich := new String'(Fich_Icono);
   end Dibujar_Icono;

   procedure Deshabilitar (C : in out Casilla) is
   begin
   
      C.Habilitado := False;
   end Deshabilitar;

   function Esta_Habilitado (C : in Casilla) return Boolean is
   begin
      return C.Habilitado;
   end Esta_Habilitado;

end Casillas_Iconos;
