
with GWindows.Colored_Control_Window;
with Gwindows.Drawing_Panels;

package Casillas_Iconos is

   type Casilla is new Gwindows.Drawing_Panels.Drawing_Panel_Type with private;

   procedure Crear
     (Fila, Col : in Positive;
      Superior, Izquierda : in Natural;
   
      Ventana :
      in out GWindows.Colored_Control_Window.Colored_Control_Window_Type;
      C : out Casilla);
   -- Entrada: Fila Coordenada de la fila
   --          Col Coordenada de la columna
   --          Superior, margen que hay que dejar en la parte superior de la matriz
   --          Izquierda, margen que hay que dejar en la parte izquierda de la matriz
   --          Ventana, Donde hay que crear la casilla
   -- Salida: C Casilla
   --          Ventana, Despues de crear la casilla
   -- Efecto:  Crea una casilla de 25x25 en las coordenadas Fila, Columna
   
   function Fila (C : in Casilla) return Positive;
   -- Entrada: C Casilla
   -- Salida: La coordenada de la fila de la casilla
   
   function Col (C : in Casilla) return Positive;
   -- Entrada: C Casilla
   -- Salida: La coordenada de la columna de la casilla

   function Fich_Icono (C : in Casilla) return String;
   -- Entrada: C Casilla
   -- Salida: el nombre del fichero del icono que está en la casilla
   
   procedure Dibujar_Icono (C : in out Casilla; Fich_Icono : in String);
   -- Entrada: C Casilla
   --          Fich_Icono, nombre del fichero del icono
   -- Salida: C Casilla donde se ha dibujado el icono que hay en el fichero

   procedure Deshabilitar (C : in out Casilla);
   -- Entrada: C Casilla
   -- Salida: C Casilla
   -- Efecto: Deshabilita la casilla C para que no se pueda clickar

   function Esta_Habilitado (C : in Casilla) return Boolean;

private
   type Punt_Icono_Fich is access String;
   type Casilla is new Gwindows.Drawing_Panels.Drawing_Panel_Type with
      record
         Fila, Col : Positive;
         Puntero_Icono_Fich : Punt_Icono_Fich;
         Habilitado : Boolean := True;
      end record;
end Casillas_Iconos;
