/*insertion(X,L1,L2) X nb donnee, L1 liste de nb triee donnee, L2 Liste de nb triee resultat */
insertion(X,[],[X]).
insertion(X,[Y|L1],[X,Y|L1]) :- X =<Y.
insertion(X,[Y|L1],[Y|L2]) :- X>Y, insertion(X,L1,L2).

/* Tri_ins(L1,L2) L1 liste de nb donnee, L2 liste de nb triee resultat*/
tri_ins([],[]).
tri_ins([X|L],L2) :- tri_ins(L,Lt), insertion(X,Lt,L2).

/* divise(L,L1,L2) L liste donnee, L1 et L2 liste résultat */
divise([X,Y|L],[X|L1],[Y|L2]) :- divise(L,L1,L2).
divise([X],[X],[]).
divise([],[],[]).

/* fusion(L1,L2,L) L1 et L2 listes de nb triées données, L liste de nb triee résultat */
fusion([],L,L).
fusion(L,[],L).
fusion([X|L1],[Y|L2],[X|L3]) :- X<Y, fusion(L1,[Y|L2],L3).
fusion([X|L1],[Y|L2],[Y|L3]) :- X>Y, fusion([X|L1],L2,L3).

/* tri_fusion(L,Lt) L liste de nb donnee, Lt liste de nb trier resultat */
tri_fusion([],[]).
tri_fusion([X],[X]).
tri_fusion([X,Y|L],Lt) :- divise([X,Y|L],L1,L2),
			tri_fusion(L1,L1t),
			tri_fusion(L2,L2t),
			fusion(L1t,L2t,Lt).


arbre1([6, [4, [1, [], []], [8, [], []]], [9, [], []]]).
arbre2([6, [4, [1, [], []], []], [9, [], []]]).

/* somme(A1,A2) A1 arbre de nb donnee, A2 arbre de nb res */
sommef([],[]).
sommef([N,[],[]],[N,[],[]]).
sommef([N,G,D],[V,[N1,G1,D1],[N2,G2,D2]]) :- 
		sommef(G,[N1,G1,D1]),
		sommef(D,[N2,G2,D2]),
		V is N+N1+N2.
		

