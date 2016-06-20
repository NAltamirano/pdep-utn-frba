padre(Padre,Hijo).
padre(homero,bart).
padre(homero,lisa).
padre(homero,maggie).
padre(abe,homero).
padre(abe,herbert).

hermano(X,Y) :- padre(Padre,X), padre(Padre,Y), X \= Y.