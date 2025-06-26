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

/* 2.3 */
/* X est un parent de Y, pere ou mere */
parent(X,Y) : mere(X,Y).
parent(X,Y) : pere(X,Y).

/* X est le fils de Y */
fils(X,Y) : homme(X), parent(Y,X).

/*  X est la fille de Y */
fille(X,Y) : femme(X), parent(Y,X).

/* X est le grand-pere de Y */
grand_pere(X,Y) : pere(X,Z), parent(Z,Y).

/* X est la grand-mere de Y */
grand_mere(X,Y) : mere(X,Z), parent(Z,Y).

/* X est le frere de Y */
frere(X,Y) : homme(X), pere(Z,X), pere(Z,Y), mere(T,X), mere(T,Y), X \== Y.

/* X est la soeur de Y */
soeur(X,Y) : fille(X), pere(Z,X), pere(Z,Y), mere(T,X), mere(T,X), X \== Y.

/* Traduction d'enonces */
 aime (marie, vin).
 voleur(pierre).
 aime(pierre,X) :- aime(X,vin).
 vole(X,Y) : voleur(X), aime(X,Y).

 /* longueur(L,N) L liste donne, N est le resultat un entier  */
 longueur([],0).
 longueur([_|L],N) :- longueur(L,M), N is M +1. 

 /* concat(L1,L2,L3), L1 et L2 les liste donnees, L3 liste resultat    */
 concat([],L2,L2).
 concat([X|L1],L2,[X|L3]) :- concat(L1,L2,L3).

 /* palindrome(L) L est une liste palindrome (liste donnee) */
 palindrome([]).
 palindrome([_]).
 palindrome([X|L]) :- append(L1,[X],L), palindrome(L).

 /* rang_pair(X,Y) extrait les elements de la liste X (donnee) qui ont des indices de rang pair afin de
 construire la liste Y (resultat) */
 rang_pair([],[]).
 rang_pair([_],[]).
 rang_pair([_,Y|L],[Y|L1]) :- rang_pair(L,L1).

 /* indice(X,L,N), calcule N (resultat) l'indice de la premire occurrence de X (donnee) dans L (donnee), X appartenant a L */

 indice(X,[X|_],1).
 indice(X,[Y|L],N) :- X \== Y ,indice(X,L,M), N is M+1.

 /* Remplacement des occurences de X dans une liste par Y. Les 3 premiers parametres sont des donnees, le dernier le resultat */
 remplace(_,_,[],[]).
 remplace(X,Y,[X|L1],[Y|L2]) :- remplace(X,Y,L1,L2).
 remplace(X,Y,[Z|L1],[Z|L2]) :- Z \== X, remplace(X,Y,L1,L2).

 /* Calcul (resultat) de la somme des (i*Xi) d'une liste donnee
Utilisation d'un accumulateur */
somme(L,R) :- sommebis(L,1,R).
sommebis([],_,0).
sommebis([X|L],I,S) :- J is I + 1, sommebis(L,J,S1), S is X*I + S1 

/* partage(L,X,L1,L2), L et X donnes, calcule L1 qui contient les elements de L inf a X,
 et L2 ceux sup ou = a X */
 partage([],_,[],[]).
 partage([Y|L],X,[Y|L1],L2) :- Y<X, partage(L,X,L1,L2).
 partage([Y|L],X,L1,[Y|L2]) :- Y>=X, partage(L,X,L1,L2).