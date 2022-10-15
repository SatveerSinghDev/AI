not(0,1).
not(1,0).

or(0,0,0).
or(0,1,1).
or(1,0,1).
or(1,1,1).

or(0,0,0,0).
or(0,0,1,1).
or(0,1,0,1).
or(0,1,1,1).
or(1,0,0,1).
or(1,0,1,1).
or(1,1,0,1).
or(1,1,1,1).

or(0,0,0,0,0).
or(0,0,0,1,1).
or(0,0,1,0,1).
or(0,0,1,1,1).
or(0,1,0,0,1).
or(0,1,0,1,1).
or(0,1,1,0,1).
or(0,1,1,1,1).
or(1,0,0,0,1).
or(1,0,0,1,1).
or(1,0,1,0,1).
or(1,0,1,1,1).
or(1,1,0,0,1).
or(1,1,0,1,1).
or(1,1,1,0,1).
or(1,1,1,1,1).


xor(0,0,0).
xor(0,1,1).
xor(1,0,1).
xor(1,1,0).


and(0,0,0).
and(0,1,0).
and(1,0,0).
and(1,1,1).

and(0,0,0,0).
and(0,0,1,0).
and(0,1,0,0).
and(0,1,1,0).
and(1,0,0,0).
and(1,0,1,0).
and(1,1,0,0).
and(1,1,1,1).

nand(A,B,O) :-     and(A,B,C), not(C,O).


nand(A,B,C,O) :-   and(A,B,C,D), not(D,O).

nor(A,B,O) :-     or(A,B,C) , not(C,O).

nor(A,B,C,O) :-   or(A,B,C,D), not(D,O).

ha(A,B,S,C) :-  xor(A,B,S) , and(A,B,C).     %% half adder

fa(A,B,CI,S,C) :-  xor(A,B,Z), xor(Z,CI,S),        %% full adder
                     and(A,B,D),
                     and(A,CI,E),
                     and(B,CI,F),
                     or(D,E,F,C).


hs(A,B,O,BO) :-  xor(A,B,O), not(A,D), and(D,B,BO).    %%half subtracter

fs(A,B,C,O,BO) :-  xor(A,B,D) , xor(C,D,O) ,  not(A,Z),   %% full subtracter
                    and(Z,B,X), and(Z,C,Y), and(B,C,W),
                    or(X,Y,W,BO).

dec(E,A1,A0,Y3,Y2,Y1,Y0) :- and(A1,A0,E,F) ,             %%2 to 4 decoder
                               F is Y3,
                             not(A1,P),
                             not(A0,Q),
                             and(A1,Q,E,G),
                             G is Y2,
                             and(P,A0,E,H),
                             H is Y1,
                             and(P,Q,E,I),
                             I is Y0.

dec3(A2,A1,A0 , Y7,Y6,Y5,Y4,Y3,Y2,Y1,Y0):- dec(A2,A0,A1,Y7,Y6,Y5,Y4), %%3 to 8 dec
                                          not(A2,E),
                                          dec(E,A1,A0, Y3,Y2,Y1,Y0).


enc4(Y3,Y2,Y1,Y0,A1,A0) :- or(Y3,Y2,A1), or(Y3,Y1,A0).
         %%4 to 2 encoder

enc8(Y7,Y6,Y5,Y4,Y3,Y2,Y1,Y0,A2,A1,A0) :-            %%8 to 3 encoder
                           or(Y7,Y6,Y5,Y4,A2),
                           or(Y7,Y6,Y3,Y2,A1),
                           or(Y7,Y5,Y3,Y1,A0).


prenc(Y3,Y2,Y1,Y0,A1,A0,V) :- or(Y3,Y2,A1),           %%priority encoder
                              not(Y2,E),
                              and(E,Y1,Z),
                              or(Y3,Y2,Z,A0),
                              or(Y3,Y2,Y1,Y0,V).

mux2(S,I1,I0,Y) :- and(I1,S,P),
                   not(S,Q),
                   and(I0,Q,R),
                   and(P,R,X),
                   not(X,Y).

mux4(S1,S0,I3,I2,I1,I0,Y) :- not(S1,A),
                             not(S0,B),
                             and(S1,S0,I3,P),
                             and(S1,B,I2,Q),
                             and(A,S0,I1,R),
                             and(A,B,I0,S),
                             or(P,Q,R,S,Y).

