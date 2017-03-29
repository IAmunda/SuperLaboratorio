generic
   type Componente is limited private;
   with function Igual (C1, C2: Componente) return Boolean;
   with procedure Copiar (C1: out Componente; C2: in Componente);

package Listas_Ordenadas is

   type Lista is limited private;      -- Tipo lista ordenada

   procedure Crear_Vacia (L : out Lista);
   -- Entrada:
   -- Salida: lista vacia L
   -- Efecto: crea la lista vacia L

   generic
      type Clave is limited private;
      with procedure Obtener_Clave (E : in Componente; C : out Clave);
      with function Mayor_Clave (C1, C2 : in Clave) return Boolean;
   procedure Colocar (L : in out Lista; E : in Componente);
   -- Entrada: lista ordenada L
   --          elemento E
   -- Salida: lista L actualizada con el elemento E
   --         en su lugar correspondiente
   -- Efecto: Coloca el elemento E en L en funcion de la
   --         operacion de comparacion Mayor_Clave
   -- Excepciones: Lista_Llena, si la memoria se termina

   procedure Obtener_Primero (L : in Lista; P : out Componente);
   -- Entrada: lista ordenada L
   -- Salida: Primer elemento de la lista L
   -- Efecto: Obtiene el primer elemento de la lista L (si L no es vacia)
   -- Excepciones: Lista_Vacia, si L es vacia

   function Resto (L : in Lista) return Lista;
   -- Entrada: lista ordenada L
   -- Salida: Nueva lista creada a partir de L sin su primer elemento.
   -- Efecto: Obtiene la lista sin el primer elemento
   --         (Si la lista no es vacia)
   --         No es destructiva (No se elimina el nodo de memoria)
   -- Excepciones: Lista_Vacia, si L es vacia


   generic
      type Clave is limited private;
      with function Igual (C1, C2: Clave) return Boolean;
      with procedure Obtener_Clave (E : in Componente; C: out Clave);
   function Esta (L : in Lista; C : in Clave) return Boolean;
   -- Entrada: lista ordenada L
   --          elemento E
   -- Salida: True, Si el elemento E esta en la lista L
   --          False, en otro caso
   -- Efecto: Comprueba si elemento E esta en la lista L

   procedure Borrar_Primero (L : in out Lista);
   -- Entrada: lista ordenada L
   -- Salida: Nueva lista a partir de L sin su primer elemento.
   -- Efecto: Obtiene la lista sin su primer elemento
   --         (Si la lista no es vacia)
   --         Es destructiva!! (Elimina el nodo de memoria)
   -- Excepciones: Lista_Vacia, si L es vacia

   generic
      type Clave is limited private;
      with function Igual (C1, C2: Clave) return Boolean;
      with procedure Obtener_Clave (E : in Componente; C: out Clave);
   function Sublista (L : in Lista; C : in Clave) return Lista;
   -- Entrada: lista ordenada L y el elemento E
   -- Salida: Sublista formada por los elementos E de la lista L
   -- Efecto: Crea una lista formada por los elementos iguales a E de la lista L

   function Es_Vacia (L : in Lista) return Boolean;
   -- Entrada: lista ordenada L
   -- Salida: True, si la lista L es vacia
   --         False, en caso contrario
   -- Efecto: Comprueba si la lista L es vacia

   function "=" (L1, L2 : in Lista) return Boolean;
   -- Entrada: listas ordenadas L1 y L2
   -- Salida: True, si L1 y L2 son iguales
   --         False, en caso contrario
   -- Efecto: Compara L1 y L2 elemento a elemento

   procedure Copiar (L1 : out Lista; L2 : in Lista);
   -- Entrada: lista ordenada L2
   -- Salida: lista ordenada L1 (copia de L2)
   -- Efecto: Copia L2 en L1 (crea una nueva lista)

   procedure Liberar (L : in out Lista);
   -- Entrada: lista ordenada L
   -- Salida: lista vacia L
   -- Efecto: Vacia una lista liberando de la memoria dinamica sus nodos
   --         Es destructiva!!

   Lista_Vacia, Lista_Llena : exception;

private
   -- implementacion dinamica, ligadura simple

   type Nodo;
   type Apuntador_Nodo is access Nodo; -- Tipo auxiliar para implementar "="
   type Nodo is
      record
         Info : Componente;
         Siguiente : Lista;
      end record;

   type Lista is new Apuntador_Nodo;

end Listas_Ordenadas;



