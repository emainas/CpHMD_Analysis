#!/bin/bash

pH_min=3.5   # The lowest pH
pH_max=10.0   # The highest pH
pH_step=0.5

# Initialize arrays
residues4=(111) # For BLA
m=$pH_min
while (( $(bc <<< "$m <= $pH_max") )); do
    for res in "${residues4[@]}"; do
	echo "Processing residue $res at pH $m" 
    	awk "/^Residue  $res/ {
        	state = \$4;
        	if (state == 0) {
            	print 0;
		} else if (state >= 5 && state <= 8) {
                print 0;
        	} else if (state >= 1 && state <= 4) {
            	print 1;
        	} else if (state >= 9 && state <= 24) {
            	print 1;
        	}
    	}" reordered.cpout.pH_${m} >> BV_state_vectors/${m}/prn-A_res${res}_pH${m}.dat
    done
    m=$(bc <<< "$m + $pH_step")
done

m=$pH_min
while (( $(bc <<< "$m <= $pH_max") )); do
    for res in "${residues4[@]}"; do
        echo "Processing residue $res at pH $m" 
        awk "/^Residue  $res/ {
                state = \$4;
                if (state == 0) {
                print 0;
		} else if (state >= 1 && state <= 4) {
                print 0;
                } else if (state >= 5 && state <= 8) {
                print 1;
                } else if (state >= 9 && state <= 24) {
                print 1;
                }
        }" reordered.cpout.pH_${m} >> BV_state_vectors/${m}/prn-D_res${res}_pH${m}.dat
    done
    m=$(bc <<< "$m + $pH_step")
done

