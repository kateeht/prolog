

/**
Exercice 1
**/

supprime(0,_,R,R).
supprime(N,X,[X|L],R):-N >0,Nr is N-1,supprime(Nr,X,L,R).
supprime(N,X,[Y|L],[Y|R]):-N>0, X\==Y,supprime(N,X,L,R),!.
/**Test fait
supprime(3,a,[r,a,t,a,c,a,a,r],R).-> R = [r, t, c, a, r] ;


Exercice 2 Tout sans la nouvelle redéclaration de sport

sport(sylvain,perrier,basket,lundi).
sport(claire,girard,escalade,mardi).
sport(olivier,testud,natation,mardi).
sport(julie,pirout,escalade,lundi).

    crenaux(S,T):-findall(A,sport(_,_,S,A),T).
Test fait:
crenaux(escalade,M).-> M = [mardi, lundi].

    jour(J,L):-findall([P,N],sport(P,N,_,J),L).

Test fait:
    jour(mardi,L).->[[claire,girard],[olivier,testud]]

    etudiants(S,L):-findall([P,N],sport(P,N,S,_),L).
Test fait etudiants:-
etudiants (escalade,L)->[[claire,girard],[julie,pirout]]

**/

/**
Avec la redéclaration de sport
**/
sport([[sylvain,perrier,basket,lundi],[claire,girard,escalade,mardi],[olivier,testud,natation,mardi],[julie,pirout,escalade,lundi]]).
crenaux(S,L):-findall(T,(sport(L),member([_,_,S,T],L)),L).
jour(J,L):-findall([P,N],(sport(L),member([P,N,_,J],L)),L).
/** J'arrive a trouver les memes résultats c'est à dire: 
    -Pour creneaux: creneaux(escalade,L).->[mardi,lundi]
    -pour jour: jour(mardi,L).->[[claire,girard],[olivier,testud]] **/

/**
Exercice 3
**/
met_prof([],[]).
met_prof([_,[],[]],[0,[],[]]).
met_prof([_,G,D],[Nr,G2,D2]):- Nr is 0+1,met_prof(G,G2),met_prof(D,D2).
/** J'ai essayé tant bien que mal a coder ce prédicat mais les arbres sont mon pieds d'achile en prolog**/
/**Exercice 4**/
permute([],[]).
permute(L,[X|Lr]):-
    member(X,L),
    supprime(1,X,L,Lt),
    permute(Lt,Lr).
/**J'ai fais permute fais dans les tps précédents afin de me faciliter la fonction carre_magique**/ 
    
carre_magique(A,B,C,D,E,F,G,H,I,J,K,L):-
    permute([1,2,3,4,5,6,7,8,9,10,11,12],[A,B,C,D,E,F,G,H,I,J,K,L]),
    (A+B+C+D)=:=(A+L+K+J),
    (A+L+K+J)=:=(J+I+H+G),
    (J+I+H+G)=:=(D+E+F+G).
/**
Requete:carre_magique(A,B,C,D,E,F,G,H,I,J,K,L).->
A = 1,
B = 2,
C = 10,
D = 12,
E = 3,
F = 6,
G = 4,
H = 7,
I = 9,
J = 5,
K = 8,
L = 11 .
1)Voici la requête exécuté avec un exemple de résultat.
carre_magique(1,B,C,2,E,F,3,H,I,4,K,L),L)->carre_magique(1,B,C,2,E,F,3,H,I,4,K,L).->
B = 7,
C = 12,
E = 6,
F = 11,
H = 5,
I = 10,
K = 8,
L = 9 
2)findall([1,B,C,2,E,F,3,H,I,4,K,L],carre_magique(1,B,C,2,E,F,3,H,I,4,K,L),L),length(L,X).
L = [[1, 7, 12, 2, 6, 11, 3, 5|...], [1, 7, 12, 2, 6, 11, 3|...], [1, 7, 12, 2, 6, 11|...], [1, 7, 12, 2, 6|...], [1, 7, 12, 2|...], [1, 7, 12|...], [1, 7|...], [1|...], [...|...]|...],
X = 96.
On trouve 96 solutions possible
**/


permute([],[]).
permute(L,[X|Lp] ) :- 
        member(X,L),
        enleve(X,L,L1),
        permute(L1,Lp).

/* enlever un element d'une liste,
enleve (X,L1,L2) ,X nb donne, L1 liste donne, L2 resultat */
enleve(X,[X|L],L).
enleve(X,[Y|L1],[Y|L]) :- X\==Y, enleve(X,L1,L).
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
