/* 1. Cryptarithmétique */

/*  Définir le prédicat hors_de(X,L) qui est satisfait si X n’est pas élément de la liste L. 
X element donne, L donne*/
hors_de(X, L) :- not(member(X, L)).

hors_de1(_,[]).
hors_de1(X,[Y|L]) :- X =\= Y, hors_de(X,L).

/* Définir le prédicat valeur(X,Xmin,Xmax,L) qui donne une valeur entière X comprise entre Xmin
et Xmax qui n’est pas dans la liste L. C’est-à-dire qu’en demandant toutes les solutions au prédicat quand X est inconnu, toutes les valeurs sont énumérées. (liệt kê)
X resultat, X entre[Xmin,Xmax], L donne */
valeur(X,Y,Z,L) :- between(Y,Z,X), hors_de(X,L).

/* between(Xmin, Xmax, X) */ 

valeur1(X,X,_,L) :- hors_de(X,L).
valeur1(X,Xmin,Xmax,L) :- Xmin < Xmax, Xminbis is Xmin + 1, valeur1(X,Xminbis,Xmax,L).  
/*
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


trente2(V,I,N,G,T,C,Q,R,E) :- 
    permute([0,1,2,3,4,5,6,7,8,9],[V,I,N,G,T,C,Q,R,E]),
    V \== 0, C \== 0, T \== 0,
    VINGT is 10000*V + 1000*I + 100*N + 10*G + T,
    CINQ  is 1000*C + 100*I + 10*N + Q,
    TRENTE is 100000*T + 10000*R + 1000*E + 100*N + 10*T + E,
    VINGT + VINGT + CINQ =:= TRENTE,
    write('VINGT: '), write(VINGT), nl,
    write('CINQ: '), write(CINQ), nl,
    write('TRENTE: '), write(TRENTE), nl,
    write([V,I,N,G,T,C,Q,R,E]), nl.



trente([V,I,N,G,T,C,Q,R,E]) :- 
	valeur(V,1,9,[]), 
	valeur(I,0,9,[V]), 
	valeur(N,0,9,[V,I]), 
	valeur(G,0,9,[V,I,N]), 
	valeur(T,1,9,[V,I,N,G]), 
	valeur(C,1,9,[V,I,N,G,T]), 
	valeur(Q,0,9,[V,I,N,G,T,C]),
	valeur(R,0,9,[V,I,N,G,T,C,Q]), 
	valeur(E,0,9,[V,I,N,G,T,C,Q,R]),
	(V*10000 + I*1000 + N*100 + G*10 + T) + 2*(C*1000 + I*100 + N*10 + Q)
	=:=(T*100000 + R*10000 + E*1000 + N*100 + T*10 + E).

/* trente_ligne([V,I,N,G,T,C,Q,R,E]) tous les parametres sont des  resultats entiers */
/* version dans laquelle le test est effecute en ligne, donc apres que toutes les lettres
soient affectees, la combinatoire est bien plus grande */
trente_ligne([V,I,N,G,T,C,Q,R,E]) :-
	valeur(T,1,9,[]),
	valeur(Q,0,9,[T]),
	valeur(E,0,9,[T,Q]),
	valeur(G,0,9,[T,Q,E]),
	valeur(N,0,9,[T,Q,E,G]),
	valeur(I,0,9,[T,Q,E,G,N]),
	valeur(C,1,9,[T,Q,E,G,N,I]),
	valeur(V,1,9,[T,Q,E,G,N,I,C]),
	valeur(R,0,9,[T,Q,E,G,N,I,C,V]),
	T+10*G+100*N+I*1000+V*10000 + 2*(Q+10*N+I*100+C*1000) 
	=:= E+10*T+N*100+E*1000+R*10000+T*100000,
	ecrit([V,I,N,G,T,C,Q,R,E]).	




/* trente1([V,I,N,G,T,C,Q,R,E]) tous les parametres sont des  resultats entiers */
/* version dans laquelle les variables sont affectees en colonne, avec les tests des que possible */
trente1([V,I,N,G,T,C,Q,R,E]) :-
	valeur(T,1,9,[]),
	valeur(Q,0,9,[T]),
	E is (T+Q+Q) mod 10,
	hors_de(E,[T,Q]),
	R1 is (T+Q+Q) // 10,
	valeur(G,0,9,[T,Q,E]),
	valeur(N,0,9,[T,Q,E,G]),
	T =:= (G+N+N+R1) mod 10,
	R2 is (G+N+N+R1) // 10,
	valeur(I,0,9,[T,Q,E,G,N]),
	N =:= (N+I+I+R2) mod 10,
	R3 is (N+I+I+R2) // 10,
	valeur(C,1,9,[T,Q,E,G,N,I]),
	E =:= (I+C+C+R3) mod 10,
	R4 is (I+C+C+R3) // 10,
	valeur(V,1,9,[T,Q,E,G,N,I,C]),
	valeur(R,0,9,[T,Q,E,G,N,I,C,V]),
	V+R4 =:= R + 10*T,
	ecrit([V,I,N,G,T,C,Q,R,E]).

