pere(charlie,david). 
pere(henri,charlie).
papy(X,Y) :- pere(X,Z), pere(Z,Y).

/* findall(variable,but,liste) 
findall(X,member(X,[a,b,c]),R)
R = [a,b,c]

findall(X,solution(X),L), length(L,N) */
