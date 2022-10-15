s --> n, v, n.
n --> [ram].
n --> [apple].
n --> [banana].
v --> [eats].
v --> [will].
v --> [peels].
% To check a sentence is grammatically correct:
%?- s([your,sentence..],[]).


% To change tense:
%?- ct([your,sentence..],[]).

ct([],[]).
ct([H|T],[]):- phrase(v,[H]), write("will"), ct(T,[]).
ct([H|T],[]):- write(H), ct(T,[]). 
