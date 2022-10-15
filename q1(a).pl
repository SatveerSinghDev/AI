ntrans(1,Y,Y).
ntrans(G,X,Y).
ptrans(0,Y,Y).
ptrans(G,X,Y).
invert(In,Out):- ntrans(In,Out,0),ptrans(In,Out,1).
nand(I1,I2,Out) :- ptrans(I1,Out,l), ptrans(I2,Out,l),
ntrans(I1,Out,W), ntrans(I2,W,0).

