#!/bin/bash

pH_min=3.5 #The lowest pH
pH_max=10.0 #The highest pH
pH_step=0.5

i=0
m=$pH_min
while (( $(bc <<< "$m <= $pH_max") )); do
  ln ../${m}/mon.md1.nc mon.md1.nc.00${i}
  ln ../${m}/mon.md1.cpout cpout.${i}
  m=$(bc <<< "$m + $pH_step")
  i=$((i + 1))
done
