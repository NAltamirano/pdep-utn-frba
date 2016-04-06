-- Escribir el código que tome una lista, extraiga el último y el primer elemento.
sacaUltimo ls = take (length ls)-1 ls
sacaPrimero (l:ls) = ls
conjuntoMedio ls = (sacaUltimo.sacaPrimero) ls -- El "." determina composición de funciones.