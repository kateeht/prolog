/* eliza */
eliza :- write('Bonjour, qu est ce qui vous amene ?'), nl,
        lire_pharse(Pharse),
        elisa(Pharse).

elisa([bye]) :- write("Au revoir").
elisa(ListeMots) :- pattern(Stimulus,Response),
                    sous_liste(Stimulus,ListeMots),
                    ecrire_pharse(Response), 
                    lire_pharse(Pharse),
                    elisa(Pharse).

sous_liste(L1,L2) :- append(L3,_,L2), append(_,L1,L3).

pattern([je,suis,X],[depuis,combien,de,temps,etes,vous,X,?]).
pattern([j,aime],[quelqu,un,d,autre,dans,votre,famille,aime,t,il,cela,?]).
pattern([je,me,sens,_],[ressentez,vous,souvent,cela,?]).
pattern([X],[pouvez,vous,me,parler,de,votre,X,?]) :- important(X).
pattern(_,[continuez]).

important(pere).
important(mere).
important(fils).
important(fille).
important(frere).
important(soeur).

lire_pharse(Liste) :- 
    read(Pharse),
    name(Pharse,LPharse),
    divise(LPharse,Liste),!.


/*trove espace */
divise(Chaine,[MotL|Liste]) :-
    append(Mot,[32|Reste],Chaine),
    name(MotL,Mot),
    divise(Reste,Liste).
/*cas d'arret  */
divise(DernierMot,[DernierMotL]) :-   
    name(DernierMotL,DernierMot).

ecrire_pharse([]) :- nl.
ecrire_pharse([X|L]) :- write(X), write(' '), ecrire_pharse(L).

/* tours de hanoi */
/* hanoi(Nbdisques,TigeDepart,TigeIntermediaire,Tigearivee) donne */
hanoi(1,D,_,A) :- !, write(D),write('->'),write(A),nl.
hanoi(N,D,I,A) :-
    Nm1 is N - 1,
    hanoi(Nm1,D,A,I),
    hanoi(1,D,I,A),
    hanoi(Nm1,I,D,A).

/* hanoi (4,a,b,c) */
/* recherche dans un graphe d'etat  */
/* recherche(EtatCourant,EtatFinal,ListeTaboue,ListeOp) tous donnes sauf ListeOp */
recherche(Ef,Ef,_,[]) :- !.
recherche(Ec,Ef,Ltaboue,[Op|Lop]) :- operateur(Ec,Op,Es),
                            not(member(Es,Ltaboue)),
                            not(interdit(Es)),
                            write(Ec),write(' '),write(Op), write(' '),write(Es),nl,
                            recherche(Es,Ef,[Es|Ltaboue],Lop).

resoudre(Solution) :- etatInitial(Ei), etatFinal(Ef), recherche(Ei,Ef,[Ei],Solution).

:- dynamic interdit/1. 
/* problem du labrynthe */

/*etatInitial(entree).
etatFinal(sortie).

interdit(minotaure).

operateur(E1,[E1,E2],E2) :- couloir(E1,E2).
operateur(E1,[E1,E2],E2) :- couloir(E2,E1). */

couloir(entree, thesee).
couloir(entree, ariane).
couloir(thesee, minotaure).
couloir(thesee,sombre).
couloir(claire, sombre).
couloir(claire, sortie).
couloir(minotaure, sortie).
couloir(ariane, claire).
couloir(sombre,sortie).

/* probleme des fleches */
etatInitial([b,h,h,b,b,h]).
etatFinal([b,b,b,h,h,h]).

operateur(E1,r1,E2) :- remplace([h,h],E1,[b,b],E2).
operateur(E1,r2,E2) :- remplace([h,b],E1,[b,h],E2).
operateur(E1,r3,E2) :- remplace([b,h],E1,[h,b],E2).
operateur(E1,r4,E2) :- remplace([b,b],E1,[h,h],E2).


/* remplace (SL1,L1,SL2,L2) tous donnes sauf L2 */
remplace(SL1,L1,SL2,L2) :- append(L5,L4,L1),
                            append(L3,SL1,L5),
                            append(L3,SL2,L6),
                            append(L6,L4,L2).
