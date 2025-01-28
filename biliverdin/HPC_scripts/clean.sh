#!/bin/bash

pH_init=1.0
pH_final=9.5
pH_step=0.5

i=$pH_init
while (( $(bc <<< "$i <= $pH_final") )); do
  cd ${i}
  rm *
  cd ..
 i=$(bc <<< "$i + $pH_step")
done
