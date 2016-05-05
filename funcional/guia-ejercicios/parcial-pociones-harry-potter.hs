aplicar3 f (a,b,c) = (f a, f b, f c)
invertir3 (a,b,c) = (c,b,a)
fst3 (a,_,_) = a
snd3 (_,b,_) = b
trd3 (_,_,c) = c

sinRepetidos [] = []
sinRepetidos (x:xs) | elem x xs = sinRepetidos xs
					| otherwise = x : sinRepetidos xs

maximoF _ [ x ] = x
maximoF f ( x : y : xs) | f x > f y = maximoF f (x:xs)
    					| otherwise = maximoF f (y:xs)

personas =[("Harry",(11, 5, 4)), ("Ron",(6,4,6)), ("Hermione",(8,12,2)), ("Draco",(7,9,6))]

f1 (ns,nc,nf) = (ns+1,nc+2,nf+3)
f2 = aplicar3 (max 7)
f3 (ns,nc,nf) 	| ns >= 8 = (ns,nc,nf+5)
	        	| otherwise = (ns,nc,nf-3)

misPociones = [("Felix Felices",[("Escarabajos Machacados",52,[f1,f2]),("Ojo de Tigre Sucio",2,[f3])]),("Multijugos",[("Cuerno de Bicornio en Polvo",10, [invertir3, (\(a,b,c) -> (a,a,c))]),("Sanguijuela hormonal",54,[(aplicar3 (*2)), (\(a,b,c) -> (a,a,c)) ])]),("Flores de Bach",[("Orquidea Salvaje",8,[f3]), ("Rosita",1,[f1])])]

sumaNiveles (nivelSuerte, nivelPoderdeConvencimiento,nivelFuerzaFisica) = nivelSuerte + nivelPoderdeConvencimiento + nivelFuerzaFisica

diferenciaNiveles (nivelSuerte, nivelPoderdeConvencimiento, nivelFuerzaFisica) = maximum [nivelSuerte, nivelPoderdeConvencimiento, nivelFuerzaFisica] - minimum [nivelSuerte, nivelPoderdeConvencimiento, nivelFuerzaFisica]

sumaNivelesPersona = (sumaNiveles.snd)

diferenciaNivelesPersona = (diferenciaNiveles.snd)

efectosDePocion = (ingredientes.snd)
ingredientes lista = foldl1 (++) (map trd3 lista)
filtrar lista = filter (((>=4).length).efectosDePocion) lista
pocionesHeavies lista = map fst (filtrar lista)

incluyeA lista1 lista2 = all (\x -> elem x lista2) lista1

esPocionMagica tupla = (even.length.snd) tupla && any (incluyeA "aeiou") (map fst3 (snd tupla))