#Determines phone rates on respective days and times

call(1,saturday,2200,11). %surcharge%
call(2,tuesday,700,9).
call(3,wednesday,400,12). %surcharge%
call(4,sunday,1300,9).
call(5,friday,2300,6).
call(6,tuesday,2300,11). %surcharge%

day(T):- 500=<T, T=<2000.
night(T):-(not day(T)).
weekend(Day, Time):-Day=saturday; Day=sunday; Day=friday, Time>=2350, Time=<2400.
weekday(Day, Time) :- (not weekend(Day, Time)).
rate(Day,Time,Rate):-weekend(Day, Time), Rate is 5.
rate(Day,Time,Rate):-weekday(Day,Time), night(Time), Rate is 7.
rate(Day,Time,Rate):-weekday(Day,Time), day(Time), Rate is 9.

overtime(Duration):- Duration > 10.
surcharge(S):- S is 25. 

price(N,P):-call(N,Day,Time,Length), rate(Day,Time,Rate), Duration is Length,
overtime(Duration), surcharge(S), Overtime is 10,
P is Rate*Length + S*(Length-Overtime).

price(N,P):- call(N,Day,Time,Length), rate(Day,Time,Rate), Duration is Length,
not overtime(Duration), surcharge(S), 
P is Rate*Length.

