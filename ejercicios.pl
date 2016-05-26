% Ej1 - diccionario_lista(?S). Equivalente a diccionario(S) pero con listas de códigos de caracteres en vez de strings.

diccionario_lista(S) :- diccionario(L), string_codes(L, S). 

% Ej2 - juntar_con(+L, ?J, ?R).
% L requiere estar definido para que no se ponga a generar todas las posibles listas (infinitas).

juntar_con([], _, []).
juntar_con([S], _, S).
juntar_con([L1,L2|Ls], J, R) :- juntar_con([L2|Ls], J, Rec), append(L1, [J|Rec], R).

% Ej3 - palabras(?S, ?P).

palabras(S, [S]) :- not(member(espacio, S)).
palabras(S, [S1|P1]) :- append(S1, [espacio|S2], S), not(member(espacio, S1)), palabras(S2, P1).

% Ej4 - asignar_var(+A, +MI, -MF).
% Elegimos que no venga instanciado MF así no manejamos permutaciones.
% Además, agregamos el mapeo al principio, no al final como el ejemplo del enunciado. 
% Habría que preguntar si esto vale, la consigna parecería permitirlo con "generar un mapeo".

asignar_var(A, MI, MI) :- member((A,_), MI).
asignar_var(A, MI, [(A,C)|MI]) :- not(member((A,C), MI)).

% Ej5 - palabras_con_variables(P, V).

% auxAsignarTodas(+Atomos, -MapeoFinal).
auxAsignarTodas([], []).
auxAsignarTodas([A|Ats], MF) :- auxAsignarTodas(Ats, MR), asignar_var(A, MR, MF).

% auxMapeoPalabra(+Mapeos, +Palabra, -MapeoPalabra)
auxMapeoPalabra(_, [], []).
auxMapeoPalabra(MF, [A|As], [V|Vs]) :- member((A,V), MF), auxMapeoPalabra(MF, As, Vs).

% auxMapeoPalabras(+Mapeos, +Palabras, -MapeosPalabras
auxMapeoPalabras(_, [], []).
auxMapeoPalabras(MF, [P|Ps], [V|Vs]) :-  length(P, N), length(V, N),auxMapeoPalabra(MF, P, V), auxMapeoPalabras(MF, Ps, Vs).

% palabras_con_variables(+Palabras, ?MapeosPalabras)
palabras_con_variables(P, V) :- flatten(P, Ats), auxAsignarTodas(Ats, MF), length(P, N), length(V, N), auxMapeoPalabras(MF, P, V).
