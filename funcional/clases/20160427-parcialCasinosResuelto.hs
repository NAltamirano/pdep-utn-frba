-- Parcial resuelto para 
data Persona = CPersona String Float Int [(String,Int)] deriving (Show)

nico = (CPersona "Nico" 100.0 30 [("amuleto",3),("manos magicas",100)])
maiu = (CPersona "Maiu" 100.0 42 [("inteligencia",55),("paciencia",50)])

nombre (CPersona name _ _ _) = name
dinero (CPersona _ money _ _) = money
suerte (CPersona _ _ luck _) = luck
factores (CPersona _ _ _ factor) = factor

--suerteTotal CPersona _ _ suerte lista 	| existeAmuleto lista = suerte * valorAmuleto lista
--										| otherwise = suerte



-- Conocer la suerte total de una persona. Sin amuleto es su suerte normal, sino es suerte * valor amuleto
-- filter ((=="amuleto").fst)
-- elem busca el elemento dentro de la lista, devuelve True or False. Uso map para armar una lista de los primeros elementos de las tuplas que forman la lista inicial.
existeFactor listita factor = elem factor (map fst listita)
-- Filtro el primer valor si es amuleto, armando una lista nueva, de la cual extraigo el segundo valor. 
valorAmuleto = (snd.head.filter((=="amuleto").fst))

esAmuleto listaFactores 	| existeFactor listaFactores "amuleto" && valorAmuleto listaFactores /= 0 = valorAmuleto listaFactores
							| otherwise = 1

suerteTotal apostador = (suerte apostador) * (esAmuleto (factores apostador))

-- Modelar un Data tipo Juego
jackpot = 99 -- Un valor constante cualquiera 

ruleta apostador valor 		| suerteTotal apostador >80 = valor *37
							| otherwise = 0

maquinita apostador valor 	| suerteTotal apostador > 95 && existeFactor (factores apostador) "paciencia" = valor + jackpot
							| otherwise = 0