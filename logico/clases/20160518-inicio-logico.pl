mortal(X) :- humano(X).
humano(socrates).
humano(emanuel).

culpable(X) :- persona(X), asesino(X). % La "," es un AND.
culpable(X) :- persona(X), ladron(X). % Escribir una deducción con el mismo nombre y otras condiciones, es un OR. Tambien se puede utilizar un ";".

persona(abel).
persona(santi).
persona(andrea).
persona(juli).
persona(einstein).
persona(juanCass).

fisicoNuclear(einstein).

modelo(juli).

ayudaPobres(juanCass).

ladron(juli).

asesino(santi).

% Una persona gusta de otra si no es asesino.
% Es necesario evitar que se repita la variable porque sino se va a cumplir siempre.
gustaDe(P1,P2) :- persona(P1), persona(P2), not(asesino(P2)), P1 \= P2.

% Cuando una persona aprueba un parcial.
aprueba(Persona,Nota) :- persona(Persona), Nota >= 4.

% Una persona es grosa si es fisico nuclear, ayuda pobres o gustaDe una modelo.
groso(Persona) :- fisicoNuclear(Persona).
groso(Persona) :- ayudaPobres(Persona).
groso(Persona) :- gustaDe(Persona, Per2), modelo(Per2).