% Definicion prototipo de parejas.
pareja(Persona, Persona).

pareja(marsellus, mia).
pareja(pumpkin, honeyBunny).

% 2 - Mas parejas: agregar la siguiente información.
pareja(bernardo, bianca).
pareja(bernardo, charo).

% Definicion de base para la relación entre empleado y empleador.
%trabajaPara(Empleador, Empleado).

trabajaPara(marsellus, vincent).
trabajaPara(marsellus, jules).
trabajaPara(marsellus, winston).

% 3 - Nuevos trabajadores: Bernardo trabaja para cualquiera que trabaje para marsellus (salvo para jules).
trabajaPara(marsellus,bernardo).
trabajaPara(Empleador, bernardo) :- trabajaPara(marsellus,Empleador), Empleador \= bernardo, Empleador \= jules.

% Por el ejemplo dado, george trabaja para charo y bianca.
trabajaPara(bianca,george).
trabajaPara(charo,george).

% 1 - Salen Juntos: saleCon relaciona dos personas que están saliendo porque son pareja, independientemente de como esté definido en el predicado pareja/2.
saleCon(X,Y) :- pareja(X,Y), X \= Y.
saleCon(Y,X) :- pareja(X,Y), X \= Y.

% 4 - Fidelidad: Realizar el predicado esFiel sabiendo que una persona es fiel cuando sale con una unica persona.
esFiel(Persona) :- tieneMuchasParejas(Persona).
tieneMuchasParejas(Persona) :- pareja(Persona,Pareja), not((pareja(Persona,ParejaB),Persona \= ParejaB)).

% 5 - Acatar Ordenes: acataOrden realizacion dos personas. Una acata ordenes de otra si trbaaja para esa persona de manera directa o indirecta.
acataOrden(Persona,Empleado) :- trabajaPara(Persona,Empleado),Persona \= Empleado. % Caso base.
acataOrden(Persona,Empleado) :- forall(trabajaPara(Persona,Empleador),trabajaPara(Empleador,Empleado)),Persona \= Empleado. % Caso recursivo