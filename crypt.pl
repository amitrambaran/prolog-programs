#Decyphers a word puzzle by taking advantage of AI syntax

digit(0).
digit(1).
digit(2).
digit(3).
digit(4).
digit(5).
digit(6).
digit(7).
digit(8).
digit(9).
carry(0).
carry(1).



print_solution1 :- Start is cputime, solve1([S,T,R,A,W,O,C,H,I]), nl, write(' '), write(S), write(T), write(R), 
write(A), write(W), nl, write(*), write(' '), write(' '), write(' '), 
write(T), write(O), nl,  write('________'), nl, write('+'), write(W), write(A), write(R), write(T),
write(S), nl,  write(S), write(T), write(R), write(A), write(W), write('0'), nl, write('________'), 
nl, write(C), write(H), write(A), write(I), write(R), write(S), nl, End is cputime, Time is
End-Start, write('Elapsed time: '), write(Time).


print_solution2 :- Start is cputime, solve2([S,T,R,A,W,O,C,H,I]), nl, write(' '), write(S), write(T), write(R), 
write(A), write(W), nl, write(*), write(' '), write(' '), write(' '), 
write(T), write(O), nl,  write('________'), nl, write('+'), write(W), write(A), write(R), write(T),
write(S), nl,  write(S), write(T), write(R), write(A), write(W), write('0'), nl, write('________'), 
nl, write(C), write(H), write(A), write(I), write(R), write(S), nl, End is cputime, Time is 
End-Start, write('Elapsed time: '), write(Time).

solve1([S,T,R,A,W,O,C,H,I]) :- digit(S), digit(T), digit(R), digit(A), 
digit(W), digit(O), digit(C), digit(H), digit(I), C>0, S>0, T>0, W>0,


S is (W*O) mod 10, C1 is (W*O) // 10,
T is (A*O+C1) mod 10, C10 is (A*O+C1) // 10,
R is (R*O+C10) mod 10, C100 is (R*O+C10) // 10,
A is (T*O+C100) mod 10, C1000 is (T*O+C100) // 10,
W is (S*O+C1000) mod 10,

C2 is (T+W) // 10, I is (R+A+C2) mod 10,
C20 is (R+A+C2) // 10,
  
C200 is (A+R+C20) // 10, 
H is (W+T+C200) mod 10,
C2000 is (W+T+C200) // 10,
C is S + C2000,
all_diff([S,T,R,A,W,O,C,H,I]).



solve2([S,T,R,A,W,O,C,H,I]) :- 

digit(W), W>0, digit(O),
S is (W*O) mod 10, C1 is (W*O) // 10,
digit(A),
T is (A*O+C1) mod 10, C10 is (A*O+C1) // 10,
digit(R),
R is (R*O+C10) mod 10, C100 is (R*O+C10) // 10,
A is (T*O+C100) mod 10, C1000 is (T*O+C100) // 10,
W is (S*O+C1000) mod 10,

carry(C2),
I is (R+A+C2) mod 10,
carry(C20),
  
carry(C200),
H is (W+T+C200) mod 10,
carry(C2000),
C is S + C2000,
all_diff([S,T,R,A,W,O,C,H,I]).


all_diff([]).
all_diff([N|L]) :- not(member2(N,L)), all_diff(L).

member2(N,[N|L]).
member2(N,[M|L]) :- member2(N,L).

/*	 Solve2 is much more efficient as it generates variables as needed, and only if they are not
*	to be derived in some other part of the program. Many 'greater than 0' checks are also 
*	eliminated as it is implied that prologs arithmetic will take care of this. Solve2 has also 
*	been solved in the order that the complier would naturally go about solving any arithmetic
*	problem, which is from right to left, saving it the trouble of many backtracking instances
*	that may occur in solve1.
*	PROLOG WILL ONLY PROCESS SOLVE1 IF INVOKED, WHICH IS WHY IT WAS LEFT OUTSIDE COMMENTS
*	print_solution2 and solve2 are the ones that utilize smart interleaving.
*	carry values can be determined with prolog as they can only be 0 or 1.
*/ 