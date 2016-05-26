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