------------------------------ MODULE Dekkers1 ------------------------------
EXTENDS Naturals, Sequences, TLC

CONSTANTS NN

Node == 1..NN

(*

--algorithm Dekkers

variables b = [p \in Node\cup{0} |-> 1], 
          c = [p \in Node |-> 1], 
          turn = 0,

process Proc \in Node
  variables j = 0
begin
  P0: b[self] := 0;
  P1: if turn # self then
  P2:   c[self] := 1;
  P3:   if b[turn] = 1 then
  P4:     turn := self;
        end if;
  P5:   goto P1;
      end if;
  P6: c[self] := 0;
  P7: j := 1;
  P8: while j <= NN do
  P9:   if j # self /\ c[j] = 0 then
  PA:     goto P1;
        end if;
      end while;
  (* critical section *)
  PB: turn := 0;
  PC: c[self] := 1;
  PD: b[self] := 1;
  PE: goto P0;
end process;

end algorithm;
*)

=============================================================================
\* Modification History
\* Last modified Mon May 14 13:23:16 CEST 2018 by halstefa
\* Created Tue Apr 10 21:09:33 CEST 2018 by halstefa
