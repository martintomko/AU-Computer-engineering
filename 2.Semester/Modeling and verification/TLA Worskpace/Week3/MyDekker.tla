------------------------------ MODULE Dekkers2 ------------------------------
EXTENDS Naturals, Sequences, TLC

CONSTANTS NN

Node == 1..NN

(*

--algorithm Dekkers

variables want = [p \in Node\cup{0} |-> 0], (* wants to enter *)
          completed = [p \in Node |-> 0],  (* has completed critical *)
          turn = 0,
          critical = 0;

process Proc \in Node
begin
  P0: completed[self] := 0;
  P1: want[self] := 1;    
  P2: if turn # self then
  P3:   want[self] := 0;
  P4:   if completed[turn] := 1 then
  P5:     turn := self;
  P6:     want[self] := 1;
        end if;
  P7    goto P2;
      end if;
  P8: with j \in 1..NN do
  PA:   if j # self /\ want[j] = 1 then
  PB:     goto P1;
        end if;
      end with;
  (* critical section *)
  C1: critical := critical + 1;
  C2: critical := critical - 1;
  PC: turn := 0;
  PD: want[self] := 0;
  PE: comlpeted[self] := 1;
  PF: goto P0;
end process;

end algorithm;
*)
