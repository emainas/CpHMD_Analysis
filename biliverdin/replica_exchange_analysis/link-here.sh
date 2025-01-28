#!/bin/bash

pH_min=1.0 #The lowest pH
pH_max=9.5 #The highest pH
pH_step=0.5

m=$pH_min
while (( $(bc <<< "$m <= $pH_max") )); do
  ln ../${m}/bla.md1.cpout bla.md${m}.cpout
  m=$(bc <<< "$m + $pH_step")
done
