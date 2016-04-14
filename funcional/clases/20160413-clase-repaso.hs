-- Funcion que verifica que todos los elementos de una lista cumplen con la condición de la función
todasCumplen f xs = (length.filter f) xs == length xs -- Esta version necesita evaluar todo antes de terminar. No sirve para listas infinitas.

todasCumplen2 f (x:xs) = f x && todasCumplen2 f xs -- Version alternativa
todasCumplen2 _ [] = True -- Caso base para la version alternativa

todasCumplen3 f xs = all f xs -- Version mas declarativa. La funcion all hace lo que necesitamos, sin importar que.

-- Sumas
suma [] = 0
suma xs = head xs + (suma.tail) xs

-- foldl <funcion> <caso-base> <lista>
sumare xs = foldl (+) 0 xs

foldr ((+).length) 0 ["hola","como","estas"] -- Suma el tamaño de los strings.

------
type Nombre = String
type Agregado = String
type Sabor = String
type Azucar = Integer
type Sabores = (String,String)
type Banio = String

data Producto = Cafe Nombre Azucar | Gaseosa Sabor Azucar | Helado Sabores Banio | AguaMineral derive Show

-- Cafe 3 veces Azucar
-- Gaseosa = Azucar
-- helado 220 pero si bañado "chocolate" + 150
calorias :: Producto -> Integer
calorias Cafe _ az = 3 * az
calorias Gaseosa _ az = az
calorias Helado _ ba | ba == "chocolate" = 370
					 | otherwise = 220
calorias AguaMineral = 0

-- Quiero sumar las calorias, para eso voy a usar fold con una función lambda, porque no necesito una nueva función que no se va a volver a utilizar más que en este caso.
foldl (\x y -> x + calorias y) 0 [cafe "Irlandes" 30, Helado("choco","dulce") "Nada", Helado ("P","Q") "Chocolate", AguaMineral]