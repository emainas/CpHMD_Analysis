#!/bin/bash

residues1=() # For LYS or TYR
residues2=() # For AS4 or GL4
residues3=() # For HIP
residues4=() # For BLA

while read -r line; do
    
    res_name=$(echo "$line" | awk '{print $2}')   # Extract residue name
    res_index=$(echo "$line" | awk '{print $6}')  # Extract index

    if [[ "$res_name" == "LYS" || "$res_name" == "TYR" ]]; then
        residues1+=("$res_index")
    elif [[ "$res_name" == "AS4" || "$res_name" == "GL4" ]]; then
        residues2+=("$res_index")
    elif [[ "$res_name" == "HIP" ]]; then
        residues3+=("$res_index")
    elif [[ "$res_name" == "BLA" ]]; then
        residues4+=("$res_index")
    fi
done < residues_list.txt

echo "residues1 = (${residues1[@]})"
echo "residues2 = (${residues2[@]})"
echo "residues3 = (${residues3[@]})"
echo "residues4 = (${residues4[@]})"

pH_min=3.5
pH_max=10.0
pH_step=0.5

m=$pH_min

# LYS and TYR loop
while (( $(bc <<< "$m <= $pH_max") )); do
        mkdir binary_vectors_${m}
        for res in "${residues1[@]}"; do
        	echo "Processing residue $res at pH $m" 
        	awk '{
                     state = $1;
                     if (state == 0) {
                     print 1;
                     } else if (state == 1) {
                     print 0;
                     }
        	}' states_${m}/res_${res}.dat >> binary_vectors_${m}/res${res}_pH${m}.dat
    	done
    	m=$(bc <<< "$m + $pH_step")
done

m=$pH_min
# AS4 and GL4 loop
while (( $(bc <<< "$m <= $pH_max") )); do
        for res in "${residues2[@]}"; do
                echo "Processing residue $res at pH $m" 
                awk '{
                     state = $1;
                     if (state == 0) {
                     print 0;
                     } else if (state == 1) {
                     print 1;
                     } else if (state == 2) {
                     print 1;
		     } else if (state == 3) {
                     print 1;
                     } else if (state == 4) {
                     print 1;
                     }
                }' states_${m}/res_${res}.dat >> binary_vectors_${m}/res${res}_pH${m}.dat
        done
        m=$(bc <<< "$m + $pH_step")
done

m=$pH_min
# HIP loop
while (( $(bc <<< "$m <= $pH_max") )); do
        for res in "${residues3[@]}"; do
                echo "Processing residue $res at pH $m" 
                awk '{
                     state = $1;
                     if (state == 0) {
                     print 1;
                     } else if (state == 1) {
                     print 0;
                     } else if (state == 2) {
                     print 0;
                     }
                }' states_${m}/res_${res}.dat >> binary_vectors_${m}/res${res}_pH${m}.dat
        done
        m=$(bc <<< "$m + $pH_step")
done

