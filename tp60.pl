




/*Dimitrios STEPHANOU p2006277 */

:- dynamic interdit/1.

/*recherche(EtatCourant,EtatFinal,ListeTaboue,ListeOp) tous donnes sauf ListeOp */
recherche(Ef,Ef,_,[]) :- !.
recherche(Ec,Ef,Le,[Op|Lop]) :- operateur(Ec,Op,Es),
							not(member(Es,Le)),
							not(interdit(Es)),
							/* write(Ec),write(' '),write(Op),write(' '),write(Es),nl, */
							recherche(Es,Ef,[Es|Le],Lop).
/*recherche+(EtatCourant,EtatFinal,ListeTaboue,ListeOp) tous donnes sauf ListeOp
recherche+ verifie si la une operation effectue sur l etat acuelle peut resulte à l etat final, avant d effectue d'autre operation, afin d eviter de s eloigner de l etat final si on y est a une operation pret.

*/
recherche+(Ef,Ef,_,[]) :- !.
recherche+(Ec,Ef,_,[Op]):-operateur(Ec,Op,Ef).
recherche+(Ec,Ef,Le,[Op|Lop]) :- operateur(Ec,Op,Es),
							not(member(Es,Le)),
							not(interdit(Es)),
							/* write(Ec),write(' '),write(Op),write(' '),write(Es),nl, */
							recherche+(Es,Ef,[Es|Le],Lop).

/*nombre de coup(resoudre): 2191
?- resoudre(Sol),length(Sol,N).
Sol = [gauche, haut, droite, droite, bas, gauche, gauche, haut, droite|...],
N = 2191 
*/
resoudre(Sol) :- etatInitial(Ei),etatFinal(Ef),recherche(Ei,Ef,[Ei],Sol).

/*resoudre+(Sol) Sol:résultat Sol
resoudre+ utilise recherche+ afin de trouver les solutions de resolution du problème. 

nombre de coup(resoudre+): 1787.

?- resoudre+(Sol),length(Sol,N).
Sol = [gauche, haut, droite, droite, bas, gauche, gauche, haut, droite|...],
N = 1787 .
*/
resoudre+(Sol):- etatInitial(Ei),etatFinal(Ef),recherche+(Ei,Ef,[Ei],Sol).

etatInitial([[2,8,3],[1,6,4],[7,hole,5]]).

etatFinal([[1,2,3],[8,hole,4],[7,6,5]]).


/*operateur(L,Op,LR) L,Op: donnes LR:resultat  
operateur cherche le trou du taquin et ensuite bouge celle-ci vers la direction decrit par Op.
*/


/*
?- operateur([[2,8,3],[1,hole,4],[7,6,5]],gauche,Ef).
Ef = [[2, 8, 3], [hole, 1, 4], [7, 6, 5]] ;
*/
operateur([[A,hole,C],Y,Z],gauche,[[hole,A,C],Y,Z]).
operateur([[A,B,hole],Y,Z],gauche,[[A,hole,B],Y,Z]).
operateur([X,[A,hole,C],Z],gauche,[X,[hole,A,C],Z]).
operateur([X,[A,B,hole],Z],gauche,[X,[A,hole,B],Z]).
operateur([X,Y,[A,hole,C]],gauche,[X,Y,[hole,A,C]]).
operateur([X,Y,[A,B,hole]],gauche,[X,Y,[A,hole,B]]).

/*
 operateur([[2,8,3],[1,hole,4],[7,6,5]],droite,Ef).
Ef = [[2, 8, 3], [1, 4, hole], [7, 6, 5]] ;

*/
operateur([[hole,B,C],Y,Z],droite,[[B,hole,C],Y,Z]).
operateur([[A,hole,C],Y,Z],droite,[[A,C,hole],Y,Z]).
operateur([X,[hole,B,C],Z],droite,[X,[B,hole,C],Z]).
operateur([X,[A,hole,C],Z],droite,[X,[A,C,hole],Z]).
operateur([X,Y,[hole,B,C]],droite,[X,Y,[B,hole,C]]).
operateur([X,Y,[A,hole,C]],droite,[X,Y,[A,C,hole]]).

/*
?- operateur([[2,8,3],[1,hole,4],[7,6,5]],bas,Ef).
Ef = [[2, 8, 3], [1, 6, 4], [7, hole, 5]] ;
*/
operateur([[hole,B,C],[D,E,F],Z],bas,[[D,B,C],[hole,E,F],Z]).
operateur([[A,hole,C],[D,E,F],Z],bas,[[A,E,C],[D,hole,F],Z]).
operateur([[A,B,hole],[D,E,F],Z],bas,[[A,B,F],[D,E,hole],Z]).
operateur([X,[hole,B,C],[D,E,F]],bas,[X,[D,B,C],[hole,E,F]]).
operateur([X,[A,hole,C],[D,E,F]],bas,[X,[A,E,C],[D,hole,F]]).
operateur([X,[A,B,hole],[D,E,F]],bas,[X,[A,B,F],[D,E,hole]]).

/*

?- operateur([[2,8,3],[1,hole,4],[7,6,5]],haut,Ef).
Ef = [[2, hole, 3], [1, 8, 4], [7, 6, 5]] 
*/
operateur([[A,B,C],[hole,E,F],Z],haut,[[hole,B,C],[A,E,F],Z]).
operateur([[A,B,C],[D,hole,F],Z],haut,[[A,hole,C],[D,B,F],Z]).
operateur([[A,B,C],[D,E,hole],Z],haut,[[A,B,hole],[D,E,C],Z]).
operateur([X,[A,B,C],[hole,E,F]],haut,[X,[hole,B,C],[A,E,F]]).
operateur([X,[A,B,C],[D,hole,F]],haut,[X,[A,hole,C],[D,B,F]]).
operateur([X,[A,B,C],[D,E,hole]],haut,[X,[A,B,hole],[D,E,C]]).


















