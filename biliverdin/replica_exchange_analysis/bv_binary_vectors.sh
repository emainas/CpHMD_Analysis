#!/bin/bash

pH_min=1.0   # The lowest pH
pH_max=9.5   # The highest pH
pH_step=0.5

residues4=(0)
m=$pH_min
mkdir BV_binary_vectors
while (( $(bc <<< "$m <= $pH_max") )); do
    mkdir BV_binary_vectors/${m}
    for res in "${residues4[@]}"; do
	echo "Processing residue $res at pH $m" 
    	awk '{
             state = $1;
             if (state == 0) {
             print 1;
	     } else if (state >= 5 && state <= 8) {
             print 0;
             } else if (state >= 1 && state <= 4) {
             print 0;
             } else if (state >= 9 && state <= 24) {
             print 0;
             }
    	}' states_${m}/res_${res}.dat >> BV_binary_vectors/${m}/p00_res${res}_pH${m}.dat
    done
    m=$(bc <<< "$m + $pH_step")
done

m=$pH_min
while (( $(bc <<< "$m <= $pH_max") )); do
    for res in "${residues4[@]}"; do
        echo "Processing residue $res at pH $m" 
        awk '{
             state = $1;
             if (state == 0) {
             print 0;
	     } else if (state >= 1 && state <= 4) {
             print 1;
             } else if (state >= 5 && state <= 8) {
             print 0;
             } else if (state >= 9 && state <= 24) {
             print 0;
             }
        }' states_${m}/res_${res}.dat >> BV_binary_vectors/${m}/p10_res${res}_pH${m}.dat
    done
    m=$(bc <<< "$m + $pH_step")
done

m=$pH_min
while (( $(bc <<< "$m <= $pH_max") )); do
    for res in "${residues4[@]}"; do
        echo "Processing residue $res at pH $m" 
        awk '{
                state = $1;
                if (state == 0) {
                print 0;
                } else if (state >= 1 && state <= 4) {
                print 0;
                } else if (state >= 5 && state <= 8) {
                print 1;
                } else if (state >= 9 && state <= 24) {
                print 0;
                }
        }' states_${m}/res_${res}.dat >> BV_binary_vectors/${m}/p01_res${res}_pH${m}.dat
    done
    m=$(bc <<< "$m + $pH_step")
done

m=$pH_min
while (( $(bc <<< "$m <= $pH_max") )); do
    for res in "${residues4[@]}"; do
        echo "Processing residue $res at pH $m" 
        awk '{
             state = $1;
             if (state == 0) {
             print 0;
             } else if (state >= 1 && state <= 4) {
             print 0;
             } else if (state >= 5 && state <= 8) {
             print 0;
             } else if (state >= 9 && state <= 24) {
             print 1;
             }
        }' states_${m}/res_${res}.dat >> BV_binary_vectors/${m}/p11_res${res}_pH${m}.dat
    done
    m=$(bc <<< "$m + $pH_step")
done
