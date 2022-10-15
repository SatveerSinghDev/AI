:-include(gates).

%% HALF ADDER									X,Y are inputs, S,C are outputs
half_adder(X,Y,S,C):- xor(X,Y,S), and(X,Y,C).


%% FULL ADDER									X,Y,Z are inputs, S,C are outputs
full_adder(X,Y,Z,S,C):-
	xor(X,Y,T1),	%% x^y
	xor(Z,T1,S),	%% S = z^(x^y)
	
	and(T1,Z,T2),	%% z&(x^y)
	and(X,Y,T3),	%% x&y
	or(T3,T2,C).	%% C = ((x&y) | z & (x^y))


%% DECODER 2x4									A,B are inputs, D0,D1,D2,D3 are 4 outputs
decoder_2x4(A,B,D0,D1,D2,D3):-
	not(A,A_0), not(B,B_0), 
	and(A_0,B_0,D0),
	and(A_0,B,D1),
	and(A,B_0,D2),
	and(A,B,D3).


%% DECODER 3x8									A,B,C are inputs, D0-D7 are 8 outputs
decoder_3x8(A,B,C,D0,D1,D2,D3,D4,D5,D6,D7):-
	not(A,A_0), not(B,B_0), not(C,C_0),
	and3(A_0,B_0,C_0,D0),
	and3(A_0,B_0,C,D1),
	and3(A_0,B,C_0,D2),
	and3(A_0,B,C,D3),
	and3(A,B_0,C_0,D4),
	and3(A,B_0,C,D5),
	and3(A,B,C_0,D6),
	and3(A,B,C,D7).
	
	
%% ENCODER 8x3									D0-D7 are 8 inputs, A,B,C are outputs 
encoder_8x3(_,D1,D2,D3,D4,D5,D6,D7,A,B,C):-
	or4(D1,D3,D5,D7,A),				
	or4(D2,D3,D6,D7,B), 
	or4(D4,D5,D6,D7,C).
	
	
%% MULTIPLEXER 2x1								A,B are inputs, S is selector (also input), Z is output
mux_2x1(A,B,S,Z):-
	not(S,S1),
	and(A,S1,I0),
	and(B,S,I1),
	or(I0,I1,Z).


%% MULTIPLEXER 4x1								A,B,C,D are inputs, S0,S1 are selectors (also inputs), Z is output
mux_4x1(A,B,C,D,S0,S1,Z):-
	not(S0,S_0),not(S1,S_1),
	and3(A,S_0,S_1,I0),
	and3(B,S0,S_1,I1),
	and3(C,S_0,S1,I2),
	and3(D,S0,S1,I3),
	or(I0,I1,I_01), or(I2,I3,I_23),
	or(I_01,I_23,Z).


%% MULTIPLEXER 8x1								A-H are inputs, S0,S1,S2 are selectors (also inputs), Z is output
mux_8x1(A,B,C,D,E,F,G,H,S0,S1,S2,Z):-
	mux_4x1(A,B,C,D,S0,S1,Z1),
	mux_4x1(E,F,G,H,S0,S1,Z2),
	mux_2x1(Z1,Z2,S2,Z).


%% DE-MULTIPLEXER 1x2							I is input, S is selector (also input), A,B are output
demux_1x2(I,S,A,B):-
	not(S,S_0),
	and(I,S_0,A),
	and(I,S,B).


%% DE-MULTIPLEXER 1x4							I is input, S0,S1 are selectors (also inputs), A,B,C,D are output
demux_1x4(I,S0,S1,A,B,C,D):-
	decoder_2x4(S0,S1,T0,T1,T2,T3),
	and(I,T0,A),
	and(I,T1,B),
	and(I,T2,C),
	and(I,T3,D).
	
	
%% DE-MULTIPLEXER 1x8							I is input, S0,S1,S2 are selectors (also inputs), O0-O7 are output
demux_1x8(I,S0,S1,S2,O0,O1,O2,O3,O4,O5,O6,O7):-
	decoder_3x8(S0,S1,S2,T0,T1,T2,T3,T4,T5,T6,T7),
	and(I,T0,O0),
	and(I,T1,O1),
	and(I,T2,O2),
	and(I,T3,O3),
	and(I,T4,O4),
	and(I,T5,O5),
	and(I,T6,O6),
	and(I,T7,O7).
