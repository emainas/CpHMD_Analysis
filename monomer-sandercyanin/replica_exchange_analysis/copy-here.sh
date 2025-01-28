#!/bin/bash

pH_min=3.5 #The lowest pH
pH_max=10.0 #The highest pH
pH_step=0.5

m=$pH_min
while (( $(bc <<< "$m <= $pH_max") )); do
  cp ../${m}/mon.md1.cpout mon.md${m}.cpout
  m=$(bc <<< "$m + $pH_step")
done