/*  comparaison du temps d'execution des 2 versions :
?- time(trente_ligne([V,I,N,G,T,C,Q,R,E])).
% 8,320,578 inferences, 0.544 CPU in 0.545 seconds (100% CPU, 15294758 Lips)
?- time(trente([V,I,N,G,T,C,Q,R,E])).      
% 2,210 inferences, 0.001 CPU in 0.001 seconds (93% CPU, 2466518 Lips) */

ecrit([V,I,N,G,T,C,Q,R,E]) :- tab(5),
    write(V),write(' '),write(I),write(' '),write(N),write(' '),
    write(G),write(' '),write(T),nl,tab(3),write('+'),tab(3),
    write(C),write(' '),write(I),tab(1),write(N),tab(1),write(Q),nl,
    tab(3),write('+'),tab(3),
    write(C),write(' '),write(I),tab(1),write(N),tab(1),write(Q),nl,
    tab(3),write('_____________'),nl,tab(1),write('='),tab(1),
    write(T),tab(1),write(R),write(' '),
    write(E),tab(1),write(N),tab(1),write(T),tab(1),write(E),nl.		


/* 2. Le zebre */
/* Définir le prédicat meme_maison(X,L1,Y,L2) vrai si X et Y sont dans la même position dans les
listes L1 et L2. Par exemple pour le fait 1, on pourra dire que ‘anglais’ est à la même place dans la liste N (liste des nationalités) que ‘rouge’ dans la liste C (liste des couleurs).
*/
meme_maison(X,[X|_],Y,[Y|_]).
meme_maison(X,[_|L1],Y,[_|L2]) :- meme_maison(X,L1,Y,L2).

/* Définir le prédicat maison_a_cote(X,L1,Y,L2) vrai si X et Y sont dans des positions voisines dans les listes L1 et L2. */
maison_a_cote(X,[X|_],Y,[_,Y|_]).
maison_a_cote(X,[_,X|_],Y,[Y|_]).
maison_a_cote(X,[_|L1],Y,[_|L2]) :- maison_a_cote(X,L1,Y,L2).

/* Définir le prédicat maison_a_droite(X,Y,L) vrai si Y est juste à droite de X dans la liste L.*/
maison_a_droite(X,Y,[X,Y|_]).
maison_a_droite(X,Y,[_|L]) :- maison_a_droite(X,Y,L).

/* Définir le prédicat zebre(C,N,B,A,P,PossZebre,BoitVin) qui calcule les listes et qui trouve dans PossZebre et BoitVin, les nationalités du propriétaire du zèbre et du buveur de vin. 
Couleur = [rouge, bleu, jaune, blanc, vert].
Profes = [peintre, sculpteur, diplomate, docteur et violoniste].
Nationalite = [anglaise, espagnole, japonaise, norvégienne et italienne].
Boisson = [the, jus de fruits, cafe, lait, vin]. 
*/

zebre(C,N,B,A,P,PossZebre,BoitVin) :-
	C = [_,_,_,_,_], 		/*couleur */
	N = [norvegien,_,_,_,_], 	/*nationalite*/
	B = [_,_,lait,_,_], 		/*Boisson*/
	A = [_,_,_,_,_], 		/*animal*/
	P = [_,_,_,_,_], 		/*professionel*/

	meme_maison(anglais,N,rouge,C),

	meme_maison(espagnol,N,chien,A),

	meme_maison(japonais,N,peintre,P),

	meme_maison(italien,N,the,B),

	meme_maison(verte,C,cafe,B),

	maison_a_droite(blanche, verte,C),

	meme_maison(sculpteur,P,escargot,A),

	meme_maison(diplomate,P,jaune,C),

	maison_a_cote(norvegien,N,bleue,C),

	meme_maison(violoniste,P,jus_de_fruit,B),

	maison_a_cote(renard,A,medecin,P),

	maison_a_cote(cheval,A,diplomate,P),
	
	meme_maison(PossZebre,N,zebre,A),

	meme_maison(BoitVin,N,vin,B).

/*?- zebre(C,N,B,A,P,PossZebre,BoitVin).

C = [jaune, bleu, rouge, blanche, verte]
N = [norvegien, italien, anglais, espagnol, japonais]
B = [vin, the, lait, jus_de_fruit, cafe]
A = [renard, cheval, escargots, chien, zebre]
P = [diplomate, medecin, sculpteur, violoniste, peintre]
PossZebre = japonais
BoitVin = norvegien ;

No*/	
	

























				