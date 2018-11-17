#Solves missing character with given constraints

digit(1).
digit(2).
digit(3).
digit(4).
digit(5).
digit(6).
digit(7).
digit(8).
digit(9).
carry(1).
carry(2).


solve([O,N,E,T,W]) :- digit(E),

digit(O), O>0, O is (E+E) mod 10, carry(C1),
digit(W), digit(N), W is (N+N+C1) mod 10, carry(C10),
digit(T), T is (O+O+C10) mod 10, 

all_diff([O,N,E,T,W]).

all_diff([]).
all_diff([H|T]) :- not member(H, T), all_diff(T).

