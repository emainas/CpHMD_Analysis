#!/bin/bash

pH_min=1.0
pH_max=9.5 
pH_step=0.5

m=$pH_min
i=0
while (( $(bc <<< "$m <= $pH_max") )); do
	mkdir states_${m}
	grep -A4 Solvent reordered.cpout.pH_${m} > full_records_${m}.out
	grep "Residue    $i" full_records_${m}.out | awk '{print $4}' > states_${m}/res_${i}.dat
	m=$(bc <<< "$m + $pH_step")
done
