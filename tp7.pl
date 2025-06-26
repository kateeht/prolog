/* TRUONG Thi Hanh p2303609  */

/* on donne les valeurs pour les employes (variables) et  le nombre de semaines (domaines des variables) */
employes([michel,arthur,isabelle,olivier,antoine,noemie,robert]).
nbsemaine([1,2,3,4,5]).

/*domaines1(E,S,L). E,S: données L:résultat domaines
cette fonction trouve la liste L de couple (variable,domaine des variables)*/
domaines1([X],S,[[X,S]]) :-!.
domaines1([E|L1],S,[X|L]) :- X=[E,S],domaines1(L1,S,L).

/*domaines(L). L:resultat
domaines recupere le nom d'employe et la liste des semaines et renvoie L en appelant domaines1 */
domaines(L) :- employes(E), nbsemaine(S), domaines1(E,S,L).

/* ?- domaines(L).
L = [[michel, [1, 2, 3, 4, 5]], [arthur, [1, 2, 3, 4, 5]], [isabelle, [1, 2, 3, 4|...]], [olivier, [1, 2, 3|...]], [antoine, [1, 2|...]], [noemie, [1|...]], [robert, [...|...]]]. */

meme_service(arthur,isabelle) :- !.
meme_service(arthur,olivier) :- !.
meme_service(isabelle,olivier):- !.
meme_service(antoine,noemie):- !.

meme_service1(X,Y) :- meme_service(X,Y).
meme_service1(X,Y) :- meme_service(Y,X).

/*consistants([X1,V1],[X2,V2]). les deux listes sont des donnnees domaines
consistants test si X1 et X2 peuvent avoir les memes valeur V1,V2 */
consistants([X1,_],[X2,_]) :- not(meme_service1(X1,X2)),!.
consistants([X1,V1],[X2,V2]) :- meme_service1(X1,X2),!,V1 \== V2.

/*
?- consistants([arthur,1],[isabelle,2]).
true.
?- consistants([arthur,1],[isabelle,1]).
false.
?- consistants([isabelle,1],[arthur,1]).
false.  */

/*tester([X1,V1],R) L1:donne ,R:resultat
tester verifie si X1 peut prendre la semaine V1 par rapport a la liste R*/

tester(_,[]).
tester(L1,[L2|R]):- consistants(L1,L2),!,tester(L1,R).

/*genererEtTeste(Sol) Sol:resultat
genererEtTeste reunni R a toute les solution coherente

generertetster(L1,L2,R) L1,L2: donnes, R: resultat
*/

generertester([],_,[]).
generertester([[X,Y]|L1],L2,[[X,Z]|L3]):- write(L2), member(Z,Y), tester([X,Z],L2), generertester(L1,[[X,Z]|L2],L3).

genererEtTeste(R) :- domaines(D), generertester(D,[],R).


/*  ?- genererEtTeste(R).
[][[michel,1]][[arthur,1],[michel,1]][[isabelle,2],[arthur,1],[michel,1]][[olivier,3],[isabelle,2],[arthur,1],[michel,1]][[antoine,1],[olivier,3],[isabelle,2],[arthur,1],[michel,1]][[noemie,2],[antoine,1],[olivier,3],[isabelle,2],[arthur,1],[michel,1]]
R = [[michel, 1], [arthur, 1], [isabelle, 2], [olivier, 3], [antoine, 1], [noemie, 2], [robert, 1]]  */

/*
?- findall(X,genererEtTeste(X),L), length(L,N).
N = 30000. 
*/


/*generer(L,R). L:Donnees R:Resultat 
generer donne reunni R a toute les liste R possible*/

generer([],[]).
generer([[X,Y]|R],[[X,Z]|R2]):- generer(R,R2), member(Z,Y).

/*tester1(L) L:Donne
tester1 verifie si la solution L est coherante*/
tester1([]).
tester1([L1|R]):- tester(L1,R), tester1(R).

