#Solves a family tree

person(amit).
person(kevin).
person(kishanth).
person(jay).
person(pabla).
person(amanda).
person(jessica).
person(sophie).
person(stefanie).
person(melanie).
person(joice).
person(amreet).
person(uzi).
person(tinashe).

sex(amit, male).
sex(kevin,male).
sex(kishanth, male).
sex(jay, male).
sex(pabla, male).
sex(amanda, female).
sex(jessica, female).
sex(sophie, female).
sex(stefanie, female).
sex(melanie, female).
sex(joice, female).
sex(amreet, female).
sex(uzi, male).
sex(tinashe, female).

city(toronto).
city(newyork).
city(shanghai).
city(delhi).
city(beijing).
city(karachi).
city(toyko).
city(moscow).
city(hongkong).
city(hanoi).

country(canada).
country(america).
country(china).
country(india).
country(pakistan).
country(japan).
country(russia).
country(vietnam).

home(amit, toronto).
home(kevin, newyork).
home(kishanth, delhi).
home(jay, beijing).
home(pabla, karachi).
home(amanda,tokyo).
home(sophie, shanghai).
home(stefanie, hanoi).
home(melanie, toronto).

location(toronto, canada).
location(newyork, america).
location(shanghai, china).
location(delhi, india).
location(beijing, china).
location(karachi, pakistan).
location(tokyo, japan).
location(moscow, russia).
location(hongkong, china).
location(hanoi, vietnam).

population(toronto, 60000).
population(newyork, 100000).
population(shanghai, 40000).
population(delhi, 20000).
population(beijing, 50000).
population(karachi, 300000).
population(tokyo, 70000).
population(moscow, 80000).
population(hongkong, 100000).
population(hanoi, 34000).

married(amit, amanda).
married(jay, joice).
married(kishanth, stefanie).

parent(amit, kishanth).
parent(amit, jay).
parent(amit, pabla). 
parent(amanda, jay).
parent(amanda, pabla).
parent(amanda, stefanie).
parent(sophie, melanie).
parent(melanie, amreet).
parent(jay, uzi). 
parent(pabla, tinashe).


friend(amanda, jessica).
friend(jay, melanie).
friend(pabla, sophie).
friend(amit, kevin).
friend(kevin, joice).

father(Dad, Child) :- parent(Dad, Child), sex(Dad, male).
mother(Mom, Child) :- parent(Mom, Child), sex(Mom, female).

brother(X, Y) :- sex(X, male), father(F, X), father(F, Y), mother(M, X), mother(M, Y), not X=Y.
sister(X, Y)  :- sex(X, female), father(F, X), father(F, Y), mother(M, X), mother(M, Y), not X=Y. 

ancestor(X, Y) :- parent(X, Y).
ancestor(X, Y) :- parent(X, Z), ancestor(Z, Y).

grandfather(G, C) :- father(G, X), father(X, C).
grandfather(G, C) :- father(G, X), mother(X, C). 

grandmother(G, C) :- mother(G, X), mother(X, C).
grandmother(G, C) :- mother(G, X), father(X, C). 

uncle(X, Y) :- brother(X, Z), parent(Z, Y). 
auntie(X, Y)  :- sister(X, Z), parent(Z, Y). 

relative(P1, P2) :- ancestor(X, P1), ancestor(X, P2). 

/******************* parser **********************/

who(Words, Ref) :- np(Words, Ref).
what(Words, Ref) :- np(Words, Ref).

/* Noun phrase can be a proper name or can start with an article */

np([Name],Name) :- proper_noun(Name).
np([Art|Rest], Who) :- article(Art), np2(Rest, Who).


/* If a noun phrase starts with an article, then it must be followed
   by another noun phrase that starts either with an adjective
   or with a common noun. */

np2([Adj|Rest],Who) :- adjective(Adj,Who), np2(Rest, Who).
np2([Noun|Rest], Who) :- common_noun(Noun, Who), mods(Rest,Who).


/* Modifier(s) provide an additional specific info about nouns.
   Modifier can be a prepositional phrase followed by none, one or more
   additional modifiers.  */

mods([], _).
mods(Words, Who) :-
	appendLists(Start, End, Words),
	prepPhrase(Start, Who),	mods(End, Who).

prepPhrase([Prep|Rest], Who) :-
	preposition(Prep, Who, Ref), np(Rest, Ref).

appendLists([], L, L).
appendLists([H|L1], L2, [H|L3]) :-  appendLists(L1, L2, L3).



