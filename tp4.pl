/* Labyrinthe : Mê cung  */
/* Modéliser le plan suivant en indiquant à Prolog les liens entre les salles.  */
couloir(entree, thesee).
couloir(entree, ariane).
couloir(thesee, minotaure).
couloir(thesee,sombre).
couloir(claire, sombre).
couloir(claire, sortie).
couloir(minotaure, sortie).
couloir(ariane, claire).
couloir(sombre,sortie).

passage(X,Y) :- couloir(X,Y).
passage(X,Y) :- couloir(Y,X).

/* Écrire le prédicat chemin(X,Y, Parcours), qui donne sous forme de liste le parcours qui permet
d’aller de la salle X à la salle Y.   */
chemin(X,X,[X]) :- !.
chemin(X,Y,[X|L]) :- passage(X,Z), chemin(Z,Y,L).



chemin1(X,Y,[X,Y]) :- couloir(X,Y).
chemin1(X,Y,[X|Suite]) :- 
    couloir(X,Z),
    chemin1(Z,Y,Suite).

/*  Tester chemin(entree, sortie, Parcours). Quels sont les problèmes ?   
L'erreur "Stack limit exceeded" indique que votre prédicat chemin/3 entre dans une récursion infinie, ce qui fait exploser la mémoire.
chemin(entree, sortie, [entree | Suite])
chemin(thesee, sortie, [thesee | Suite])
chemin(entree, sortie, [entree | Suite])  % Retourne à l'entrée et recommence
...
*/


/* • Modifier le prédicat chemin(X,Y,Parcours) en chemin_sans_boucle(X, Y, Parcours, ListeTaboue)
pour obtenir les solutions. */
chemin_sans_boucle(X,X,[X],_) :- !.
chemin_sans_boucle(X,Y,[X|L],ListeTaboue) :- 
                        passage(X,Z),
                        not(member(Z,ListeTaboue)),
                        chemin_sans_boucle(Z,Y,L,[Z|ListeTaboue]).

/* Quelle requête permet de sortir du labyrinthe avec Ariane en évitant la salle du Minotaure ? 
chemin_sans_boucle(ariane, sortie, Parcours, [ariane, minotaure]).
*/

/* Pour avoir une solution :
?- chemin(entree,sortie,Parcours,[entree]),member(ariane,Parcours),not(member(minotaure,Parcours)).
Parcours = [entree, ariane, claire, sombre, sortie] ;
Parcours = [entree, ariane, claire, sortie] ;
No
*/

/* 2 Coupure */
/*  Définir trois versions du prédicat soustrait(L1,L2,L3), qui étant données les listes L1 et
L2, construit la liste L3 qui contient les éléments de L1 qui n’appartiennent pas à L2 :
- avec un test,
- avec une coupure,
- en enlevant la coupure.
Comparer le fonctionnement de ces trois versions.  */
/* test */
soustrait([],_,[]).
soustrait([X|L1],L2,L) :- member(X,L2), soustrait(L1,L2,L).
soustrait([X|L1],L2,[X|L]) :- not(member(X,L2)), soustrait(L1,L2,L).

/*?- soustrait([a,b,c,d,e],[b,d],K).
K = [a, c, e] ;
No
*/


/* avec une coupure */
soustrait1([],_,[]).
soustrait1([X|L1],L2,L) :- member(X,L2),!, soustrait1(L1,L2,L).
soustrait1([X|L1],L2,[X|L]) :- soustrait1(L1,L2,L).


/* en enlevant la coupure. */
soustrait2([],_,[]).
soustrait2([X|L1],L2,L) :- member(X,L2), soustrait2(L1,L2,L).
soustrait2([X|L1],L2,[X|L]) :- soustrait2(L1,L2,L).
/* Meme fonctionnement, par contre si on enleve la coupure, le predicat donne des reponses fausses */

/* 3 Négation
Définir un prédicat disjoints(L1,L2) satisfait si L1 et L2 sont deux listes qui n'ont aucun
élément en commun (une ligne).  */
disjoints(L1,L2) :- not((member(X,L1),member(X,L2))).