/* affectationPartielle(Sol) Sol:resultat
affectationPartielle reunni R a toute les solution coherente*/
affectationPartielle(R):- domaines(D), generer(D,R), tester1(R).

/* 
?- affectationPartielle(R).
R = [[michel, 1], [arthur, 3], [isabelle, 2], [olivier, 1], [antoine, 2], [noemie, 1], [robert, 1]] ;
R = [[michel, 2], [arthur, 3], [isabelle, 2], [olivier, 1], [antoine, 2], [noemie, 1], [robert, 1]] ;
R = [[michel, 3], [arthur, 3], [isabelle, 2], [olivier, 1], [antoine, 2], [noemie, 1], [robert, 1]] .

?- findall(X,affectationPartielle(X),L), length(L,N).
L = [[[michel, 1], [arthur, 3], [isabelle, 2], [olivier, 1], [antoine, 2], [noemie, 1], [robert|...]], [[michel, 2], [arthur, 3], [isabelle, 2], [olivier, 1], [antoine, 2], [noemie|...], [...|...]], [[michel, 3], [arthur, 3], [isabelle, 2], [olivier, 1], [antoine|...], [...|...]|...], [[michel, 4], [arthur, 3], [isabelle, 2], [olivier|...], [...|...]|...], [[michel, 5], [arthur, 3], [isabelle|...], [...|...]|...], [[michel, 1], [arthur|...], [...|...]|...], [[michel|...], [...|...]|...], [[...|...]|...], [...|...]|...],
N = 30000. 
*/

/* question 4:
?- time(genererEtTeste(R)).
% 249 inferences, 0.000 CPU in 0.000 seconds (95% CPU, 3000000 Lips)

?- time(affectationPartielle(R)).
% 67,675 inferences, 0.009 CPU in 0.009 seconds (98% CPU, 7361579 Lips) */

/* question 5: */
stagiares([s1,s2,s3,s4,s5,s6]).
entreprises([e1,e2,e3,e4,e5,e6]).

preferences(s1,[[1,e2], [2,e4], [2,e6]]).
preferences(s2,[[1,e2], [1,e5], [2,e6]]).
preferences(s3,[[1,e1], [2,e3], [3,e6]]).
preferences(s4,[[1,e6], [2,e3]]).
preferences(s5,[[1,e2], [2,e1], [3,e5]]).
preferences(s6,[[1,e6], [2,e4], [2,e2], [3,e5], [4,e1]]).

preferences(e1,[[1,s5], [1,s3], [2,s6]]).
preferences(e2,[[1,s2], [2,s5], [3,s1]]).
preferences(e3,[[1,s3], [1,s4]]).
preferences(e4,[[1,s6], [2,s1]]).
preferences(e5,[[1,s5], [2,s2], [3,s6]]).
preferences(e6,[[1,s1], [2,s4], [2,s6], [3,s2], [4, s3]]).

/* aime(X,L2) X: donnes, L2 : resultat
Lấy danh sách các giá trị từ preferences */
aime([],[]).
aime([[_,V]|L],[V|R]) :- aime(R,L).

/* Kiểm tra xem một giá trị có trong danh sách ưu tiên của một thực thể không */
dans_preferences(X,Y) :- preferences(X,L), aime(L,V), member(Y,V).

 /*% Tạo miền giá trị cho một stagiaire*/
domaine_stagiaire(S,D) :- preferences(S,P), dans_preferences(P,V), findall(E,(member(E,V),dans_preferences(E,S)),D).

/*domaines3(S,E,L). S,E: données L:résultat domaines
cette fonction trouve la liste L de couple (variable,domaine des variables)
Tạo danh sách các cặp [Stagiaire, Miền giá trị]*/
domaines3([],_,[]) :-!.
domaines3([S|L1],E,[[S,D]|L]) :- domaine_stagiaire(S,D), domaines3(L1,E,L).

domaines4(L) :- stagiares(S), entreprises(E), domaines3(S,E,L).








