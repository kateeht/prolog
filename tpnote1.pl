
/*partage(L,X,L1,l2). L:donne X:resultat L1,L2:resultat*/

partage([],_,[],[]).
partage([Y|L],X,[Y|L1],L2):- Y<X, partage(L,X,L1,L2). 
partage([Y|L],X,L1,[Y|L2]):- partage(L,X,L1,L2).

/*?- partage([1,2,3,4,5,6,7,8],4,L1,L2).
L1 = [1, 2, 3],
L2 = [4, 5, 6, 7, 8] */

passage(X,Y,M):- M is Y / X.

/*suite_geo(L). L: donnee*/
suite_geo([X,Y|L]):- passage(X,Y,M), test([Y|L],M).
 
test([],_).
test([_],_). 
test([X,Y|L],M):- X*M=:=Y , test([Y|L],M).

/*?- suite_geo([1,3,9,27,81]).
true ;
false.

?- suite_geo([1,2,5,8,9]).
false.*/

/*[+, [- [4, [],[]], [2,[],[]]] , [* ,[3,[],[]] , [5,[],[]]]]*/

/*calcule(L,R). L:donnee , R:resulat*/

calcule([X, [], []],X).
calcule([X, FG, FD], R):- X=:= '+' , calcule(FG,R1) , calcule(FD,R2), R is R1+R2.
calcule([X, FG, FD], R):- X=:= '-', calcule(FG,R1) , calcule(FD,R2), R is R1-R2.
calcule([X, FG, FD], R):- X=:= '*', calcule(FG,R1) , calcule(FD,R2), R is R1*R2.
calcule([X, FG, FD], R):- X=:= '/', calcule(FG,R1) , calcule(FD,R2), R is R1/R2.

/*?- calcule([+, [- [4, [],[]], [2,[],[]]] , [* ,[3,[],[]] , [5,[],[]]]],N).
ERROR: Arithmetic: `(+)/0' is not a function
ERROR: In:
ERROR:   [11] (+)=:=(+)
ERROR:   [10] calcule([+,...|...],_2944) at /home/etu/p2006277/LIFPROLOG/tpnote.pl:30
ERROR:    [9] toplevel_call(user:user: ...) at /usr/lib64/swipl-8.4.3/boot/toplevel.pl:1158
   Exception: (10) calcule([+, [-[4, [], []], [2, [], []]], [*, [3, [], []], [5, []|...]]], _1778) ? 
*/


liaison(paris, lyon).
liaison(paris,newyork).
liaison(lyon,bruxelles).
liaison(bruxelles,newyork).
liaison(lyon,strasbourg).
liaison(strasbourg,franckfort).

sens(X,Y):- liaison(X,Y).
sens(X,Y):- liaison(Y,X).

correspondance(X,Y,Z):-sens(X,Z), sens(Z,Y).

/*voyager(X,Y,R) X,Y:donnee R;resultat.*/

voyager(X,Y,direct):- !,sens(X,Y).
voyager(X,Y,L):- liaison(X,Z), findall(correspondance(X,Y,Z),Z,L).
voyager(_,_,[]).

/*?- voyager(paris,lyon,R).
R = direct ;
false.



*/

couleur(X):- X= rouge.
couleur(X):- X= bleu.
couleur(X):- X= jaune.

/*coloriage(A,B,C,D,E,F,G) A,B,C,D,E,F,G: resulats*/

coloriage(A,B,C,D,E,F,G):-

couleur(G),
couleur(A),
couleur(B),
B\==A,
couleur(C),
C\==A,
C\==B,
couleur(D),
D\==B,
E\==C,
couleur(E),
E\==C,
E\==D,
couleur(F),
F\==C,
F\==E.



/*?- coloriage(A,B,C,D,E,F,G).
A = D, D = F, F = G, G = rouge,
B = E, E = bleu,
C = jaune ;
A = E, E = G, G = rouge,
B = F, F = bleu,
C = D, D = jaune ;
*/
/*recherche(EtatCourant,EtatFinal,ListeTaboue,ListeOp) tous donnes sauf ListeOp */
recherche(Ef,Ef,_,[]):-!.
recherche(Ec,Ef,Letats,[Op|Lop]) :- operateur(Ec,Op,Es),
							not(member(Es,Letats)),
							not(interdit(Es)),
							write(Ec), write(' '),write(Op), write(' '),write(Es),nl,
							recherche(Es,Ef,[Es|Letats],Lop).

resoudre(Sol) :- etatInitial(Ei),etatFinal(Ef),recherche(Ei,Ef,[Ei],Sol).


/* probleme des explorateurs */
:- dynamic interdit/1.

etatInitial([b,b,b,b,n,n,n,n]).
etatFinal([n,b,n,b,n,b,n,b]).

inverse(n,b).
inverse(b,n).

operateur(E1, n4, E2) :- remplace([b,b,b,b,n,n,n,n], E1, [n,n,n,n,b,b,b,b], E2).
operateur(E1, n4, E2) :- remplace([n,n,n,n,b,b,b,b], E1, [b,b,b,b,n,n,n,n], E2).


operateur(E1, n3, E2) :- remplace([b,b,b,n,n,n], E1, [n,n,n,b,b,b], E2).
operateur(E1, n3, E2) :- remplace([n,n,n,b,b,b], E1, [b,b,b,n,n,n], E2).


operateur(E1, n2, E2) :- remplace([b,b,n,n], E1, [n,n,b,b], E2).
operateur(E1, n2, E2) :- remplace([n,n,b,b], E1, [b,b,n,n], E2).


operateur(E1, n1, E2) :- remplace([b,n], E1, [n,b], E2).
operateur(E1, n1, E2) :- remplace([n,b], E1, [b,n], E2).



/* remplace (SL1,L1,SL2,L2) tous donnes sauf L2 */
remplace(SL1,L1,SL2,L2) :- append(L5,L4,L1),
                            append(L3,SL1,L5),
                            append(L3,SL2,L6),
                            append(L6,L4,L2).




