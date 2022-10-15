change(weapon,mobile).
change(weapons,mobiles).
change(bomb,ipad).
change(bombs,ipads).
change(professor, jackson).
change(rio, rose).
change(tokyo, blake).
change(mint, embassy).
change(find, check).
change(weaklinks, visa).
change(bullets, power_banks).
change(bullet,power_bank).
change(machinegun, iphonexmax).
change(machineguns,iphonexmax).
change(working, dreaming).
change(masterplan, trip).
change(robbery, game).
change(ak47, iphonexs).
change(car_bomb, macpro).
change(car_bombs, macpro).
change(time_bomb, ipadair).
change(handgrenade,ipod).
change(handgrenades,ipods).
change(kg,gb).
change(rdx,pendrive).
change(rob,attend).
change(royalmint,fifa).
change(knock_off,entertain).
change(cops,kids).
change(cop,kid).
change(loaded,spoiled).
change(load,spoil).
change(stuff,luxury).
change(bullets,power_banks).
change(daali, batteries).
change(S,S).
write_list([]).
write_list([H|T]):-
write(H),
write(' '),
write_list(T).
alter([],[]).
alter([H|T],[M|N]):-
change(H,M),
alter(T,N).
message():-
write('Send Message'),nl,
read(X),
atomic_list_concat(L,' ',X),
alter(L,V),nl,
write('--------------------------'),nl,
write('| Encrypted Message Sent |'),nl,
write('--------------------------'),nl,
write_list(V),
write('------------------------------------------------------------------------------------------------------------------'),nl.

