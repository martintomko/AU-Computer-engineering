----------------------------- MODULE Exercise1 -----------------------------
EXTENDS Naturals
CONSTANT Data
VARIABLES val,rdy,ack


TypeInvariant ==    /\ val \in Data
                    /\ rdy \in {0,1}
                    /\ ack \in {0,1}
                    
Init == /\ val \in Data
        /\ rdy \in {0,1}
        /\ ack \in {0,1}
                    
Send == /\ rdy=ack
        /\ val' \in Data
        /\ rdy'= 1-rdy
        /\ UNCHANGED ack
        
Receive ==  /\ rdy /= ack
            /\ ack' = 1 - ack
            /\ UNCHANGED val
            /\ UNCHANGED rdy
        
Next==  Send \/ Receive

=============================================================================
\* Modification History
\* Last modified Wed Feb 19 13:30:39 CET 2020 by tomko
\* Created Tue Feb 11 09:43:09 CET 2020 by tomko
