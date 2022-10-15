%% OR Gate
or(0,0,0).
or(0,1,1).
or(1,0,1).
or(1,1,1).


%% AND Gate
and(0,0,0).
and(0,1,0).
and(1,0,0).
and(1,1,1).


%% NOT Gate
not(1,0).
not(0,1).


%% 4-input OR Gate
or4(W,X,Y,Z,Out):- or(W,X,O1), or(Y,Z,O2), or(O1,O2,Out).

%% 3-input AND Gate 
and3(X,Y,Z,Out):- and(X,Y,O1), and(O1,Z,Out).

%% NOR Gate
nor(A,B,Out):- or(A,B,O1), not(O1,O2), Out is O2.

%% NAND Gate
nand(A,B,Out):-	and(A,B,O1), not(O1,O2), Out is O2.

%% XOR Gate
xor(A,B,Out):- not(A,A1), and(A1,B,O1), not(B,B1), and(A,B1,O2), or(O1,O2,O3), Out is O3.