/* 4 Génération
Définir le prédicat permute(L1,L2), qui étant donnée la liste L1, construit la liste L2 contenant une
permutation de L1.
Exemple : findall(L,permute([1,2,3],L),R).
R = [[1,2,3],[1,3,2],[2,1,3],[2,3,1],[3,1,2],[3,2,1]]   */
permute([],[]).
permute(L,[X|Lp] ) :- 
        member(X,L),
        enleve(X,L,L1),
        permute(L1,Lp).

/* enlever un element d'une liste,
enleve (X,L1,L2) ,X nb donne, L1 liste donne, L2 resultat */
enleve(X,[X|L],L).
enleve(X,[Y|L1],[Y|L]) :- X\==Y, enleve(X,L1,L).


/* 5 Triangle de nombres
On veut placer les nombres de 1 à 6 en triangle, sur les sommets et sur les milieux des segments, en
utilisant un nombre une fois seulement, de façon à ce que la somme des trois nombres utilisés soit
la même pour les trois cotés du triangle.
1. En utilisant permute, écrire le programme qui donne la solution de ce problème.
2. Combien y a-t-il de solutions ? Le prédicat length(X,Long), combiné à findall
peut servir à les compter.  */

triangle([N1,N2,N3,N4,N5,N6]) :- 
        permute([1,2,3,4,5,6],[N1,N2,N3,N4,N5,N6]),
        S is N1 + N5 + N6,
        S is N1 + N2 + N3,
        S is N3 + N4 + N5.
/* 
findall([N1,N2,N3,N4,N5,N6],triangle([N1,N2,N3,N4,N5,N6]),L),length(L,N). 
N = 24.
*/

 /* triangle(liste_de_6_nombres) */
 triangle1([N1,N2,N3,N4,N5,N6]) :- permute([1,2,3,4,5,6],[N1,N2,N3,N4,N5,N6]), M1 is N1+N2+N3,
 	M2 is N1+N6+N5, M3 is N3+N4+N5, M1==M2, M2==M3.
 	
 /* findall(L,triangle(L),L1), length(L1,N). donne 24 */
 


/* 6 Pour aller plus loin (exercices facultatifs)
• Soit un programme contenant des faits tels que : jeune(alfred), jeune(toto), etc.
Ajouter à ce programme la règle suivante : « Si un individu est jeune, il aime le sport, sinon il aime
le jardinage », en utilisant une coupure. On souhaite utiliser ce prédicat pour savoir ce qu’aime
quelqu’un. Testez ce prédicat.
Utilisez le prédicat pour poser la question suivante : « Est-ce que toto aime le jardinage ? » Corriger
votre programme. */

jeune(alfred).
jeune(toto).

aime(X,sport) :- jeune(X), !.
aime(_,jardinage).

/* version corrigee */
 aime2(X,Quoi) :- jeune(X),!,Quoi=sport.
 aime2(_,jardinage).

 /* inserer(X,L1,L2) l'insertion de X dans la liste triŽe L1 donne L2 */
 inserer(X,[],[X]).
 inserer(X,[Y|L],[X,Y|L]) :- X=<Y.
 inserer(X,[Y|L],[Y|L1]) :- X>Y, inserer(X,L,L1).
 
 /* version en remplaant le test par une coupure */
 inserer2(X,[],[X]).
 inserer2(X,[Y|L],[X,Y|L]) :- X=<Y,!.
 inserer2(X,[Y|L],[Y|L1]) :- inserer2(X,L,L1).
 
 /* meme probleme que precedemment pour le test faux : n'unifie pas avec la tete de clause
 donc ne passe pas sur la coupure. Moralite : comme d'habitude, quand on ecrit le predicat en
 pensant a une utilisation (ici calculer le troisieme argument) il est dangereux de l'utiliser
 autrement */
 
 /* version qui marche 	aussi dans le cas du test faux */
 inserer3(X,[],[X]).
 inserer3(X,[Y|L],T) :- X=<Y,!,T=[X,Y|L].
 inserer3(X,[Y|L],[Y|L1]) :- inserer3(X,L,L1).






