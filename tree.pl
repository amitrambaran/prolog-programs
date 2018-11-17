#Constructs a binary tree

treePosNeg(void, [],[],[]).	

treePosNeg(tree(Left, Root, Right), [Root|Pos], Neg, Other):- posHelper(Root),
subHelper(Left, Right, Pos, Neg, Other).

treePosNeg(tree(Left, Root, Right), Pos, [Root|Neg], Other) :- negHelper(Root), 
subHelper(Left, Right, Pos, Neg, Other).

treePosNeg(tree(Left, Root, Right), Pos, Neg, [Root|Other]) :- otherHelper(Root), 
subHelper(Left, Right, Pos, Neg, Other).


posHelper(Root) :- number(Root), Root>0.
negHelper(Root) :- number(Root), Root<0.
otherHelper(Root) :- not number(Root).

subHelper(Left, Right, Pos, Neg, Other) :- treePosNeg(Left, LeftPos, LeftNeg, LeftOther),
treePosNeg(Right, RightPos, RightNeg, RightOther), append(LeftPos, RightPos, Pos), write(Pos),
append(LeftNeg, RightNeg, Neg), write(Neg), append(LeftOther, RightOther, Other), write(Other).



