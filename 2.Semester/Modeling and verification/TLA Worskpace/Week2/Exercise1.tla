----------------------------- MODULE Exercise1 -----------------------------
EXTENDS Naturals
VARIABLES hr
HCini == hr \in (1..12)
HCini == HCini
HCnxt == hr' = IF hr # 12 THEN hr + 1 ELSE 1
HC == HCini /\ [][HCnxt]_hr
THEOREM HC => []HCini

=============================================================================
\* Modification History
\* Last modified Tue Feb 04 10:25:24 CET 2020 by tomko
\* Created Tue Feb 04 09:30:06 CET 2020 by tomko


