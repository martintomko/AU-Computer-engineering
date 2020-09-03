----------------------------- MODULE Assignment1 -----------------------------

EXTENDS Naturals, Sequences
CONSTANT Message, N
VARIABLES in, out, q
ASSUME (N \in Nat) /\ (N>0) 

InChan == INSTANCE Channel WITH Data <- Message, chan <- in
OutChan == INSTANCE Channel WITH Data <- Message, chan <- out
 
 
Init == /\ InChan!InitChannel
        /\ OutChan!InitChannel
        /\ q = <<>>
       
TypeInvariant == /\ InChan!TypeInvariantChannel
                 /\ OutChan!TypeInvariantChannel
                 /\ q \in Seq(Message)
 
SSend(msg) == /\ InChan!Send(msg)
              /\ UNCHANGED <<out, q>>
 
BufRcv == /\ Len(q) < N
          /\ InChan!Rcv
          /\ q' = <<in.val>> \o q
          /\ UNCHANGED out
 
BufSend == /\ q # <<>>
           /\ OutChan!Send(Head(q))
           /\ q' = Tail(q)
           /\ UNCHANGED in
 
RRcv == /\ OutChan!Rcv
        /\ UNCHANGED <<in, q>>
 
Next == \/ \E msg \in Message : SSend(msg)
        \/ BufRcv
        \/ BufSend
        \/ RRcv
 
Spec == Init /\ [][Next]_<<in, out, q>>
 
THEOREM Spec => []TypeInvariant


=============================================================================