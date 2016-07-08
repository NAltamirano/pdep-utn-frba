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
esFiel(Persona) :- saleCon(Persona,ParejaA), forall(saleCon(Persona,ParejaB), ParejaA = ParejaB).

% 5 - Acatar Ordenes: acataOrden realizacion dos personas. Una acata ordenes de otra si trbaaja para esa persona de manera directa o indirecta.
acataOrden(Persona,Empleado) :- trabajaPara(Persona,Empleado),Persona \= Empleado. % Caso base.
acataOrden(Persona,Empleado) :- forall(trabajaPara(Persona,Empleador),trabajaPara(Empleador,Empleado)),Persona \= Empleado. % Caso recursivo

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Entrega 2: Se agrega información.
% Información Base.
% personaje(Nombre,Ocupacion).
personaje(pumpkin,ladron([estacionesDeServicio,licorerias])).
personaje(honeyBunny,ladron([licorerias,estacionesDeServicio])).
personaje(vincent,mafioso(maton)).
personaje(jules,mafioso(maton)).
personaje(marsellus,mafioso(capo)).
personaje(winston,mafioso(resuelveProblemas)).
personaje(mia,actriz([foxForceFive])).
personaje(butch,boxeador).
personaje(bernardo,mafioso(cerebro)).
personaje(bianca,actriz([elPadrino1])).

% Información de los encargos.
% encargo(Solicitante,Encargado,Tarea).
% las tareas pueden ser cuidar(Protegido), ayudar(Ayudado), buscar(Buscado,Lugar).
encargo(marsellus,vincent,cuidar(mia)).
encargo(vincent,elVendedor,cuidar(mia)).
encargo(marsellus,winston,ayudar(jules)).
encargo(marsellus,winston,ayudar(vincent)).
encargo(marsellus,vincent,buscar(butch,losAngeles)).
encargo(bernardo,vincent,buscar(jules,fuerteApache)).
encargo(bernardo,winston,buscar(jules,sanMartin)).
encargo(bernardo,winston,buscar(jules,lugano)).

% amistades
amigo(vincent,jules).
amigo(jules,jimmie).
amigo(vincent,elVendedor).

% Parte 1: esPeligroso nos dice si un personaje es peligroso cuando: realiza una actividad peligrosa (maton o robar licorerias), tiene jefe peligroso.
esPeligroso(Nombre) :- personaje(Nombre,Ocupacion),esMaton(Ocupacion).
esPeligroso(Nombre) :- personaje(Nombre,Ocupacion),robaLicorerias(Ocupacion).
esPeligroso(Nombre) :- trabajaPara(Jefe,Nombre),esPeligroso(Jefe).
esMaton(mafioso(maton)).
robaLicorerias(ladron(Lista)) :- member(licorerias,Lista).

% Parte 2: Se considera San Cayetano si tiene cerca a alguien y les da encargo. Estan cerca si son amigos o uno trabajaPara.
sanCayetano(Persona) :- trabajaPara(Jefe,Persona),encargo(Persona,Jefe,_).
sanCayetano(Persona) :- amigo(Persona,Amigo),encargo(Persona,Amigo,_).
sanCayetano(Persona) :- amigo(Amigo,Persona),encargo(Persona,Amigo,_).

% Parte 3: Predicado nivelRespeto que relaciona un personaje con su nivel de respeto.
% - Actriz: Decima parte de sus peliculas.
% - Mafiosos que resuelven problemas, 10, capo mafia 20.
% - Vincent 15
% - El resto no cuenta con nivel de Respeto.
nivelRespeto(Persona,div(Nivel,10)) :- personaje(Persona,actriz(Listado)),length(Listado,Nivel).
nivelRespeto(Persona,10) :- personaje(Persona,mafioso(resuelveProblemas)).
nivelRespeto(Persona,20) :- personaje(Persona,mafioso(capo)).
nivelRespeto(vincent,15).

% Parte 4: Personaje es respetable si nivel de Respeto es mayor a 9. Contar cuantos son respetables y cuantos no.
% Esta funcion puede hacerse delegando en otras funciones.
respetabilidad(Respetables,NoRespetables) :- findall(Persona,(nivelRespeto(Persona,X),X>9),ListaRespetables),
findall(Persona,(nivelRespeto(Persona,X),X<9),ListaNoRespetables),
sinRespeto(ListaRespetoCero),
append(ListaNoRespetables,ListaRespetoCero,ListaTotalNoRespetable),
length(ListaTotalNoRespetable,NoRespetables),
length(ListaRespetables,Respetables).

sinRespeto(ListadoSinRespeto) :- findall(Personaje,(personaje(Personaje,_),not(nivelRespeto(Personaje,_))),ListadoSinRespeto).

% Parte 5: Se quiere averiguar quien es el mas atareado (mayor cantidad de encargos). Se debe definir cantidadEncargos/2, relaciona un personaje con su cantidad de encargos. Se debe utilizar forall (???).
masAtareado(Personaje):- cantidadDeEncargos(Personaje,Tareas), forall(cantidadDeEncargos(_,MasTareas), Tareas >= MasTareas).
cantidadDeEncargos(Personaje,Tareas):- personaje(Personaje,_), findall(Encargo, encargo(_, Personaje,Encargo),ListaEncargos), length(ListaEncargos,Tareas).