with GWindows.Drawing_Objects;
with GNAT.Table;
with GWindows.Registry;

package body Coleccion_Iconos is

   type Punt_Icono_Fich is access String;

--     Directorio_Actual : constant String := GWindows.Registry.Current_Directory;
--     Directorio_Iconos : constant String := Directorio_Actual & "\iconos\";

   Directorio_Iconos : constant String := "iconos\";

   type Reg_Icono is
      record
         Punt_Icono : Punteros_Iconos.Puntero_Icono;
         Nombre_Fich_Iconos : Punt_Icono_Fich;
      end record;

   package Tabla_Iconos is new GNAT.Table
      (Table_Component_Type => Reg_Icono,
       Table_Index_Type => Natural,
       Table_Low_Bound => 1,
       Table_Initial => 1,
       Table_Increment => 1);

   -- Constructor de un nuevo reg_icono (privado)
   function Nuevo_Icono (Nombre_Fich : in String) return Reg_Icono is
      Icono : Reg_Icono;
   begin
      Icono.Punt_Icono := new GWindows.Drawing_Objects.Icon_Type;
      Gwindows.Drawing_Objects.Load_Icon_From_File
         (Icono.Punt_Icono.all, Directorio_Iconos & Nombre_Fich);
      Icono.Nombre_Fich_Iconos := new String'(Nombre_Fich);
      return Icono;
   end Nuevo_Icono;

   function Fich_Fondo_Vacio return String IS
   begin
      return "gris.ico";
   end Fich_Fondo_Vacio;

   function Fich_Fondo_Marcado return String IS
   begin
      return "rojo.ico";
   end Fich_Fondo_Marcado;

   procedure Introducir_Icono (Nombre_Fich : in String) is
      Icono : constant Reg_Icono := Nuevo_Icono (Nombre_Fich);
   begin
      Tabla_Iconos.Append (Icono);
   end Introducir_Icono;

   procedure Obtener_Objeto_Icono
      (Nombre_Fich : in String;
       Icono : out Punteros_Iconos.Puntero_Icono) is
      Existe_Icono : Boolean := False;
   begin
      for I in 1 .. Tabla_Iconos.Last loop
         if Tabla_Iconos.Table (I).Nombre_Fich_Iconos.all = Nombre_Fich then
            Icono := Tabla_Iconos.Table (I).Punt_Icono;
            Existe_Icono := True;
         end if;
      end loop;
      if not Existe_Icono then
         raise Icono_Inexistente;
      end if;
   end Obtener_Objeto_Icono;

begin
   Tabla_Iconos.Init;
   Tabla_Iconos.Append (Nuevo_Icono (Fich_Fondo_Vacio));
   Tabla_Iconos.Append (Nuevo_Icono (Fich_Fondo_Marcado));
end Coleccion_Iconos;
