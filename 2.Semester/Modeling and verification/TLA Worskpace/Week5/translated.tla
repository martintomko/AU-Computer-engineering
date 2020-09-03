----------------------------- MODULE translated -----------------------------

EXTENDS Naturals, TLC
CONSTANT K
VARIABLES m, n, u, v, pc

Divides(i,j) == \E k \in {0..j}: j=i*K

IsGCD(i,j,k) == /\ Divides(i,j)
                /\ Divides(i,k)
                /\ \A r \in {0..j} \union {0..k}: Divides(r,j) /\ Divides(r,k) => Divides(r,i)

vars == << m, n, u, v, pc >>

Init == (* Global variables *)
        /\ m \in {1..K}
        /\ n \in {1..K}
        /\ u = m
        /\ v = n
        /\ pc = "Lbl_1"

Lbl_1 == /\ pc = "Lbl_1"
         /\ IF u # 0
               THEN /\ IF u < v
                          THEN /\ /\ u' = v
                                  /\ v' = u
                          ELSE /\ TRUE
                               /\ UNCHANGED << u, v >>
                    /\ pc' = "Lbl_2"
               ELSE /\ Assert(IsGCD(v, m, n), 
                              "Failure of assertion at line 21, column 7.")
                    /\ pc' = "Done"
                    /\ UNCHANGED << u, v >>
         /\ UNCHANGED << m, n >>

Lbl_2 == /\ pc = "Lbl_2"
         /\ u' = u - v
         /\ pc' = "Lbl_1"
         /\ UNCHANGED << m, n, v >>

(* Allow infinite stuttering to prevent deadlock on termination. *)
Terminating == pc = "Done" /\ UNCHANGED vars

Next == Lbl_1 \/ Lbl_2
           \/ Terminating

Spec == Init /\ [][Next]_vars

Termination == <>(pc = "Done")
=============================================================================
