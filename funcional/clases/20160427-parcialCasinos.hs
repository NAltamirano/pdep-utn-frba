data Persona = CPersona String Float Int [(String,Int)] deriving (Show)

nico = (CPersona "Nico" 100.0 30 [("amuleto",3),("manos magicas",100)])
maiu = (CPersona "Maiu" 100.0 42 [("inteligencia",55),("paciencia",50)])

nombre (CPersona name _ _ _) = name
dinero (CPersona _ money _ _) = money
suerte (CPersona _ _ luck _) = luck
factores (CPersona _ _ _ factor) = factor

-- Conocer la suerte total de una persona. Sin amuleto es su suerte normal, sino es suerte * valor amuleto
-- filter ((=="amuleto").fst)
esAmuleto listaFactores 	| elem "amuleto" (map fst listaFactores) && (snd.head.filter((=="amuleto").fst)) listaFactores /= 0 = (snd.head.filter((=="amuleto").fst)) listaFactores
							| otherwise = 1

suerteTotal apostador = (suerte apostador) * (esAmuleto (factores apostador))

-- Modelar un Data tipo Juego
data Juego = TJuego String Float 