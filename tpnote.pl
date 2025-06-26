/*EX1:
supprime (N,X,L,R), N entier donne, X element donne, L liste donnee, 
N <= au nb d'occ de X dans L, R liste resultat*/
supprime(0,_,L,L) :- !.
supprime(N,X,[X|L],R) :- !, Nm1 is N - 1 ,supprime(Nm1,X,L,R).
supprime(N,X,[Y|L],[Y|R]) :- supprime(N,X,L,R).

/* EX2:
met_prof(A1,A2), A1 arbre donne, A2 arbre resulat*/
a1([6, [4, [1, [], []], [8, [], []]], [9, [], []]]).
met_prof(A1,A2) :- mp(A1,A2,0).

/* mp (A1,A2,N) A1 arbre donnee, A2 arbre resultat, N entier donnee */
mp([],[],_).
mp([_,G,D],[P,NG,ND],P) :- Pp1 is P + 1, mp(G,NG,Pp1), mp(D,ND,Pp1).

 /* ?- a1(A1), met_prof(A1,A2).
A1 = [6, [4, [1, [], []], [8, [], []]], [9, [], []]],
A2 = [0, [1, [2, [], []], [2, [], []]], [1, [], []]].  */

/*Ex3:  */
sport(sylvain,perrier,basket,lundi).
sport(claire,girard,escalade,mardi).
sport(olivier,testud,natation,mardi).
sport(julie,pirout,escalade,lundi).

creneaux(S,L) :- findall(J,sport(_,_,S,J),L).

jour(J,L) :- findall([P,N],sport(P,N,_,J),L).

etudiants(S,L) :- findall([P,N],sport(P,N,S,_),L).


sports([[sylvain,perrier,basket,lundi],[claire,girard,escalade,mardi],[olivier,testud,natation,mardi],[julie,pirout,escalade,lundi]]).

creneaux2(S,R) :- sports(Ls), findall(J,member([_,_,S,J],Ls),R).

jour2(J,R) :- sports(Ls), findall([P,N], member([P,N,_,J],Ls),R).

/*Ex 4 
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

carre([A,B,C,D,E,F,G,H,I,J,K,L]) :- permute([1,2,3,4,5,6,7,8,9,10,11,12],[A,B,C,D,E,F,G,H,I,J,K,L]),
                                    N is A + B + C + D,
                                    N =:= D + E + F + G,
                                    N =:= G + H + I + J,
                                    N =:= J + K + L + A.