mux8(S2,S1,S0,I7,I6,I5,I4,I3,I2,I1,I0,Y) :-
                    %%8:1 multiplexer
                                              mux4(S1,S0,I7,I6,I5,I4,P),
                                              mux4(S1,S0,I3,I2,I1,I0,Q),
                                              mux2(S2,P,Q,Y).

mux16(S3,S2,S1,S0,I15,I14,I13,I12,I11,I10,I9,I8,I7,I6,I5,I4,I3,I2,I1,I0,Y):-
                    %%16:1 multiplexer
                                   mux8(S2,S1,S0,I15,I14,I13,I12,I11,I10,I9,I8,P),
                                   mux8(S2,S1,S0,I7,I6,I5,I4,I3,I2,I1,I0,Q),
                                   mux2(S3,P,Q,Y).

demux2(S,I0,Y1,Y0) :-
               %%1:2 demultiplexer
                        not(S,Q),
                        and(S,I0,Y1),
                        and(Q,I0,Y0).

demux4(S1,S0,I,Y3,Y2,Y1,Y0):-
                %%1:4 demultiplexer
                              not(S0,Q),
                              not(S1,P),
                              and(I,S1,S0,Y3),
                              and(I,S1,Q,Y2),
                              and(I,P,S0,Y1),
                              and(I,P,Q,Y0).

demux8(S2,S1,S0,I,Y7,Y6,Y5,Y4,Y3,Y2,Y1,Y0) :-
                  %%1:8 demultiplexer
                                              demux2(S2,I,P,Q),
                                              demux4(S1,S0,P,Y7,Y6,Y5,Y4),
                                              demux4(S1,S0,Q,Y3,Y2,Y1,Y0).

demux16(S3,S2,S1,S0,I,Y15,Y14,Y13,Y12,Y11,Y10,Y9,Y8,Y7,Y6,Y5,Y4,Y3,Y2,Y1,Y0) :-
                   %%1:16 demultiplexer
                               demux2(S3,I,P,Q),
                               demux8(S2,S1,S0,P,Y15,Y14,Y13,Y12,Y11,Y10,Y9,Y8),
                               demux8(S2,S1,S0,Q,Y7,Y6,Y5,Y4,Y3,Y2,Y1,Y0).

  %%using list to implement flip flop

srff(1,0,0,0,0).
srff(1,0,0,1,1).
srff(1,0,1,0,0).                     %%sr flip flop
srff(1,0,1,1,0).                     %% CL is clock ,S,R are inputs , Ps is present state, Ns is new state
srff(1,1,0,0,1).
srff(1,1,0,1,1).


sr(_,[],[],_,[]).
sr(CL,[S|Sr],[R|Rr],Ps,[Ns|Nr]):- srff(CL,S,R,Ps,Ns), sr(CL,Sr,Rr,Ns,Nr).

dff(0,_,0,0).
dff(0,_,1,1).
dff(1,0,0,0).                      %% d flip flop    D is input
dff(1,0,1,0).
dff(1,1,0,1).
dff(1,1,1,1).


d(_,[],_,[]).
d(C,[D|Dr],Ps,[Ns|Nr]):- dff(C,D,Ps,Ns), d(C,Dr,Ns,Nr).

jkff(0,_,_,0,0).
jkff(0,_,_,1,1).

jkff(1,0,0,0,0).
jkff(1,0,0,1,1).                  %% jk flip flop     J,K are inputs
jkff(1,0,1,0,0).
jkff(1,0,1,1,0).
jkff(1,1,0,0,1).
jkff(1,1,0,1,1).
jkff(1,1,1,0,1).
jkff(1,1,1,1,0).


jk(_,[],[],_,[]).
jk(C,[J|Jr],[K|Kr],Ps,[Ns|Nr]):- jkff(C,J,K,Ps,Ns), jk(C,Jr,Kr,Ns,Nr).



tff(0,_,0,0).
tff(0,_,1,1).
tff(1,0,0,0).                     %% t flip flop       T is input
tff(1,0,1,1).
tff(1,1,0,1).
tff(1,1,1,0).

t(_,[],_,[]).
t(C,[T|Tr],Ps,[Ns|Nr]):- tff(C,T,Ps,Ns), t(C,Tr,Ns,Nr).


















































