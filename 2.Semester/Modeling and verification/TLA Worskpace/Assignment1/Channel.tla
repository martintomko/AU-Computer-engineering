----------------------------- MODULE Channel -----------------------------

EXTENDS Naturals
CONSTANT Data
VARIABLES chan

TypeInvariantChannel == chan \in [val: Data, rdy: {0,1}, ack: {0,1}]

InitChannel == /\ TypeInvariantChannel
        /\ chan.ack = chan.rdy

Send(d) == /\ chan.rdy = chan.ack
           /\ chan' = [chan EXCEPT !.val = d, !.rdy = 1 - @]

Rcv == /\ chan.rdy # chan.ack
       /\ chan' = [chan EXCEPT !.ack = 1-@]

NextChannel == (\E d \in Data: Send(d)) \/ Rcv

Spec == InitChannel /\ [][NextChannel]_chan
=============================================================================
THEOREM Spec => []TypeInvariantChannel
=============================================================================