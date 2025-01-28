#!/bin/bash

pH_min=3.5 #The lowest pH
pH_max=10.0 #The highest pH
pH_step=0.5

deprot=0
lefty=0
righty=0
doubly=0
sum=0

# Biliverdins are residues 54,55,110,111
# Only for test I extract the 54 biliverdin which corresponds
# to chain A

m=$pH_min
while (( $(bc <<< "$m <= $pH_max") )); do
  
  for i in {0..24}; do 
    echo "STATE $i";
    if [ "$i" -eq 0 ]; then
        grep "Residue   54 State:  $i" reordered.cpout.pH_${m} | wc -l; 
        count_dd=$(grep "Residue   54 State:  $i" reordered.cpout.pH_${m} | wc -l) 
        deprot=$((count_dd + deprot))
    elif [ "$i" -ge 1 ] && [ "$i" -le 4 ]; then 
        grep "Residue   54 State:  $i" reordered.cpout.pH_${m} | wc -l; 
        count_left=$(grep "Residue   54 State:  $i" reordered.cpout.pH_${m} | wc -l)
        lefty=$((count_left + lefty))
    elif [ "$i" -ge 5 ] && [ "$i" -le 8 ]; then
        grep "Residue   54 State:  $i" reordered.cpout.pH_${m} | wc -l; 
        count_right=$(grep "Residue   54 State:  $i" reordered.cpout.pH_${m} | wc -l)
        righty=$((count_right + righty))
    else 
        grep "Residue   54 State: $i" reordered.cpout.pH_${m} | wc -l; 
        count_pp=$(grep "Residue   54 State: $i" reordered.cpout.pH_${m} | wc -l)
        doubly=$((count_pp + doubly))
    fi 
  done
  
  sum=$((deprot+lefty+righty+doubly))
  

  p00=$(echo "scale=8; $deprot / $sum" | bc)
  p10=$(echo "scale=8; $lefty / $sum" | bc)
  p01=$(echo "scale=8; $righty / $sum" | bc)
  p11=$(echo "scale=8; $doubly / $sum" | bc)  
  
  printf "%.8f\n" "$p00" >> bla_microstate/p00a.dat
  printf "%.8f\n" "$p10" >> bla_microstate/p10a.dat
  printf "%.8f\n" "$p01" >> bla_microstate/p01a.dat
  printf "%.8f\n" "$p11" >> bla_microstate/p11a.dat 
  
  echo "Deprot array is $deprot"
  echo "Lefty array is $lefty"
  echo "Righty array is $righty"
  echo "Doubly array is $doubly"
  echo "The sum is $sum"  
  
  echo "The fractions are $p00 $p10 $p01 $p11"  
  

  # Empty all the variables for re-use
  deprot=0
  lefty=0
  righty=0
  doubly=0
  sum=0
  m=$(bc <<< "$m + $pH_step")
done
