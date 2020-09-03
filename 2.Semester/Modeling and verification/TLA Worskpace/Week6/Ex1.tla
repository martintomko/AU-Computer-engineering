----------------------------- MODULE Ex1 -----------------------------

EXTENDS Naturals,Integers, TLC
VARIABLES proc,adr,val,op,reply

\*op= 1 - send, 0 - read

Init == /\ adr = 0
        /\ op = 0
        /\ val \in {-500,500}




=============================================================================