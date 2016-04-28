-- jugador = ("Nombre","Padre",(fuerza,precision))
bart = ("Bart","Homero",(25,60))
todd = ("Todd","Ned",(15,80))
rafa = ("Rafa","Gorgory",(10,1))

nombre (n,_,_) = n
padre (_,p,_) = p
habilidad (_,_,h) = h

-- ( Tiro -> Bool, Tiro -> Tiro )
-- ((velocidad,precision,altura), efecto)
laguna largo = ((\(v,_,a) -> v>80 && between 10 50 a),(\(v,p,a) -> (v,p,a `div` largo)))
tunelConRampita = ((\(_,p,a) -> p>90 && a==0), (\(v,_,a) -> (v*2,100,0)))
hoyo = ((\(v,p,a) -> between 5 20 v && p>95 && a==0), (\ _ -> (0,0,0))) 
between n m x = elem x [n .. m]

maximoSegun f = foldl1 (mayorSegun f)
mayorSegun f a b 	| f a >= f b = a
					| otherwise = b

-- Punto 1
-- parHabilidad es una tupla habilidad que se compone por fuerza y precision (fuerza,precision).
putter parHabilidad = (10,(snd parHabilidad)*2,0)
madera parHabilidad = (100,(snd parHabilidad)*2,5)
hierro n parHabilidad = ((*n) (fst parHabilidad),(/n) (snd parHabilidad),n^2)
-- Funcion pre-definida
palos = putter : madera : map hierro [1 .. 10]