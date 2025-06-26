/* p2303609 TRUONG Thi Hanh */

/* recherche dans un graphe d'etats */

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
:- discontiguous operateur/3.

etatInitial([jungle,jungle,jungle,jungle,jungle]).
etatFinal([campement,campement,campement,campement,campement]).


explorateurs([alice,bob,charlie,david]).

interdit([_,jungle,jungle,campement,campement]).
interdit([_,campement,campement,jungle,jungle]).


/* operateur(L,Op,LR) L,Op: donnes LR:resultat  */
/* 1 seule explorateur tranverse */

operateur([T1,T1,B,C,D],alice,[T2,T2,B,C,D]) :- inverse(T1,T2).
operateur([T1,A,T1,C,D],bob,[T2,A,T2,C,D]) :- inverse(T1,T2).
operateur([T1,A,B,T1,D],charlie,[T2,A,B,T2,D]) :- inverse(T1,T2).
operateur([T1,A,B,C,T1],david,[T2,A,B,C,T2]) :- inverse(T1,T2).

inverse(jungle,campement).
inverse(campement,jungle).
/* 2 explorateur (pas Alice,Bob ensemble), (pas Bob et Charlie ensemble) */

operateur([T1,T1,B,T1,D],[alice,charlie],[T2,T2,B,T2,D]) :- inverse(T1,T2).
operateur([T1,T1,B,C,T1],[alice,david],[T2,T2,B,C,T2]) :- inverse(T1,T2).

operateur([T1,A,T1,C,T1],[bob,david],[T2,A,T2,C,T2]) :- inverse(T1,T2).

operateur([T1,A,B,T1,T1],[charlie,david],[T2,A,B,T2,T2]) :- inverse(T1,T2). 


/*Sol = [[alice, charlie], alice, bob, charlie, david, bob, alice, david, [...|...]|...] 
N = 1212. */

/* probleme des fleches */


etatInitial1([b,h,h,b,b,h]).
etatFinal1([b,b,b,h,h,h]).

operateur1(Ec,r1,Es) :- remplace([h,h],Ec,[b,b],Es).
operateur1(Ec,r2,Es) :- remplace([h,b],Ec,[b,h],Es).
operateur1(Ec,r3,Es) :- remplace([b,h],Ec,[h,b],Es).
operateur1(Ec,r4,Es) :- remplace([b,b],Ec,[h,h],Es).

/* remplace(SL1,L1,SL2,L2) tous donnes sauf L2 */
remplace(SL1,L1,SL2,L2):-append(L5,L4,L1),
						append(L3,SL1,L5),
						append(L3,SL2,L6),
						append(L6,L4,L2).

/* La distance entre deux etats 
distance(E1,E2,N) E1,E2 liste donne, N: resultat (nombre) */
distance([],[],0).
distance([X|E1],[X|E2],D) :- !, distance(E1,E2,D).
distance([_|E1],[_|E2],D) :- distance(E1,E2,D1), D is D1 + 1. 

/* meilleur_etat(EtatCourant,EtatFinal,ListeTaboue,ListeOp,EtatSuivant)  */

meilleur_etat(Ec,Ef,Letats,Op,Es) :- findall([D,[Opt,Est]],
                            (operateur1(Ec,Opt,Est),
							not(member(Est,Letats)),
							not(interdit(Est)),
                            distance(Est,Ef,D)),L),
							trouver_min(L, [_, [Op, Es]]).
                            
/*Trouver l'element avec distance minimale  */
trouver_min([X], X).
trouver_min([[D1, E1], [D2, _]|R], M) :- D1 =< D2, !, trouver_min([[D1, E1]|R], M).
trouver_min([_, [D2, E2]|R], M) :- trouver_min([[D2, E2]|R], M).

/* recherche+(EtatCourant,EtatFinal,ListeTaboue,ListeOp) tous donnes sauf ListeOp  */
recherche+(Ef,Ef,_,[]):-!.
recherche+(Ec,Ef,Letats,[Op|Lop]) :- meilleur_etat(Ec,Ef,Letats,Op,Es),
							write(Ec), write(' '),write(Op), write(' '),write(Es),nl,
							recherche+(Es,Ef,[Es|Letats],Lop).

resoudre+(Sol) :- etatInitial1(Ei),etatFinal1(Ef),recherche+(Ei,Ef,[Ei],Sol).

/*  ?- resoudre+(Sol).
[b,h,h,b,b,h] r1 [b,b,b,b,b,h]
[b,b,b,b,b,h] r4 [b,b,b,h,h,h]
Sol = [r1, r4] ;
false.
 */

/* 
?- resoudre+(Sol).
[jungle,jungle,jungle,jungle,jungle] [alice,charlie] [campement,campement,jungle,campement,jungle]
[campement,campement,jungle,campement,jungle] alice [jungle,jungle,jungle,campement,jungle]
[jungle,jungle,jungle,campement,jungle] [alice,david] [campement,campement,jungle,campement,campement]
[campement,campement,jungle,campement,campement] charlie [jungle,campement,jungle,jungle,campement]
[jungle,campement,jungle,jungle,campement] bob [campement,campement,campement,jungle,campement]
[campement,campement,campement,jungle,campement] alice [jungle,jungle,campement,jungle,campement]
[jungle,jungle,campement,jungle,campement] [alice,charlie] [campement,campement,campement,campement,campement]
Sol = [[alice, charlie], alice, [alice, david], charlie, bob, alice, [alice, charlie]] ;
false. */
trouver_min1([[D,_]|R], M) :- trouver_min2(R, D, M).

trouver_min2([], Min, Min).
trouver_min2([[D,_]|R], Mt, M) :- D < Mt, !, trouver_min2(R,D,M).
trouver_min2([_|R],Mt,M) :- trouver_min2(R,Mt,M).
   


meilleur_etats(Ec,Ef,Letats,Op,Es) :- findall([D,[Opt,Est]],
                            (operateur1(Ec,Opt,Est),
							not(member(Est,Letats)),
							not(interdit(Est)),
                            distance(Est,Ef,D)),L),
							trouver_min1(L,LM),
							member([LM,[Op,Es]],L).

rechercheT(Ef,Ef,_,[]):-!.
rechercheT(Ec,Ef,Letats,[Op|Lop]) :- meilleur_etats(Ec,Ef,Letats,Op,Es),
							write(Ec), write(' '),write(Op), write(' '),write(Es),nl,
							rechercheT(Es,Ef,[Es|Letats],Lop).

resoudreT(Sol) :- etatInitial1(Ei),etatFinal1(Ef),rechercheT(Ei,Ef,[Ei],Sol).