
with Gwindows.Windows;
with GWindows.Menus;

with GWindows.Static_Controls;
with GWindows.Registry;
with GWindows.Drawing;
with GWindows.Drawing_Objects;
with GWindows.Colored_Control_Window;
with GWindows.Colors;
with GWindows.Buttons;
with GWindows.Base;
with GWindows.Application;
with GWindows.Message_Boxes;

with Casillas_Iconos, Coleccion_Iconos;
with Ada.Strings.Fixed;

package body Tablero.Interfaz is

   -- NOTA: ESTE PAQUETE DE INTERFAZ NO ES GENERAL.
   --         DAMOS POR HECHO QUE LOS INDICES DE LA MATRIZ VAN DE 1 A 9
   --         Y QUE SE VAN A UTILIZAR LOS ICONOS DE NUMEROS.
   --         EL HACERLO MAS GENERAL SUPONDRIA MUCHAS MAS DEPENDENCIAS

--   Directorio_Actual : constant String := GWindows.Registry.Current_Directory; ////////////////////////

   -- ventana principal y sus controles ----------------------


   Ventana_Principal : GWindows.Colored_Control_Window.Colored_Control_Window_Type;

   Etiqueta_Jugador:
      GWindows.Colored_Control_Window.Colored_Label_Type;
   Etiqueta_Sudoku : GWindows.Static_Controls.Label_Type;


   Imagen : GWindows.Drawing_Objects.Bitmap_Type;
   Control_Imagen : GWindows.Static_Controls.Bitmap_Type;

   Menu_Numeros : constant GWindows.Menus.Menu_Type := GWindows.Menus.Create_Popup;
   Borrar_ID : constant := 100;
   Boton_Abandonar, Boton_Ayuda : GWindows.Buttons.Button_Type;

   -- variables de estado-----------------------------------------

   Matriz_Casillas_Iconos :
     array (Indices.Indice, Indices.Indice) of
         Casillas_Iconos.Casilla;

   Espacio_Izquierdo : Positive := 140; --anchura del panel lateral
   Espacio_Superior : Positive := 50; --margen superior
   Espacio_Entre_Areas : constant Positive := 3;

   Anchura_Tablero_Casillas :
   constant Natural := Indices.Num_columnas * 33+
     Espacio_Entre_Areas * 2;
   Altura_Tablero_Casillas :
   constant Natural := 40 + (Indices.Num_Filas * 33) +
     Espacio_Entre_Areas * 2;


   -- metodos adicionales -----------------------------------

   procedure Terminar (Ventana : in out GWindows.Base.Base_Window_Type'Class) is
   begin

         GWindows.Colored_Control_Window.Hide (Ventana_Principal);

         GWindows.Application.End_Loop;
   end Terminar;


   -- metodos adicionales ------------

   procedure Ayuda
      (Ventana : in out Gwindows.Base.Base_Window_Type'Class) is
   begin
	Tablero.Ayudar;
   end Ayuda;

   procedure Abandonar
      (Ventana : in out Gwindows.Base.Base_Window_Type'Class) is
      Respuesta : GWindows.Message_Boxes.Message_Box_Result;
      use type GWindows.Message_Boxes.Message_Box_Result;
   begin
      if Tablero.Solucion_Correcta then
         GWindows.Colored_Control_Window.Close (Ventana_Principal);
      else
         Respuesta := GWindows.Message_Boxes.Message_Box
           ("SUDOKU",
            "El Sudoku no esta completo todavia. " &
            "¿Deseas abandonarlo en el estado actual?",
            GWindows.Message_Boxes.Yes_No_Box,
            GWindows.Message_Boxes.Question_Icon);
         if Respuesta = GWindows.Message_Boxes.Yes then
            GWindows.Colored_Control_Window.Close (Ventana_Principal);
         else
            null;
         end if;
      end if;
   end Abandonar;

   procedure Menu_Opcion_Borrar (Habilitar : in Boolean) is
   begin
      if Habilitar then
         GWindows.Menus.State
           (Menu => Menu_Numeros,
            Locate_By => GWindows.Menus.Command,
            Locate_At => 100,
            State => GWindows.Menus.Enabled);
      else
         GWindows.Menus.State
           (Menu => Menu_Numeros,
            Locate_By => GWindows.Menus.Command,
            Locate_At => 100,
            State => GWindows.Menus.Disabled);
         GWindows.Menus.State
           (Menu => Menu_Numeros,
            Locate_By => GWindows.Menus.Command,
            Locate_At => 100,
            State => GWindows.Menus.Grayed);
      end if;
   end Menu_Opcion_Borrar;

   procedure Menu_Opcion_Numeros (Habilitar : in Boolean) is
   begin
      if Habilitar then
         for I in 101 .. 109 loop
            GWindows.Menus.State
               (Menu => Menu_Numeros,
                Locate_By => GWindows.Menus.Command,
                Locate_At => I,
                State => GWindows.Menus.Enabled);
         end loop;
      else
         for I in 101 .. 109 loop
            GWindows.Menus.State
               (Menu => Menu_Numeros,
                Locate_By => GWindows.Menus.Command,
                Locate_At => I,
                State => GWindows.Menus.Disabled);
            GWindows.Menus.State
               (Menu => Menu_Numeros,
                Locate_By => GWindows.Menus.Command,
                Locate_At => I,
                State => GWindows.Menus.Grayed);
         end loop;
      end if;
   end Menu_Opcion_Numeros;

   procedure Ver_Numero (Fila, Col  : in Indices.Indice;
                         Valor : in Numeros.Numero) is
      Nombre_Fich_Iconos : constant String :=
        "i" & Numeros.Numero'Image (Valor) (2);

   begin
      Casillas_Iconos.Dibujar_Icono
        (Matriz_Casillas_Iconos (Fila, Col),
         Nombre_Fich_Iconos &
         "_.ico"); -- no es un valor inicial, aparecera en azul
   end Ver_Numero;

   -- este metodo no es publico
   procedure Esconder_Numero
     (Fila, Col : in Indices.Indice) is

   begin
      Casillas_Iconos.Dibujar_Icono
        (Matriz_Casillas_Iconos (Fila, Col), Coleccion_Iconos.Fich_Fondo_Vacio);
   end Esconder_Numero;

   procedure Clickar_Casilla
      (Casilla : in out GWindows.Base.Base_Window_Type'Class;
       Pixel_X, Pixel_Y : in Integer;
       Tecla : in GWindows.Windows.Mouse_Key_States)  is
      Fila_Casillas : constant Positive :=
         Casillas_Iconos.Fila (Casillas_Iconos.Casilla (Casilla));
      Columna_Casillas : constant Positive :=
        Casillas_Iconos.Col (Casillas_Iconos.Casilla (Casilla));
      Icono_de_Casilla : constant String :=
        Casillas_Iconos.Fich_Icono (Casillas_Iconos.Casilla (Casilla));
   begin --clickar una casilla
      if Tecla (GWindows.Windows.Left_Button) and
         not Tecla (GWindows.Windows.Right_Button) then
         if Casillas_Iconos.Esta_Habilitado (Casillas_Iconos.Casilla (Casilla)) then
            if (Icono_de_Casilla /= Coleccion_Iconos.Fich_Fondo_Vacio) and
              (Icono_de_Casilla /= Coleccion_Iconos.Fich_Fondo_Marcado) then
               -- se ve un numero y se va a esconder
               Esconder_Numero
                 (Fila => Fila_Casillas,
                  Col => Columna_Casillas);
               -- al esconderlo de la interfaz hay que quitarlo del tablero
               Tablero.Borrar_Numero (Fila_Casillas, Columna_Casillas);
            end if;
         end if;
      else
         null;
      end if;
   end Clickar_Casilla;

   procedure Elegir_Menu
     (Casilla : in out GWindows.Base.Base_Window_Type'Class;
      Opcion : in Integer) is
      Fila_Casillas : constant Positive :=
         Casillas_Iconos.Fila (Casillas_Iconos.Casilla (Casilla));
      Columna_Casillas : constant Positive :=
         Casillas_Iconos.Col (Casillas_Iconos.Casilla (Casilla));
      Icono_de_Casilla : constant String :=
        Casillas_Iconos.Fich_Icono (Casillas_Iconos.Casilla (Casilla));
   begin
      if (Icono_de_Casilla /= Coleccion_Iconos.Fich_Fondo_Vacio) and
        (Icono_de_Casilla /= Coleccion_Iconos.Fich_Fondo_Marcado) then

         Esconder_Numero (Fila => Fila_Casillas,
                            Col => Columna_Casillas);

         Tablero.Borrar_Numero (Fila_Casillas, Columna_Casillas);
      end if;
      if Opcion > 100 then
         Ver_Numero
            (Fila => Fila_Casillas,
             Col => Columna_Casillas,
             Valor => Opcion - 100);

         Tablero.Anotar_Numero (Fila_Casillas, Columna_Casillas, Opcion - 100);
      end if;
   end Elegir_Menu;

   procedure Mostrar_Menu
      (Casilla : in out GWindows.Base.Base_Window_Type'Class;
       Fila      : in     Integer;
       Col      : in     Integer)
   is
      Icono_de_Casilla : constant String :=
         Casillas_Iconos.Fich_Icono (Casillas_Iconos.Casilla (Casilla));
   begin
      -- segun el estado de la casilla habilitar/deshabilitar opciones
      if Casillas_Iconos.Esta_Habilitado (Casillas_Iconos.Casilla (Casilla)) then
         Menu_Opcion_Numeros (Habilitar => True);
         if (Icono_de_Casilla = Coleccion_Iconos.Fich_Fondo_Marcado) or
           (Icono_de_Casilla = Coleccion_Iconos.Fich_Fondo_Vacio) then
            Menu_Opcion_Borrar (Habilitar => False);
         else
            Menu_Opcion_Borrar (Habilitar => True);
         end if;
      else
         Menu_Opcion_Borrar (Habilitar => False);
         Menu_Opcion_Numeros (Habilitar => False);
      end if;
      Casillas_Iconos.Display_Context_Menu
         (Casillas_Iconos.Casilla (Casilla), Menu_Numeros, 0, Fila, Col);
   end Mostrar_Menu;

   procedure Inicializar_Fondo is
      procedure Inicializar_Fondo_Casilla
        (C : in out Casillas_Iconos.Casilla) is
         Icono_de_Casilla : constant String :=
           Casillas_Iconos.Fich_Icono (C); ---------------  C en lugar de Casillas_Iconos.Casilla (C)
      begin
         if (Icono_de_Casilla /= Coleccion_Iconos.Fich_Fondo_Vacio) and
           (Icono_de_Casilla /= Coleccion_Iconos.Fich_Fondo_Marcado) then
            --el numero esta de antes
            Casillas_Iconos.Dibujar_Icono
              (C, Coleccion_Iconos.Fich_Fondo_Vacio);
            Casillas_Iconos.Dibujar_Icono (C, Icono_de_Casilla);
         else
            Casillas_Iconos.Dibujar_Icono
              (C, Coleccion_Iconos.Fich_Fondo_Vacio);
         end if;
      end Inicializar_Fondo_Casilla;
   begin
      for I in Indices.Indice loop
         for J in Indices.Indice loop
            Inicializar_Fondo_Casilla (Matriz_Casillas_Iconos (I, J));
         end loop;
      end loop;
   end Inicializar_Fondo;


   --metodos publicos y alguno adicional -----------------

   procedure Visualizar (Nombre_Jugador : in String;
                        Identificador_Sudoku : in String;
                        Dificultad_Sudoku : in Positive) is

      procedure Crear_Etiqueta_Jugador
         (Nombre : in String;
          Izquierda : in Natural;

          Etiqueta : out GWindows.Colored_Control_Window.Colored_Label_Type) is
      begin

         GWindows.Colored_Control_Window.Create
            (Static => Etiqueta,
             Parent => Ventana_Principal,
             Text => "",
             Left => Izquierda,
             Top => 12,
             Width => 100,
             Height => 20,
             Alignment => GWindows.Static_Controls.Center);


         GWindows.Colored_Control_Window.Color
           (Label => Etiqueta,
            Color => GWindows.Colors.Green);

         GWindows.Colored_Control_Window.Text (Etiqueta, Nombre);


      end Crear_Etiqueta_Jugador;

      procedure Crear_Etiqueta_Sudoku
        (Texto : in String;
         Izquierda : in Natural;
         Etiqueta : out GWindows.Static_Controls.Label_Type) is
      begin
         GWindows.Static_Controls.Create
            (Static => Etiqueta,
             Parent => Ventana_Principal,
             Text => Texto,
             Left => Izquierda,
             Top => 12,
             Width => 100,
             Height => 20,
             Alignment => GWindows.Static_Controls.Center);

      end Crear_Etiqueta_Sudoku;

      procedure Crear_Paneles is
      begin

         GWindows.Static_Controls.Create
            (Static    => Control_Imagen,
             Parent    => Ventana_Principal,
             Text      => "",
             Left      => (Espacio_Izquierdo - 91) / 2,
             Top       => Espacio_Superior,
             Width     => 91,
             Height    => 135);
         GWindows.Static_Controls.Set_Bitmap (Control_Imagen, Imagen);
      end Crear_Paneles;

   begin


      GWindows.Colored_Control_Window.Create_as_Dialog
        (Ventana_Principal,
         "SUDOKU",
         Width => Espacio_Izquierdo + Anchura_Tablero_Casillas +
             Espacio_Izquierdo,
         Height => Espacio_Superior + Altura_Tablero_Casillas);

      GWindows.Colored_Control_Window.On_Destroy_Handler
         (Ventana_Principal, Terminar'Unrestricted_Access);



      --crear y mostrar etiquetas del jugador y el sudoku
      Crear_Etiqueta_Jugador (Nombre => Nombre_Jugador,
                              Izquierda => Espacio_Izquierdo,
                              Etiqueta => Etiqueta_Jugador);
      Crear_Etiqueta_Sudoku (Texto =>
                              Identificador_Sudoku & " / " &
                            Positive'Image
                              (Dificultad_Sudoku),
                            Izquierda =>
                              Espacio_Izquierdo + Anchura_Tablero_Casillas,
                            Etiqueta => Etiqueta_Sudoku);
      GWindows.Colored_Control_Window.Visible (Etiqueta_Jugador, True);
      GWindows.Static_Controls.Visible (Etiqueta_Sudoku, True);


      Crear_Paneles;


      for I in Indices.Indice loop
         for J in Indices.Indice loop
            Casillas_Iconos.Crear (I, J,
                                 Espacio_Superior,
                                 Espacio_Izquierdo, --por la izquierda
                                 Ventana_Principal,
                                 Matriz_Casillas_Iconos (I, J));

            Casillas_Iconos.On_Left_Mouse_Button_Down_Handler
              (Matriz_Casillas_Iconos (I, J),
               Clickar_Casilla'Unrestricted_Access);
            Casillas_Iconos.On_Context_Menu_Handler
              (Matriz_Casillas_Iconos (I, J),
               Mostrar_Menu'Unrestricted_Access);
            Casillas_Iconos.On_Menu_Select_Handler
              (Matriz_Casillas_Iconos (I, J),
               Elegir_Menu'Unrestricted_Access);
            if (J = 3) or (J = 6) then
               Espacio_Izquierdo := Espacio_Izquierdo + Espacio_Entre_Areas;
            end if;
        end loop;
        Espacio_Izquierdo := Espacio_Izquierdo - Espacio_Entre_Areas * 2;
        if (I = 3) or (I = 6) then
           Espacio_Superior := Espacio_Superior + Espacio_Entre_Areas;
        end if;
      end loop;

      GWindows.Buttons.Create
        (Boton_Ayuda, Ventana_Principal,
         "¿Que tal voy?",
         Left => Espacio_Izquierdo + Anchura_Tablero_Casillas + 5,
         Top => Espacio_Superior + Altura_Tablero_Casillas - 139,
         Width => 117,
         Height => 35);
      Gwindows.Buttons.On_Click_Handler (Boton_Ayuda,
                                         Ayuda'Unrestricted_Access);

      GWindows.Buttons.Create
        (Boton_Abandonar, Ventana_Principal,
         "&Terminar",
         Left => Espacio_Izquierdo + Anchura_Tablero_Casillas + 5,
         Top => Espacio_Superior + Altura_Tablero_Casillas - 89,
         Width => 117,
         Height => 35);
      Gwindows.Buttons.On_Click_Handler (Boton_Abandonar,
                                         Abandonar'Unrestricted_Access);

      GWindows.Colored_Control_Window.Visible (Ventana_Principal, True);

   end Visualizar;

   procedure Visualizar_Valor_Inicial
     (Fila, Col : in Indices.Indice;
      Valor : in Numeros.Numero) is
      Nombre_Fich_Iconos : constant String :=
        "i" & Numeros.Numero'Image (Valor) (2);

   begin
      Casillas_Iconos.Dibujar_Icono
        (Matriz_Casillas_Iconos (Fila, Col),
         Nombre_Fich_Iconos &
         ".ico"); --numero en negro, valor inicial
      Casillas_Iconos.Deshabilitar (Matriz_Casillas_Iconos (Fila, Col));

   end Visualizar_Valor_Inicial;

   procedure Comenzar is
   begin
      -- gestor de eventos principal.
      -- se ejecuta mientras dure el juego
      GWindows.Application.Message_Loop;
   end Comenzar;

   procedure Marcar_Grupo
     (IG : in Ids_Grupo_casillas.Id_Grupo) is

      Tipo : constant Ids_Grupo_casillas.Tipo_grupo := Ids_Grupo_casillas.Tipo (IG);
      Ord : constant Indices.Indice := Ids_Grupo_casillas.Orden (IG);

      procedure Marcar_Casilla
        (C : in out Casillas_Iconos.Casilla) is
         Icono_de_Casilla : constant String :=
           Casillas_Iconos.Fich_Icono (C);  ---- C en lugar de Casillas_Iconos.Casilla (C)
      begin
         if Icono_de_Casilla /= Coleccion_Iconos.Fich_Fondo_Vacio then
            --el numero esta de antes
            Casillas_Iconos.Dibujar_Icono
              (C, Coleccion_Iconos.Fich_Fondo_Marcado);
            Casillas_Iconos.Dibujar_Icono (C, Icono_de_Casilla); --poner numero
         else
            Casillas_Iconos.Dibujar_Icono
              (C, Coleccion_Iconos.Fich_Fondo_Marcado);
         end if;
      end Marcar_Casilla;
   begin
      case Tipo is
         when Ids_Grupo_casillas.Fila =>
            for J in Indices.Indice loop
               Marcar_Casilla(Matriz_Casillas_Iconos (Ord, J));
            end loop;
         when Ids_Grupo_casillas.Columna =>
            for I in Indices.Indice loop
               Marcar_Casilla(Matriz_Casillas_Iconos (I, Ord));
            end loop;
         when Ids_Grupo_casillas.Zona =>
            for I in ((Ord - 1) / 3) * 3 + 1 ..
              ((Ord - 1) / 3) * 3 + 3 loop
               for J in (Ord * 3 - 2) rem Indices.Indice'Last ..
                 (Ord * 3 - 2) rem Indices.Indice'Last + 2 loop
                  Marcar_Casilla (Matriz_Casillas_Iconos (I, J));
               end loop;
            end loop;
      end case;
   end Marcar_Grupo;

   procedure Visualizar_Etiqueta_Inconsistencias is
      Fich : GWindows.Drawing_Objects.Font_Type;
      Canvas : GWindows.Drawing.Canvas_Type;
   begin
      GWindows.Base.Get_Canvas
        (GWindows.Base.Base_Window_Type (Ventana_Principal), Canvas);
      GWindows.Drawing.Background_Mode (Canvas, GWindows.Drawing.Transparent);
      GWindows.Drawing_Objects.Create_Font (Fich, "Arial", 16);
      GWindows.Drawing.Select_Object (Canvas, Fich);
      GWindows.Drawing.Text_Color (Canvas, GWindows.Colors.Red);
      GWindows.Drawing.Put (Canvas, 450, 95, "Hay inconsistencias");
      Gwindows.Drawing.Put (Canvas, 450, 115, "en las zonas");
      GWindows.Drawing.Put (Canvas, 450, 135, "marcadas en rojo ");
      GWindows.Base.Redraw
        (Window => GWindows.Base.Base_Window_Type (Ventana_Principal),
         Erase => False,
         Redraw_Now => True);
   end Visualizar_Etiqueta_Inconsistencias;

   procedure Visualizar_Etiqueta_Errores
     (Cantidad_Errores : in Natural) is
      Fich : GWindows.Drawing_Objects.Font_Type;
      Canvas : GWindows.Drawing.Canvas_Type;
   begin
      GWindows.Base.Get_Canvas
        (GWindows.Base.Base_Window_Type (Ventana_Principal), Canvas);
      GWindows.Drawing.Background_Mode (Canvas, GWindows.Drawing.Transparent);
      GWindows.Drawing_Objects.Create_Font (Fich, "Arial", 16);
      GWindows.Drawing.Select_Object (Canvas, Fich);
      Gwindows.Drawing.Text_Color (Canvas, Gwindows.Colors.Red);
      --        GWindows.Drawing.Put (Canvas, 370, 55, "Nº valores ");
      GWindows.Drawing.Put (Canvas, 450, 55, "Nº valores ");
      GWindows.Drawing.Put
         (Canvas, 450, 75,
          Ada.Strings.Fixed.Trim
           ("mal colocados: " & Natural'Image (Cantidad_Errores),
            Ada.Strings.Left));
      GWindows.Base.Redraw
        (Window => GWindows.Base.Base_Window_Type (Ventana_Principal),
         Erase => False,
         Redraw_Now => True);

   end Visualizar_Etiqueta_Errores;

   procedure Mostrar_Mensaje (Mensaje : in String;
                           Tipo : in Tipo_Mensaje := Informacion) is
   begin
      if Tipo = Error then
         GWindows.Message_Boxes.Message_Box
            ("SUDOKU",
             Mensaje,
             GWindows.Message_Boxes.OK_Box,
             GWindows.Message_Boxes.Error_Icon);
      else --tipo= Informacion
         GWindows.Message_Boxes.Message_Box
            ("SUDOKU",
             Mensaje,
             GWindows.Message_Boxes.OK_Box,
             GWindows.Message_Boxes.Information_Icon);
      end if;
   end Mostrar_Mensaje;

   procedure Refrescar is
   begin
      --borrar etiquetas
      GWindows.Base.Redraw
        (Window => GWindows.Base.Base_Window_Type (Ventana_Principal),
         Erase => True,
         Redraw_Now => True);
      Inicializar_Fondo; --poner gris el fondo de las casillas
   end Refrescar;


   procedure Liberar is
   begin
      for I in Indices.Indice loop
         for J in Indices.Indice loop
            Casillas_Iconos.Finalize (Matriz_Casillas_Iconos (I, J));
         end loop;
      end loop;

      GWindows.Colored_Control_Window.Finalize (Ventana_Principal);
   end Liberar;

begin
   -- cargar imagenes
   GWindows.Drawing_Objects.Load_Bitmap_From_File
--     (Imagen, Directorio_Actual & "\iconos\" & "sudoku.bmp"); ///////////////////
     (Imagen, "iconos\" & "sudoku.bmp");

   for I in Indices.Indice loop
      Coleccion_Iconos.Introducir_Icono
         ("i" &
          Ada.Strings.Fixed.Trim (Positive'Image (I), Ada.Strings.Left) &
          ".ico"); -- numero en negro (inicial)
      Coleccion_Iconos.Introducir_Icono
         ("i" &
          Ada.Strings.Fixed.Trim (Positive'Image (I), Ada.Strings.Left) &
          "_.ico"); -- numero en azul
   end loop;

   -- crear menu contextual
   GWindows.Menus.Append_Item
     (Menu_Numeros, "Borrar", Borrar_ID);
   GWindows.Menus.Append_Separator (Menu_Numeros);
   for I in 101 .. 109 loop
      GWindows.Menus.Append_Item
        (Menu_Numeros,
         Ada.Strings.Fixed.Trim (Positive'Image (I rem 100), Ada.Strings.Left),
         I);
   end loop;
end Tablero.Interfaz;


