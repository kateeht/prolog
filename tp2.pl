/* 1. Tri à bulles */

/* Définir le prédicat bulle(L1,L2) qui construit la liste L2 qui est la liste L1 dans laquelle l’élément le plus petit est remonté en première place.  
L1 est liste donnée
L2 est liste résultat
*/
bulle([],[]).
bulle([X],[X]).
bulle([X|L],[Min,Max|L1]) :- bulle(L,[Y|L1]),
				Min is min(X,Y),
				Max is max(X,Y).

bulle1([],[]).
bulle1([X],[X]).
bulle1([X|L],[X,Z|L1]) :- bulle(L,[Z|L1]), X=<Z.
bulle1([X|L],[Z,X|L1]) :- bulle(L,[Z|L1]), X>Z.

/* Définir le prédicat tribulle(L1,L2) qui implémente le tri à bulles.
L1 est liste donee, L2 est liste resultat */

tribulle([],[]).
tribulle(L,[X|L3]) :- bulle(L,[X|L2]), tribulle(L2,L3).

a1([6, [4, [1, [], []], [8, [], []]], [9, [], []]]).
a2([6,[4,[1,[],[]],[]],[9,[],[]]]).
/* 2. Arbres binaires */

/* Définir un prédicat qui vérifie l’appartenance d’un élément à un arbre. Comment le prédicat se comporte-t-il en génération ? Que se passe-t-il si on inverse l’ordre des clauses ?  
element1(E,A)
E est element
A est un arbre
*/

element1(X,[X,_,_]).
element1(X,[Y,G,_]) :- X\==Y, element1(X,G).
element1(X,[Y,_,D]) :- X\==Y, element1(X,D).
/* donne un parcours prefixe */

element2(X,[Y,G,_]) :- X\==Y, element2(X,G).
element2(X,[X,_,_]).
element2(X,[Y,_,D]) :- X\==Y, element2(X,D).
/* donne un parcours infixe */

element3(X,[Y,G,_]) :- X\==Y, element3(X,G).
element3(X,[Y,_,D]) :- X\==Y, element3(X,D).

/*  Définir un prédicat qui construit la liste des valeurs des feuilles d’un arbre 
feuille(A,L)
A est un arbre
L est une liste des feuilles (résultates)
*/
feuilles([],[]).
feuilles([N,[],[]],[N]).
feuilles([_,G,[]],L) :-G\==[], feuilles(G,L).
feuilles([_,[],D],L) :-D\==[], feuilles(D,L).
feuilles([_,G,D],L) :- G\==[], D\==[],feuilles(G,L1),feuilles(D,L2), append(L1,L2,L).
/* un predicat "feuille(A)" vrai si A est une feuille permettrait de simplifier ce predicat */



/* 3 Arbres binaires de recherche */

/* Arbres binaires de recherche */
abr1([6,[4,[1,[],[]],[5,[],[]]],[9,[],[]]]).
abr2([6,[4,[1,[],[]],[]],[9,[],[]]]).

/* Définir un prédicat d'insertion d'un élément dans un ABR 
Insertion d'un élément aux feuilles d'un ABR
insere(X,A,R) X nb donnę, A ABR donnę, R ABR resultat*/

insere(X,[],[X,[],[]]).
insere(X,[N,G,D],[N,G1,D]) :- X =< N, insere(X,G,G1).
insere(X,[N,G,D],[N,G,D1]) :- X > N, insere(X,D,D1).

/* Définir un prédicat qui calcule le plus grand élément d'un ABR et retourne également l'arbre privé de cet élément. Tìm phần tử lớn nhất trong một ABR, Trả về cây sau khi đã loại bỏ phần tử lớn nhất đó.
Calcul et suppression du maximum: suprmax(ABR donne, nb résultat, ABR résultat prive du max)
*/

suprmax([N,G,[]],N,G).
suprmax([N,G,D],M,[N,G,D1]) :- D\==[],suprmax(D,M,D1).

/* Définir un prédicat qui supprime un élément d'un ABR.
supr(nb donne, ABR donnę, ABR resultat)
*/
supr(_,[],[]).
supr(X,[N,G,D],[N,G1,D]) :- X<N, supr(X,G,G1).
supr(X,[N,G,D],[N,G,D1]) :- X>N, supr(X,D,D1).
supr(X,[X,[],D],D).
supr(X,[X,G,[]],G) :- G\==[].
supr(X,[X,G,D],[M,G1,D]) :- G\==[],D\==[],suprmax(G,M,G1).

/* Définir un prédicat qui construit un ABR à partir d'une liste de nombres par des insertions
successives.
Construction d'un ABR (résultat) a partier d'une liste donne
*/
/* construction d'un ABR (resultat) a partir d'une liste (donnee) */
construire([],[]).
construire([X|L],A) :- construire(L,A1), insere(X,A1,A).

/* tri d'une liste via la construction d'un ABR */
/* L liste de nb donnee, L1 liste de nb triee resultat */
triarbre(L,L1) :- construire(L,A), infixe(A,L1).

/* liste (resultats) du parcours infixe d'un arbre (donne) */
infixe([],[]).
infixe([N,G,D],L) :- infixe(G,L1), infixe(D,L2), append(L1,[N|L2],L).

/*Ensembles (facultatif) */
/* Définir un prédicat to_list(X,Y) qui transforme une liste X en un ensemble Y (on élimine toutes les occurrences qui sont présentes plus d'une fois dans la liste)
Exemple : to_list([a,b,c,b,d,e,d],L). -> L=[a,b,c,d,e] 
X liste donne, Y liste resulta */
to_list([],[]).
to_list([X|L],[X|L2]) :- elimine_tout(L,X,L1), to_list(L1,L2).

elimine_tout([],_,[]).
elimine_tout([X|L],X,L1) :- elimine_tout(L,X,L1).
elimine_tout([Y|L],X,[Y|L1]) :- X\==Y, elimine_tout(L,X,L1). 

/* Définir un prédicat inclus(X,Y) qui teste l’inclusion de l’ensemble X dans l’ensemble Y.
Exemple : inclus([a,c,v],[e,v,a,c,f]). ® Yes
Deux listes-ensembles donnes
*/
inclus([],_).
inclus([X|L],L1) :- member(X,L1), inclus(L,L1).

/* Définir un prédicat inter(X,Y,Z)qui construit l’ensemble Z intersection des deux ensembles X et Y(une ligne avec findall).
Exemple : inter([a,b,c,d,e],[d,r,a,e,f],L). ® L=[a,d,e] 

L1 L2 deux listes-ensembles données, L3 résultat */
inter(L1,L2,L3) :- findall(X,(member(X,L1),member(X,L2)),L3).

inter2([],_,[]).
inter2([X|L1],L2,[X|L3]) :- member(X,L2), inter2(L1,L2,L3).
inter2([X|L1],L2,L3) :- not(member(X,L2)), inter2(L1,L2,L3).

/*findall(Variable, Condition, List)
Variable: Giá trị cần lấy.
Condition: Điều kiện mà Variable phải thỏa mãn.
List: Danh sách chứa tất cả các giá trị của Variable thỏa mãn Condition */





 



  
  















