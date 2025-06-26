/* STEPHANOU Dimitrios p2006277*/

/* on donne les valeurs pour le nombre de pays (variables) et  les couleurs (domaines des variables) */

/*nbPays(7).
couleur([bleu,rouge,vert,jaune]).*/

/*domaines2(N,V,L). N,V: données L:résultat domaines
cette fonction trouve la liste L de couple (variable,domaine des variables)*/
domaines2(1,V,[[1,V]]):-!.
domaines2(N,V,[X|L]):- X=[N,V],N1 is N-1, domaines2(N1,V,L).

/*domaines(L). L:resultat
domaines recupere le nombre de pays et la liste des couleurs et renvoie L en appelant domaines2
?- domaines(L).
L = [[7, [bleu, rouge, vert, jaune]], [6, [bleu, rouge, vert, jaune]], [5, [bleu, rouge, vert, jaune]], [4, [bleu, rouge, vert|...]], [3, [bleu, rouge|...]], [2, [bleu|...]], [1, [...|...]]].

*/
domaines(L):- nbPays(N), couleur(V), domaines2(N,V,L).

voisins(1,2):-!.
voisins(1,3):-!.
voisins(1,7):-!.
voisins(2,3):-!.
voisins(2,4):-!.
voisins(2,5):-!.
voisins(3,4):-!.
voisins(3,5):-!.
voisins(3,6):-!.
voisins(3,7):-!.
voisins(4,5):-!.
voisins(5,6):-!.
voisins(6,7):-!.

voisins2(X,Y):- voisins(X,Y).
voisins2(X,Y):- voisins(Y,X).


/*consistant([X1,V1],[X2,V2]). les deux listes sont des donnnees domaines
consistant test si X1 et X2 peuvent avoir les couleurs V1,V2

?- consistant([1,bleu],[2,bleu]).
false.

*/
consistant([X1,_],[X2,_]):- not(voisins2(X1,X2)),!.
consistant([X1,V1],[X2,V2]):- voisins2(X1,X2),!, V1 \== V2.

/*generer(L,R). L:Donnees R:Resultat 
generer donne reunni R a toute les liste R possible*/

generer([],[]).
generer([[X,C]|R],[[X,Z]|R2]):- generer(R,R2), member(Z,C).


/*tester2([X1,V1],R) L1:donne ,R:resultat
tester2 verifie si X1 peut prendre la couleur V1 par rapport a la liste R*/

tester2(_,[]).
tester2(L1,[L2|R]):-consistant(L1,L2),tester2(L1,R).

/*tester(L) L:Donne
tester verifie si la solution L est coherante*/
tester([]).
tester([L1|R]):- tester2(L1,R), tester(R).

/*genererTester(R) R:resultat
genererTester reunni R a toute les solution coherente*/
genererTester(R):- domaines(D), generer(D,R), tester(R).

generertester2([],_,[]).
generertester2([[X,C]|L1],L2,[[X,Z]|L3]):- write(L2), member(Z,C), tester2([X,Z],L2), generertester2(L1,[[X,Z]|L2],L3).

retourA(R):- domaines(D), generertester2(D,[],R).

/*Question5
Nombre de solutions du probleme de carte: 120

Temps d'execution:

retourA:
% 36,189 inferences, 0.006 CPU in 0.006 seconds (100% CPU, 6116468 Lips)

genererTester:

% 1,013,274 inferences, 0.132 CPU in 0.132 seconds (100% CPU, 7677018 Lips)

*/


/*Question6 

pour lui faire resoudre le probleme du coloriage d'une autre carte il suffit  de modifier nbPays, couleur, et voisins.

*/

inscrits(lif1,[marc,jean,paul,pierre,anne,sophie,thierry,jacques]).
inscrits(lif2,[anne,pierre,emilie,antoine,juliette]).
inscrits(lif3,[juliette,antoine,thierry,jean,edouard]).
inscrits(lif4,[andre,oliver,beatrice]).
inscrits(lif5,[edouard,paul,pierre,emilie]).
inscrits(lif6,[andre,beatrice,amelie]).

/*Question7
Pour cette partie je ne redefini pas domaines il suffit de modifier nbPays et couleur
*/

nbPays(10).
couleur(C):-findall(X,inscrits(X,_),C).





