#!/bin/bash

pH_min=3.5
pH_max=10.0 
pH_step=0.5

m=$pH_min
while (( $(bc <<< "$m <= $pH_max") )); do
	mkdir states_${m}
	grep -A116 Solvent reordered.cpout.pH_${m} > full_records_${m}.out
	for i in {0..9}; do grep "Residue    $i" full_records_${m}.out | awk '{print $4}' > states_${m}/res_$i.dat; done
	for i in {10..99}; do grep "Residue   $i" full_records_${m}.out | awk '{print $4}' > states_${m}/res_$i.dat; done
	for i in {100..111}; do grep "Residue  $i" full_records_${m}.out | awk '{print $4}' > states_${m}/res_$i.dat; done
	m=$(bc <<< "$m + $pH_step")
done
