casado(gerardo, lorena).
casado(sergio, renata).

redSocialHot(tinder).
redSocialHot(badoo).
redSocialHot(xxx).

usa(tinder, gerardo).
usa(tinder, graciela).
usa(tinder, sergio).
usa(tinder, tana).
usa(tinder, anahi).
usa(badoo, renata).
usa(badoo, sergio).
usa(badoo, raul).
usa(facebook, dodain).
usa(xxx, renata).

% Punto 1
%  Incorporar la siguiente información a la base.
%  En caso de no hacerlo, explicar qué concepto está utilizando que
%  justifica su solución.
%  claudio usa todo lo que usa renata
usa(RedSocial, claudio):-usa(RedSocial, renata).

% todos los que usan tinder o badoo usan twitter
usa(twitter, Quien):-usa(tinder, Quien).
usa(twitter, Quien):-usa(badoo, Quien).

%
% dodain no usa tinder ni badoo
% nada por principio de universo cerrado
%
% Punto 2
% Definir el predicado laCaretean/2 que relaciona una pareja de casados
% si ambos usan redes sociales hot, pero distintas. El predicado debe
% ser inversible para ambos argumentos.
% ?- laCaretean(Uno, Otro).
% Uno = sergio,
% Otro = renata ; (sergio usa tinder y renata xxx, ademas de que usen
% badoo ambos)
laCaretean(Casado1, Casado2):-casado(Casado1, Casado2),
	redSocialHot(RedSocial),
	redSocialHot(RedSocial2),
	usa(RedSocial, Casado1),
	not(usa(RedSocial, Casado2)),
	usa(RedSocial2, Casado2),
	RedSocial \= RedSocial2,
	not(usa(RedSocial2, Casado1)).

% Punto 3
% Si incorporamos
salieron(sergio, tana).
salieron(sergio, anahi).
salieron(sergio, graciela).
salieron(gerardo, anahi).
gusta(sergio, tana).
gusta(sergio, anahi).
gusta(anahi, gerardo).
gusta(anahi, sergio).
gusta(graciela, raul).

% Queremos determinar si un individuo es feliz, eso ocurre cuando salió
% con todas las personas que le gusta (al menos una persona).
% El predicado debe ser inversible. Debe resolverlo utilizando
% forall/2.
% ?- esFeliz(Quien).
% Quien = sergio ;
% Quien = anahi ;
% false (a gerardo y la tana no les gusta ninguno)
esFeliz(Persona):-persona(Persona), gusta(Persona, _),
	forall(gusta(Persona, Otro), salieronJuntos(Persona, Otro)).

salieronJuntos(Persona, Otro):-salieron(Persona, Otro).
salieronJuntos(Persona, Otro):-salieron(Otro, Persona).

persona(Persona):-usa(_, Persona).

% Punto 4
% Modelar el predicado desdichado/1, que relaciona los individuos que nunca
% salieron con alguien que le gustara. Debe considerar que le debe
% gustar al menos uno.
% Resolverlo utilizando not/1 (no
% puede utilizar forall). El predicado debe ser inversible.
% ?- desdichado(Quien).
% Quien = graciela .
desdichado(Persona):-gusta(Persona, _),
	not((salieronJuntos(Persona, Otro), gusta(Persona, Otro))).


% Punto 5
% Resolver el predicado fiesta/2 que relaciona una red social con un conjunto
% de personas que van a una fiesta organizada por esa red. Pueden ir
% todas, algunas... armar el predicado de manera que soporte
% múltiples respuestas. Debe haber al menos una persona en la fiesta.
% El predicado debe ser inversible para todos los
% argumentos.
% ?- fiesta(tinder, Personas).
% Personas = [gerardo, graciela, sergio, tana, anahi] ;
% Personas = [gerardo, graciela, sergio, tana] ;
% Personas = [gerardo, graciela, sergio, anahi] ;
% Personas = [gerardo, graciela, sergio] ;
% Personas = [gerardo, graciela, tana, anahi] ;
% Personas = [gerardo, graciela, tana] ;
% Personas = [gerardo, graciela, anahi] ;
% Personas = [gerardo, graciela]
fiesta(RedSocial,  PersonasFiesta):-
   redSocial(RedSocial),
   findall(Persona, usa(RedSocial, Persona), Personas),
   combinar(Personas, PersonasFiesta),
   PersonasFiesta \= [].

combinar([], []).
combinar([Persona|Personas], [Persona|PersonasFiesta]):-
     combinar(Personas, PersonasFiesta).
combinar([_|Personas], PersonasFiesta):-
     combinar(Personas, PersonasFiesta).

redSocial(tinder).
redSocial(facebook).
redSocial(twitter).
redSocial(badoo).

% Punto 6
% Agregamos a la base esta informacion
amigo(sergio, gerardo).
amigo(sergio, tana).
amigo(sergio, anahi).
amigo(gerardo, lorena).
amigo(lorena, petisa).
amigo(anahi, graciela).

% Resolver el predicado darleLike que relaciona
% dos individuos que usen la misma red social, de manera
% que alguien le pueda dar like a algo que haga otro (comentario,
% foto, etc.) porque
% - es amigo directo
% - o es amigo de alguien que le daría like a algo que haga otro
% ? darLike(sergio, Quien).
% Quien = gerardo ; (son amigos directos)
% Quien = lorena ; (es amiga de gerardo, a quien le da like como vimos)
% Quien = petisa ; (es amiga de lorena, a quien le da like)
%
darLike(Persona, Otro):-
	usa(Persona, RedSocial),
	usa(Otro, RedSocial),
	likea(Persona, Otro).

likea(Persona, Otro):-amigo(Persona, Otro).
likea(Persona, Otro):-amigo(Persona, Tercero),
      darLike(Tercero, Otro),
      Otro \= Tercero.

% Por último, tenemos en la base esta información
caracteristicas(sergio, nacio(30,9,1974)).
caracteristicas(gerardo, nacio(23,4,1973)).
caracteristicas(tana, nacio(15,10,1981)).
caracteristicas(tana, acento(tano)).
caracteristicas(sergio, acento(cordobes)).
caracteristicas(graciela, acento(aleman)).
caracteristicas(graciela, hijos(3)).
caracteristicas(gerardo, hijos(2)).

% Queremos determinar quienes son interesantes, que son los que tienen al menos 2 características interesantes:
% - un individuo que nació en los 70 es interesante
% - una persona con acento cordobés o tano es interesante
% - una persona que tiene 2 o más hijos es interesante
interesante(Persona):-caracteristicas(Persona, _), findall(Cosa, (caracteristicas(Persona, Cosa), cosaInteresante(Cosa)), Cosas),
	length(Cosas, Cant), Cant >= 2.

cosaInteresante(nacio(_, _, Anio)):-Anio >= 1970, Anio =< 1980.
cosaInteresante(acento(tano)).
cosaInteresante(acento(cordobes)).
cosaInteresante(hijos(Hijos)):-Hijos >= 2.
