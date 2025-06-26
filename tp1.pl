homme(albert).
homme(jean). 
homme(paul). 
homme(bertrand). 
homme(dominique). 
homme(benoit).
 
femme(germaine). 
femme(christiane). 
femme(simone). 
femme(marie). 
femme(sophie).

pere(albert,jean). 
pere(jean,paul). 
pere(paul,bertrand). 
pere(paul,sophie). 
pere(jean,simone). 
pere(louis,benoit). 

mere(germaine,jean). 
mere(christiane,simone). 
mere(christiane,paul). 
mere(simone,benoit). 
mere(marie,bertrand). 
mere(marie,sophie).

/* 2.3 Définition de prédicats */
/* X est un parent de Y, pere ou mere */
parent(X,Y) :- pere(X,Y).
parent(X,Y) :- mere(X,Y).

/* X est le fils de Y */
fils(X,Y) :- homme(X), parent(Y,X).

/*  X est la fille de Y */
fille(X,Y) :- femme(X), parent(Y,X).

/* X est le grand-pere de Y */
grand_pere(X,Y) :- homme(X), parent(X,Z), parent(Z,Y).
grand-pere1(X,Y) :- parent(Z,Y), pere(X,Z).

/* X est la grand-mere de Y */
grand_mere(X,Y) :- femme(X), parent(X,Z), parent(Z,Y).
gand_mere1(X,Y) :- parent(Z,Y), mere(X,Z).

/* X est le frere de Y */
frere(X,Y) :- homme(X), pere(Z,X), parent(Z,Y), X \= Y.
frere1(X,Y) :- homme(X), pere(P,X), pere(P,Y), mere(M,X), mere(M,Y), X \== Y.

/* X est la soeur de Y */
soeur(X,Y) :- femme(X), pere(Z,X), parent(Z,Y), X \= Y.
soeur1(X,Y) :- femme(X), pere(P,X), pere(P,Y), mere(M,X), mere(M,Y), X \== Y.

/*Traduction d’énoncés
Traduire en Prolog l'énoncé suivant :
Marie aime le vin
Pierre est un voleur
Pierre aime tous ceux qui aiment le vin
Si quelqu'un est un voleur et aime quelque chose alors il le vole
Qui vole quoi ? */

aime(marie,vin).
aime(pierre,X) :- aime(X,vin).
voleur(pierre).
vole(X,Y) :- voleur(X), aime(X,Y).
/*?- vole(X,Y).
X = pierre,
Y = marie  */

/* Unification 
?- pierre = maire.
false.

?- X =jean.
X = jean.

?- pierre=aime(X,Y).
false.

?- pere(X,Y)=aime(T,jean).
false.

?- X=parent(Y,paul).
X = parent(Y, paul).

?- [X,Y]=[a,b,c].
false.

?- [X,Y|L]=[a,b,c].
X = a,
Y = b,
L = [c].

?- [X|L]=[X,Y|L2].
L = [Y|L2].

?- pere(X,fille(X))=pere(jean,Y).
X = jean,
Y = fille(jean).
*/

/* Exercices sur les listes */

/* Définir le prédicat longueur(L,N), qui étant donnée la liste L calcule sa longueur N.
Longueur d'une liste, la liste est donnee, le resultat est un entier
 la liste est donnee, le resultat est un entier */
longueur([],0).
longueur([_|L],N) :- longueur(L,R), N is R+1.

/*Définir le prédicat concat(L1,L2,L3) où L3 est le résultat de la concaténation de L1 et L2 (sans utiliser append). 
Les 2 premieres listes sont donnees, la troisieme est le resultat*/
concat([],L2,L2).
concat(L1,[],L1).
concat([X|L1],L2,[X|L3]) :- concat(L1,L2,L3).

concat1([],L,L).
concat1([X|L1],L2,[X|L3]) :- concat(L1,L2,L3).

/*  Définir le prédicat palindrome(L) vrai si la liste L est sa propre image renversée.
L est une liste palindrome (liste donnee)
1 2 3 2 1
1 1 1 1 1
1 2 3 3 2 1 */
palindrome1(L) :- renverse(L,R), L==R.

renverse(L1,L2) :- renv(L1,[],L2).
renv([],Acc,Acc).
renv([X|L],Acc,L2) :- renv(L,[X|Acc],L2).

palindrome([]).
palindrome([_]).
palindrome([X|L]) :- append(L1,[X],L), palindrome(L1). 
 

/*  Définir un prédicat rang_pair(X,Y) qui extrait les éléments de la liste X qui ont des indices de rang pair afin de construire la liste Y. Ex. rang_pair([a,b,c,d,e],L). -> L=[b,d] */

rang_pair([],[]).
rang_pair([_],[]).
rang_pair([_,X|L],[X|R]) :- rang_pair(L,R).

/*ieme(L,I,X) L liste donnee, I entier donnee, X elt res */

ieme([X|_],1,X).
ieme([_|L],I,R) :- I>1, Im1 is I -1, ieme(L,Im1,R).


/* Définir le prédicat indice(X,L,N), qui étant donnés un élément X et une liste L, X appartenant à L, calcule N l’indice de la première occurrence de X dans L. Peut-on utiliser ce prédicat pour formuler une requête permettant de calculer le ième élément d’une liste ? */
/* indice(X,L,N), calcule N (resultat) l'indice de la premire occurrence de X (donnee) dans L (donnee), X appartenant a L */

indice(X,[X|_],1).
indice(X,[_|L],N) :- indice(X,L,N1), N is N1+1.

/* pour trouver le ieme element d'une liste :
?- indice(X,[a,b,c,d,e],3).

X = c
*/

/* Remplacement des occurences de X dans une liste par Y. Les 3 premiers parametres sont des donnees, le dernier le resultat */

remplace(_,_,[],[]).
remplace(X,Y,[X|L1],[Y|L2]) :- remplace(X,Y,L1,L2).
remplace(X,Y,[Z|L1],[Z|L2]) :- Z \== X, remplace(X,Y,L1,L2).

/* Calcul (resultat) de la somme des (i*Xi) d'une liste donnee
Utilisation d'un accumulateur */

somme(L,R) :- sommebis(L,1,R).
sommebis([],_,0).
sommebis([X|L],I,S2) :- J is I+1, sommebis(L,J,S1), S2 is X*I+S1.

/* partage(L,X,L1,L2), L et X donnes, calcule L1 qui contient les elements de L inf a X,
 et L2 ceux sup ou = a X */
 partage([],_,[],[]).
 partage([Y|L],X,[Y|L1],L2) :- Y<X, partage(L,X,L1,L2).
 partage([Y|L],X,L1,[Y|L2]) :- Y>=X, partage(L,X,L1,L2).
 

/* Écrire le prédicat somme(L,R) qui si L = (x1, x2, . . . , xn) calcule R =∑ixi */
somme1(L,R) :- sommebis(L,1,R).
sommebis1([],_,0).
sommebis1([X|L],I,S2) :- J is I+1, sommebis(L,J,S1), S2 is X*I+S1.

/* partage (L,X,L1,L2), L et X donnes, calcule L1 qui contient les éléments de L inf a X,
Et L2 ceux sup ou = a X */
partage1([],_,[],[]).
partage1([Y|L],X,[Y|L1],L2) :- Y<X, partage(L,X,L1,L2).
partage1([Y|L],X,L1,[Y|L2]) :- Y>=X, partage(L,X,L1,L2).

 










