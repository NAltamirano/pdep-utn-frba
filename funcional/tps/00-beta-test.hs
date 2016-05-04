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
--- parHabilidad es una tupla habilidad que se compone por fuerza y precision (fuerza,precision).
putter parHabilidad = (10,(snd parHabilidad)*2,0)
madera parHabilidad = (100,(snd parHabilidad)*2,5)
hierro n parHabilidad = ((fst parHabilidad) * n, quot (snd parHabilidad) n, n^2) -- Utilizo quot para que devuelva (Int, Int, Int)
-- Funcion pre-definida
palos = putter : madera : map hierro [1 .. 10]

-- Punto 2
--- Obtener el tiro con jugador y palo.
golpe jugador palo = (palo.habilidad) jugador

--- Averiguo si puedo superar un obstaculo recibiendo un tiro
puedeSuperar obstaculo tuplaTiro = fst obstaculo tuplaTiro

--- Defino los palos utiles
palosUtiles jugador obstaculo = (filter (puedeSuperar obstaculo).map (golpe jugador)) palos

-- Obtengo las personas que pueden superar todos los obstaculos de una lista
--- Voy a usar una función auxiliar para evaluar que la lista de palosUtiles no contenga la lista vacia. Si devuelve True, entonces puede con todos los obstaculos.
puedeSuperarTodosLosObstaculos listaObstaculos jugador = (not.elem [].map (palosUtiles jugador)) listaObstaculos

nombreDeLosQuePuedenSuperarTodos listaObstaculos listaJugadores = (map nombre.filter (puedeSuperarTodosLosObstaculos listaObstaculos)) listaJugadores

-- Punto 3
--- Saber cuantos obstaculos puede superar. Solo devuelve un Int con el valor de cantidad de obstaculos
sumadorDeObstaculos tiro [] = []
sumadorDeObstaculos tiro ((esTiroValido,efectoDeTiro):obstaculoTail) 	| esTiroValido tiro = (efectoDeTiro tiro):(sumadorDeObstaculos (efectoDeTiro tiro) obstaculoTail)
																		| otherwise = []
 
cuantosObstaculosSupera tiro listaObstaculos = length (sumadorDeObstaculos tiro listaObstaculos)

--- Determinar cual es el palo que permite superar mas obstaculos.
--- Recordamos del punto 2 que no se puede mostrar el nombre del palo, pero mostramos la tupla de tiro que genera.
paloMasUtil jugador listaObstaculos = snd(maximum(mapeoDeTuplas jugador listaObstaculos))
formarTuplaPalos jugador listaObstaculos palo = ((cuantosObstaculosSupera (golpe jugador palo) listaObstaculos),(golpe jugador palo))
mapeoDeTuplas jugador listaObstaculos = map (formarTuplaPalos jugador listaObstaculos) palos

-- Punto 4
--- Devolver puntos ganados por tipo de tiro.
dificultadDeLaguna obstaculo tiro listaLargo = [ snd obstaculo tiro == snd (laguna largo) tiro | largo <- listaLargo ]

nivelDeDificultad obstaculo tiro 	| snd obstaculo tiro == (0,0,0) || elem True (dificultadDeLaguna obstaculo tiro [1..5]) = "facil"
									| snd obstaculo tiro == snd tunelConRampita tiro || elem True (dificultadDeLaguna obstaculo tiro [6..10]) = "medio"
									| otherwise = "complejo"

puntosGanados obstaculo tiro 	| fst obstaculo tiro && nivelDeDificultad obstaculo tiro == "facil" = 50
								| fst obstaculo tiro && nivelDeDificultad obstaculo tiro == "medio" = 75
								| fst obstaculo tiro && nivelDeDificultad obstaculo tiro == "complejo" = 100
								| otherwise = 0

--- Determinar el padre de quien perdio la apuesta.
listadoDeSuperadores listaJugadores listaObstaculos = filter (puedeSuperarTodosLosObstaculos listaObstaculos) listaJugadores
-- Aca hay una cuestion, segun el enunciado, con la lista de prueba [tunelConRampita, laguna 1, hoyo] ganaria Todd. Pero si calculamos "cuantosObstaculosSupera" para ambos, ninguno de los dos pasa mas de uno, no cumpliendo con "Un niño gana si puede superar todos los obstaculos". Si, -puede-, pero no lo hace. Aceptando esa frase, solo necesito la lista de los que PUEDEN, y despues sumar puntos.
-- Esta funcion la armamos para calcular, en algun momento, que si supera la misma cantidad de "length(listaObstaculos)" entonces es el ganador.
-- El caso no se da.
-- cantidadDeObstaculos listaObstaculos jugador = cuantosObstaculosSupera (paloMasUtil jugador listaObstaculos) listaObstaculos 
inversorPalos listaObstaculos jugador = paloMasUtil jugador listaObstaculos
armadoDePalos listaJugadores listaObstaculos = map (inversorPalos listaObstaculos) (listadoDeSuperadores listaJugadores listaObstaculos)

pierdeLaApuesta listaJugadores listaObstaculos = 0

-- Punto 6
-- funcionMrBurns :: (Num b) => (a, b -> b) -> (f -> b) -> (b -> d -> g) -> [f] -> Int
funcionMrBurns x y z = length.flip z 12.foldl1 (snd.x).map y

-- En primer lugar, sabemos que map es una función que recibe una función que aplicará a una lista, y devuelve un resultado. 
-- De esto, sacamos dos cosas:
-- Que "y" es una funcion que recibe un valor y retorna otro, por lo cual su tipo sera (f -> b) y que, debido a que la función está aplicando
-- composición, funcionMrBurns recibe un parametro más después de "z", que será una lista de tipo [f].
-- snd es una función aplicada a tuplas binarias, por tanto x es una tupla binaria (a,b).
-- foldl1 toma una función y una lista, a la cual le aplica recursivamente la función. Por tanto, el segundo valor de la tupla "x" es una funcion.
-- La lista generada por "map y" es la que evaluará foldl1, por tanto la funcion (snd.x) evaluará argumentos del tipo b y devolverá el mismo tipo. Por esto es que la función "y" devuelve elementos b.
-- Flip es una función que recibe una función binaria y da vuelta el orden de sus argumentos. La función binaria z es entonces (b -> d -> g).
-- Por ultimo, length da el tamaño de una lista, tal que devuelve un Int, que es lo que devuelve nuestra funcionMrBurns.