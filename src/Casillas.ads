with Numeros;
package Casillas is

   type Casilla is private;

procedure Crear (C: out Casilla);
--Construye un objeto del tipo Casilla libre (sin valor asignado) y no inicial.

function Esta_Libre (C: Casilla) return Boolean;
-- Dada una Casilla C, la operación devuelve el valor booleano True si está libre y False en otro caso.

function Es_Inicial (C: Casilla) return Boolean;
-- Dada una Casilla C, la operación devuelve el valor booleano True si su valor es inicial y False en otro caso.

function Valor (C: Casilla) return Numeros.Numero;
--  Dada una Casilla C la operación devuelve su valor.

procedure Asignar_Valor(C: in out Casilla;     V: in Numeros.Numero);
--  Dada una Casilla C y un valor V, incluye V en la casilla como valor NO inicial. La casilla también deja de estar libre ya que tiene un valor asignado.

procedure Asignar_Valor_Inicial (C: in out Casilla;     V: in Numeros.Numero);
--  Dada una Casilla C y un valor inicial V, incluye el valor V en la casilla C como valor inicial. La casilla pasa a estar en estado de ocupada (con valor).

procedure Quitar_Valor (C: in out Casilla);
   -- Dada una Casilla C, modifica su estado a libre.

private
   type Casilla is record
      Libre, Inicial: Boolean;
      Valor: Numeros.Numero;
      end record;
   end Casillas;
