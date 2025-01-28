#!/bin/bash

output_file="apo.dat"
resnames=()
resid=()
deprot=()
pH_min=3.5 #The lowest pH
pH_max=10.0 #The highest pH
pH_step=0.5
number_of_residues=27

ml amber/22p5

#This loop extracts the files from the pH folders using the cphstats program
m=$pH_min
while (( $(bc <<< "$m <= $pH_max") )); do
  cphstats -i apo.md1.cpin reordered.cpout.pH_${m} -o pH${m}_calcpka.dat --population pH${m}_populations.dat
  m=$(bc <<< "$m + $pH_step")
done

#This loop creates the header in the output file
for (( k=1 ; k<=$number_of_residues; k++ )); do
 resnames[$k]=$(awk -v line=$((k + 1)) 'NR==line {printf "%s%s", $1, $2}' pH${pH_min}_calcpka.dat)
done

echo "pH "" ${resnames[*]}" >> "$output_file"

#This loop writes the deprotonated fraction for each titratable residue
i=$pH_min
while (( $(bc <<< "$i <= $pH_max") )); do

  deprot=()

  for (( n=1 ; n<=number_of_residues ; n++ )); do
    resid[$n]=$(awk -v line=$((n + 1)) 'NR==line {print $10}' pH${i}_calcpka.dat)
  done

  for element in "${resid[@]}"; do
    result=$(bc <<< "1.0 - $element")
    formatted_result=$(printf "%.3f" "$result")
    deprot+=("$formatted_result")
  done

  echo "$i" "${deprot[*]}" >> "$output_file"
  i=$(bc <<< "$i + $pH_step")
done
