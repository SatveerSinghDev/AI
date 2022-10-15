/*
This program converts the tenses according to the sentence.
To check if a sentence is grammatically correct:
s([your,sentence..],[]).

To change tense:
changeto_present|past|future([your,sentence..],[]).

To check tense:(This is the extension feature of the program.)
check_tense([your,sentnece..],[]).

Limitations:
This program will work only on indefinite(simple) tenses.
This program will not work for general and complex sentences.
This program will work on sentences like these:
1. ram eats an apple | ram ate an apple | ram will eat an apple.
2. she plays basketball | she played basketball | she will play basketball.

*/

s --> pn,n,v,n.
s --> pn,v,n.
s --> pn,h,v,n.
s --> n,v,n.
s --> n,v,art,n.
s --> n,h,v,art,n.
s --> art,n,h,v,art,n.
art -->[an]|[a]|[the].
n --> [ram]|[apple]|[banana]|[basketball]|[children].
pn -->[he]|[she]|[it].
v --> [eats]|[eat]|[ate].
v --> [plays]|[played]|[play].
v --> [peels].
h --> [will]|[shall].

%simple prensent.
changepresent(ate,eats).
changepresent(eat,eats).
changepresent(played,plays).
changepresent(play,plays).

changeto_present([],[]).
changeto_present([H|T],[]):- phrase(h,[H]), changeto_present(T,[]). %phrase() is an inbuilt function it checks the verb in grammar.
changeto_present([H|T],[]):- phrase(v,[H]), changepresent(H,X), write(" "), write(X), changeto_present(T,[]).
changeto_present([H|T],[]):- write(" "), write(H), changeto_present(T,[]).

%simple past.
changepast(eats,ate).
changepast(eat,ate).
changepast(plays,played).
changepast(play,played).

changeto_past([],[]).
changeto_past([H|T],[]):- phrase(h,[H]), changeto_past(T,[]).
changeto_past([H|T],[]):- phrase(v,[H]), changepast(H,X), write(" "), write(X), changeto_past(T,[]).
changeto_past([H|T],[]):- write(" "), write(H), changeto_past(T,[]).

%simple future.
changefuture(eats,"will eat").
changefuture(ate,"will eat").
changefuture(plays,"will play").
changefuture(play,"will play").
changefuture(played,"will play").

changeto_future([],[]).
changeto_future([H|T],[]):- phrase(v,[H]), changefuture(H,X), write(" "), write(X), changeto_future(T,[]).
changeto_future([H|T],[]):- write(" "), write(H), changeto_future(T,[]).

%check tenses.
checking(eats,present).
checking(eat,present).
checking(play,present).
checking(plays,present).
checking(ate,past).
checking(played,past).
checking(will,future).
checking(shall,future).

check_tense([],[]).
check_tense([H|T],[]):- phrase(v,[H]), checking(H,X), X=='present', write("It is in present tense"), check_tense(T,[]).
check_tense([H|T],[]):- phrase(v,[H]), checking(H,X), X=='past', write("It is in past tense"), check_tense(T,[]).
check_tense([H|T],[]):- phrase(h,[H]), checking(H,X), X=='future', write("It is in future tense"), check_tense(T,[]).
check_tense([H|T],[]):- check_tense(T,[]).
