%% C=Clock, Ps=Present State, Ns=New State
%% Cases could have been combined with other cases by using _ in place of Ps, but to enable playing with the program, the two cases have been defined separately
%% Flip-flops are assumed to be positive edge triggered flip-flops, i.e., they will work only when a positive transition in clock pulse occurs 
%% C=0 indicates that flip-flops state won't change irrespective of the value of the inputs, when C=1 flip-flop will work.


%% SR Flip Flop				sr(Clock, [list of values of S], [list of values of R], Present State, [list of values of Next State])
sr(_,[],[],_,[]).				
sr(C,[S|Sr],[R|Rr],Ps,[Ns|Nr]):- sr_ff(C,S,R,Ps,Ns), sr(C,Sr,Rr,Ns,Nr).

sr_ff(0,_,_,0,0).				%% indicating when C=0, no change in state
sr_ff(0,_,_,1,1).				%% indicating when C=0, no change in state

sr_ff(1,0,0,0,0).				%% indicating when S=0, R=0, Ns=Ps
sr_ff(1,0,0,1,1).				%% indicating when S=0, R=0, Ns=Ps
sr_ff(1,0,1,0,0).				%% indicating when S=0, R=1, Ns=0
sr_ff(1,0,1,1,0).				%% indicating when S=0, R=1, Ns=0
sr_ff(1,1,0,0,1).				%% indicating when S=1, R=0, Ns=1
sr_ff(1,1,0,1,1).				%% indicating when S=1, R=0, Ns=1


%% D Flip Flop				d(Clock, [list of values of D], Present State, [list of values of Next State])
d(_,[],_,[]).
d(C,[D|Dr],Ps,[Ns|Nr]):- d_ff(C,D,Ps,Ns), d(C,Dr,Ns,Nr).

d_ff(0,_,0,0).					%% indicating when C=0, no change in state
d_ff(0,_,1,1).					%% indicating when C=0, no change in state

d_ff(1,0,0,0).					%% indicating when D=0, Ns=0
d_ff(1,0,1,0).					%% indicating when D=0, Ns=0
d_ff(1,1,0,1).					%% indicating when D=1, Ns=1
d_ff(1,1,1,1).					%% indicating when D=1, Ns=1


%% JK Flip Flop				jk(Clock, [list of values of J], [list of values of K], Present State, [list of values of Next State])
jk(_,[],[],_,[]).
jk(C,[J|Jr],[K|Kr],Ps,[Ns|Nr]):- jk_ff(C,J,K,Ps,Ns), jk(C,Jr,Kr,Ns,Nr).

jk_ff(0,_,_,0,0).				%% indicating when C=0, no change in state
jk_ff(0,_,_,1,1).				%% indicating when C=0, no change in state

jk_ff(1,0,0,0,0).				%% indicating when J=0, K=0, Ns=Ps
jk_ff(1,0,0,1,1).				%% indicating when J=0, K=0, Ns=Ps
jk_ff(1,0,1,0,0).				%% indicating when J=0, K=1, Ns=0
jk_ff(1,0,1,1,0).				%% indicating when J=0, K=1, Ns=0
jk_ff(1,1,0,0,1).				%% indicating when J=1, K=0, Ns=1
jk_ff(1,1,0,1,1).				%% indicating when J=1, K=0, Ns=1
jk_ff(1,1,1,0,1).				%% indicating when J=1, K=1, Ns=complement of Ps
jk_ff(1,1,1,1,0).				%% indicating when J=1, K=1, Ns=complement of Ps


%% T Flip Flop				t(Clock, [list of values of T], Present State, [list of values of Next State])
t(_,[],_,[]).
t(C,[T|Tr],Ps,[Ns|Nr]):- t_ff(C,T,Ps,Ns), t(C,Tr,Ns,Nr).

t_ff(0,_,0,0).					%% indicating when C=0, no change in state
t_ff(0,_,1,1).					%% indicating when C=0, no change in state

t_ff(1,0,0,0).					%% indicating when T=0, Ns=Ps
t_ff(1,0,1,1).					%% indicating when T=0, Ns=Ps
t_ff(1,1,0,1).					%% indicating when T=1, Ns=complement of Ps
t_ff(1,1,1,0).					%% indicating when T=1, Ns=complement of Ps
