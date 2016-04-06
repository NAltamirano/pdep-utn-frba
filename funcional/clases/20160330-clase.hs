-- Codigo referido a la clase del 30 de Marzo de 2016.
f2 x y = x > y -- Se comprueba que en caso de string, se hace la comparación letra a letra.
-- f2 [[2,3],[[3],[4]]] [[1],[],[4]] -- No es posible por diferencia de datos.

-- Funciones que separan tuplas y determinan que un alumno aprobó
tercero (nombre,legajo,nota1,nota2,nota3) = nota1
aproboPrimer t = tercero t >= 4 -- Devuelve True si la nota 1 es mayor igual que 4.
desaproboPrimer t = not (aproboPrimer t)