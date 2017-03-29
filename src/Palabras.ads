package Palabras is

   type Palabra is limited private;
   
   procedure Crear (P: out Palabra; S: String);
   -- Entrada: string S
   -- Salida: Palabra P
   -- Efecto: Crea una nueva Palabra P cuyo valor coincide con el de S
 
   function Valor (P: Palabra) return String;
   -- Entrada: Palabra P
   -- Salida: string 
   -- Efecto: Obtiene el string correspondiente al valor de P
   -- Excepciones: Sin_Inicializar, se eleva cuando P no tiene valor asociado

   function Longitud (P: Palabra) return Positive;
   -- Entrada: Palabra P
   -- Salida: un número positivo 
   -- Efecto: cuenta el número de caracteres que compone el valor de P
   -- Excepciones: Sin_Inicializar, se eleva cuando P no tiene valor asociado

   function "<" (P1, P2: Palabra) return Boolean;
   -- Entrada: dos Palabras P1 y P2
   -- Salida: True si el valor de P1 es menor que el valor de P2, y False en otro caso 
   -- Efecto: Compara los valores de P1 y P2
   -- Excepciones: Sin_Inicializar, se eleva cuando P1 o P2 no tienen valor asociado

   function "=" (P1, P2: Palabra) return Boolean;
   -- Entrada: dos Palabras P1 y P2
   -- Salida: True si los valores de P1 y P2 coinciden, y False en otro caso 
   -- Efecto: Compara los valores de P1 y P2
   -- Excepciones: Sin_Inicializar, se eleva cuando P1 o P2 no tienen valor asociado

   function Identidad (P1: Palabra) return Palabra;
   -- Entrada: Palabra P1
   -- Salida: devuelve P1 

   procedure Copiar (P1: out Palabra; P2: Palabra);
   -- Entrada: Palabra P2
   -- Salida: Palabra P1
   -- Efecto: crea una nueva Palabra P1 cuyo valor es igual al de P2
   -- Excepciones: Sin_Inicializar, se eleva cuando P2 no tiene valor asociado

   procedure Liberar (P1: in out Palabra);
   -- Entrada: Palabra P1
   -- Salida:  Palabra P1 sin inicializar
   -- Efecto:  libera la zona de memoria dinamica asociada a P1 
   --         Es destructiva!!

   Sin_Inicializar : Exception;
   
private
   type Palabra is access String;   
end Palabras;
