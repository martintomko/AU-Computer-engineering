----------------------------- MODULE ass2 -----------------------------
EXTENDS TLC, Naturals
CONSTANT N
(*--algorithm FastMutex
      variables x = 0, y = 0, b = [i \in 1..N |-> FALSE] ;
      process Proc \in 1..N
      variable j ;
      begin 
        ncs: skip ;
        start: b[self] := TRUE;
        L1: x := self;
        L2: if (y /= 0) then 
                L3: b[self] := FALSE;
                L4: await y = 0;
                    goto start;
        end if;
        L5: y := self;
        L6: if (x /= self ) then
                L7: b[self] := FALSE;
                    j := 1;
                L8: while (j <= N ) do
                        await ~b[j] ;
                        j := j + 1; 
                end while;
                L9: if (y /= self ) then 
                        L10: await y = 0;
                            goto start; 
                end if;
            end if;
        cs: assert \A p \in 1..N \ {self} : pc[p] # "cs";
        L11: y := 0;
        L12: b[self] := FALSE;
        goto ncs;
      end process;
end algorithm;*)
\* BEGIN TRANSLATION
CONSTANT defaultInitValue
VARIABLES x, y, b, pc, j

vars == << x, y, b, pc, j >>

ProcSet == (1..N)

Init == (* Global variables *)
        /\ x = 0
        /\ y = 0
        /\ b = [i \in 1..N |-> FALSE]
        (* Process Proc *)
        /\ j = [self \in 1..N |-> defaultInitValue]
        /\ pc = [self \in ProcSet |-> "ncs"]

ncs(self) == /\ pc[self] = "ncs"
             /\ TRUE
             /\ pc' = [pc EXCEPT ![self] = "start"]
             /\ UNCHANGED << x, y, b, j >>

start(self) == /\ pc[self] = "start"
               /\ b' = [b EXCEPT ![self] = TRUE]
               /\ pc' = [pc EXCEPT ![self] = "L1"]
               /\ UNCHANGED << x, y, j >>

L1(self) == /\ pc[self] = "L1"
            /\ x' = self
            /\ pc' = [pc EXCEPT ![self] = "L2"]
            /\ UNCHANGED << y, b, j >>

L2(self) == /\ pc[self] = "L2"
            /\ IF (y /= 0)
                  THEN /\ pc' = [pc EXCEPT ![self] = "L3"]
                  ELSE /\ pc' = [pc EXCEPT ![self] = "L5"]
            /\ UNCHANGED << x, y, b, j >>

L3(self) == /\ pc[self] = "L3"
            /\ b' = [b EXCEPT ![self] = FALSE]
            /\ pc' = [pc EXCEPT ![self] = "L4"]
            /\ UNCHANGED << x, y, j >>

L4(self) == /\ pc[self] = "L4"
            /\ y = 0
            /\ pc' = [pc EXCEPT ![self] = "start"]
            /\ UNCHANGED << x, y, b, j >>

L5(self) == /\ pc[self] = "L5"
            /\ y' = self
            /\ pc' = [pc EXCEPT ![self] = "L6"]
            /\ UNCHANGED << x, b, j >>

L6(self) == /\ pc[self] = "L6"
            /\ IF (x /= self )
                  THEN /\ pc' = [pc EXCEPT ![self] = "L7"]
                  ELSE /\ pc' = [pc EXCEPT ![self] = "cs"]
            /\ UNCHANGED << x, y, b, j >>

L7(self) == /\ pc[self] = "L7"
            /\ b' = [b EXCEPT ![self] = FALSE]
            /\ j' = [j EXCEPT ![self] = 1]
            /\ pc' = [pc EXCEPT ![self] = "L8"]
            /\ UNCHANGED << x, y >>

L8(self) == /\ pc[self] = "L8"
            /\ IF (j[self] <= N )
                  THEN /\ ~b[j[self]]
                       /\ j' = [j EXCEPT ![self] = j[self] + 1]
                       /\ pc' = [pc EXCEPT ![self] = "L8"]
                  ELSE /\ pc' = [pc EXCEPT ![self] = "L9"]
                       /\ j' = j
            /\ UNCHANGED << x, y, b >>

L9(self) == /\ pc[self] = "L9"
            /\ IF (y /= self )
                  THEN /\ pc' = [pc EXCEPT ![self] = "L10"]
                  ELSE /\ pc' = [pc EXCEPT ![self] = "cs"]
            /\ UNCHANGED << x, y, b, j >>

L10(self) == /\ pc[self] = "L10"
             /\ y = 0
             /\ pc' = [pc EXCEPT ![self] = "start"]
             /\ UNCHANGED << x, y, b, j >>

cs(self) == /\ pc[self] = "cs"
            /\ Assert(\A p \in 1..N \ {self} : pc[p] # "cs", 
                      "Failure of assertion at line 30, column 13.")
            /\ pc' = [pc EXCEPT ![self] = "L11"]
            /\ UNCHANGED << x, y, b, j >>

L11(self) == /\ pc[self] = "L11"
             /\ y' = 0
             /\ pc' = [pc EXCEPT ![self] = "L12"]
             /\ UNCHANGED << x, b, j >>

L12(self) == /\ pc[self] = "L12"
             /\ b' = [b EXCEPT ![self] = FALSE]
             /\ pc' = [pc EXCEPT ![self] = "ncs"]
             /\ UNCHANGED << x, y, j >>

Proc(self) == ncs(self) \/ start(self) \/ L1(self) \/ L2(self) \/ L3(self)
                 \/ L4(self) \/ L5(self) \/ L6(self) \/ L7(self)
                 \/ L8(self) \/ L9(self) \/ L10(self) \/ cs(self)
                 \/ L11(self) \/ L12(self)

(* Allow infinite stuttering to prevent deadlock on termination. *)
Terminating == /\ \A self \in ProcSet: pc[self] = "Done"
               /\ UNCHANGED vars

Next == (\E self \in 1..N: Proc(self))
           \/ Terminating

Spec == Init /\ [][Next]_vars

Termination == <>(\A self \in ProcSet: pc[self] = "Done")
Invariant == \A p1, p2 \in 1..N: p1 # p2 => ~((pc[p1] = "cs") /\ (pc[p2] = "cs"))


\* END TRANSLATION

=============================================================================
