/*ex1: 
produitScalaire (L1,L2,N): L1,L2 listes donnees de meme longueur, N: nombre resultat  */
produitScalaire([],[],0).
produitScalaire([X|L1],[Y|L2],N) :- produitScalaire(L1,L2,R), N is X*Y + R. 

/* ?- produitScalaire([1,2,3],[4,5,6],N).
N = 32. */

/*ex2:  */
mystere(0,_,L,L) :- !.
mystere(N,X,[X|L],R):- !, Nm1 is N - 1, mystere(Nm1,X,L,R).
mystere(N,X,[Y|L],[Y|R]):- mystere(N,X,L,R). 

/* ?- mystere(3,a,[b,e,r,a,g,h,x,a,n,a,t,w],R).
R = [b, e, r, g, h, x, n, t, w]. */

/*ex4  dico bị sai*/
dico([c,h,a,t]).
dico([c,a,r,a,c,t,e,r,e]).
dico([t,r,u,c]).
dico([i,n,d,u]).
dico([n,e,u,c]).
dico([c,l]).
dico([h,a]).
dico([t,r]).
dico([d,u]).
/*choisirMot(M,N): N entier donne, M liste resultat */
choisirMot(M,N) :- dico(M), length(M,N).

/*?- choisirMot(M,4).
M = [c, h, a, t] ;
M = [t, r, u, c]. */

/* nieme(L,I,E): L liste donnee, I entier donne, 0<I<longueur(L), E element resultat  */
nieme([X|_],1,X):- !.
nieme([_|L],N,R) :- Nm1 is N - 1, nieme(L,Nm1,R).

/*
?- nieme([a,b,c,d,e],3,N).
N = c.*/

/*interCar(M1,N1,M2,N2) : M1,M2 listes donnees, N1,N2 entier donnees */

interCar(M1,N1,M2,N2) :- nieme(M1,N1,X), nieme(M2,N2,X).

/* ?- interCar([a,b,c,d],2,[q,w,c,b,r],4).
true. */

motsCroises(M1,M2,M3,M4,M5,M6,M7) :-
        choisirMot(M1,4),
        choisirMot(M5,4),
        interCar(M1,1,M5,1),
        choisirMot(M6,2),
        interCar(M1,2,M6,1),
        choisirMot(M7,4),
        interCar(M1,4,M7,1),
        choisirMot(M2,2),
        interCar(M2,1,M5,2),
        interCar(M2,2,M6,2),
        choisirMot(M3,2),
        interCar(M3,1,M5,4),
        choisirMot(M4,2),
        interCar(M4,2,M7,3).


/* ex3: 
etat = [N3,N3]: N3 nombre de l'eau dans cruche 3L
                N4 nombre de l'eau dans cruche 4L
*/
etatInitial([0,0]).
etatFinal([2,_]).
etatFinal([_,2]). 

operateur([_,N4],remplir3L,[3,N4]).
operateur([N3,_],remplir4L,[N3,4]).
operateur([_,N4],vider3L,[0,N4]).
operateur([N3,_],vider4L,[N3,0]).
operateur([N3,N4],trans3v4,[0,NN4]) :- N3 + N4 =< 4, NN4 is N3 + N4.
operateur([N3,N4],trans3v4,[NN3,4]) :- N3 + N4 > 4, Place is 4 - N4, NN3 is N3 - Place.
operateur([N3,N4],trans4v3,[NN3,0]) :- N3 + N4 =< 3, NN3 is N3 + N4.
operateur([N3,N4],trans4v3,[3,NN4]) :- N3 + N4 > 3, Place is 3 - N3, NN4 is N4 - Place.

recherche(Ef,_,[]) :- etatFinal(Ef).
recherche(Ec,Letats,[Op|Lop]) :- operateur(Ec,Op,Es),
							not(member(Es,Letats)),
							not(interdit(Es)),
							write(Ec), write(' '),write(Op), write(' '),write(Es),nl,
							recherche(Es,[Es|Letats],Lop).

resoudre(Sol) :- etatInitial(Ei),recherche(Ei,[Ei],Sol).

:- dynamic interdit/1.