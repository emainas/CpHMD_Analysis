#!/bin/bash

pH_init=3.5
pH_final=10.0
pH_step=0.5

i=$pH_init
while (( $(bc <<< "$i <= $pH_final") )); do
  cd ${i}
  rm *
  cd ..
 i=$(bc <<< "$i + $pH_step")
done
