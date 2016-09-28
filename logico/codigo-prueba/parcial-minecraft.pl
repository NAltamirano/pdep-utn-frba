jugador(Nombre,ListadoItems,Hambre).
jugador(stuart,[piedra, piedra, piedra, piedra, piedra, piedra, piedra, piedra], 3).
jugador(tim, [madera,madera,madera,madera,madera,pan,carbon,carbon,carbon,pollo,pollo], 8).
jugador(steve, [madera,carbon,carbon,diamante,panceta,panceta,panceta], 2).

lugar(Nombre,ListaJugador,Oscuridad).
lugar(playa, [stuart,tim], 2).
lugar(mina, [steve], 8).

comestible(Nombre).
comestible(pan).
comestible(panceta).
comestible(pollo).
comestible(pescado).

tieneItem