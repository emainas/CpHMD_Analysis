#!/bin/bash

pH_min=1.0 #The lowest pH
pH_max=9.5 #The highest pH
pH_step=0.5


#This loop extracts the files from the pH folders using the cphstats program
m=$pH_min
while (( $(bc <<< "$m <= $pH_max") )); do
  mv reordered.cpout.pH_${m}0 reordered.cpout.pH_${m}
  m=$(bc <<< "$m + $pH_step")
done
