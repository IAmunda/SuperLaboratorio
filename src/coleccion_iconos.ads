with Punteros_Iconos;
package Coleccion_Iconos is

   -- Este paquete contiene la coleccion de los iconos que se 
   --van a utilizar en la interfaz grafica

   function Fich_Fondo_Vacio return String;
   -- Salida: Nombre del fichero que le corresponde al icono de fondo vacio (gris)


   function Fich_Fondo_Marcado return String;
   -- Salida: Nombre del fichero que le corresponde al icono de marca (rojo)
   
   procedure Introducir_Icono (Nombre_Fich : in String);
   -- Entrada: nombre del fichero que contiene un icono
   -- Efecto: crea un nuevo objeto-icono y lo introduce en la coleccion

   procedure Obtener_Objeto_Icono
      (Nombre_Fich : in String;
       Icono : out Punteros_Iconos.Puntero_Icono);
   -- Entrada: nombre del fichero que contiene un icono
   -- Salida: el objeto-icono que le corresponde a ese fichero
   -- Excepciones: Icono_Inexistente si no existe el fichero
  

   Icono_Inexistente : exception;

end Coleccion_Iconos;
