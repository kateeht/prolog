
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

chemin(X,Y,[X,Y],_) :- sens(X,Y).
chemin(X,Y,[X|L],Lt) :- sens(X,Z),not(member(Z,Lt)),chemin(Z,Y,L,[Z|Lt]).

correspondance(X,Y,Z):-sens(X,Z), sens(Z,Y).

/*voyager(X,Y,R) X,Y:donnee R;resultat.*/

voyager(X,Y,direct):- sens(X,Y),!.
voyager(X,Y,L):- liaison(X,Z), findall(correspondance(X,Y,Z),Z,L).
voyager(_,_,[]).

/*?- voyager(paris,lyon,R).
R = direct ;
false.
*/
voyager1(X,Y,direct):- sens(X,Y),!.
voyager1(X,Y,L):- findall(Z,(sens(X,Z), sens(Z,Y)),L), X \==Y, X\==Z, Y\==Z,!.
voyager1(_,_,[]).

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

recherche(Ef,Ef,_,[]):-!.
recherche(Ec,Ef,Letats,[Op|Lop]) :- operateur(Ec,Op,Es),
							not(member(Es,Letats)),
							not(interdit(Es)),
							write(Ec), write(' '),write(Op), write(' '),write(Es),nl,
							recherche(Es,Ef,[Es|Letats],Lop).

resoudre(Sol) :- etatInitial(Ei),etatFinal(Ef),recherche(Ei,Ef,[Ei],Sol).

:- dynamic interdit/1.

home([ferminer,loup,chevre,chou]).
etatInitial([g,g,g,g]).
etatFinal([d,d,d,d]).

iinterdit([F, L, C, _]) :- F \= L, L = C.  
interdit([F, _, C, Co]) :- F \= C, C = Co. 

inverse(g,d).
inverse(d,g).
 /* 1 seule fermier */
operateur([T1,L,C,Co],ferminer,[T2,L,C,Co]) :- inverse(T1,T2).
/* ferminer avec un seul des trois */
operateur([T1,T1,C,Co],[ferminer,loup],[T2,T2,C,Co]) :- inverse(T1,T2).
operateur([T1,L,T1,Co],[ferminer,chevre],[T2,L,T2,Co]) :- inverse(T1,T2).
operateur([T1,L,C,T1],[fermier,chou],[T2,L,C,T2]) :- inverse(T1,T2).


etages([[0,_],[1,_],[2,_],[3,_],[4,_]]).

permute([],[]).
permute(L,[X|Lp] ) :- 
        member(X,L),
        enleve(X,L,L1),
        permute(L1,Lp).

/* enlever un element d'une liste,
enleve (X,L1,L2) ,X nb donne, L1 liste donne, L2 resultat */
enleve(X,[X|L],L).
enleve(X,[Y|L1],[Y|L]) :- X\==Y, enleve(X,L1,L).

solution(L) :-
   L = [[0,P0],[1,P1],[2,P2],[3,P3],[4,P4]],
   permute([marie,alexis,remi,nathalie,olivier],[P0,P1,P2,P3,P4]),

   not(member([4,marie],L)),
   not(member([0,alexis],L)),
   not(member([0,remi],L)),
   not(member([4,remi],L)),

   member([ER,remi],L),
   member([EA,alexis],L),
   member([EO,olivier],L),
   abs(ER - EA) > 1,
   abs(ER - EO) > 1,

   member([EN,nathalie],L),
   EN > EA.
