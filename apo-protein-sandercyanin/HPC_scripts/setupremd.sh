#!/bin/bash

pH_init=3.5
pH_final=10.0
pH_step=0.5

ph=$pH_init # The index that holds the pH variable
md=1 # The index of the md run
remd_output="remd.groupfile.md${md}" # Name of the groupfile file
rep=1

while (( $(bc <<< "$ph <= $pH_final") )); do
  
 echo "# Replica number ${rep} with pH ${ph}" >> "$remd_output"
 echo "-O -i ${ph}/apo.md${md}.mdin -p longleaf_input_files/apo.mod.parm7 -c longleaf_input_files/apo.md${md}.rst7 -cpin longleaf_input_files/apo.md${md}.cpin -o ${ph}/apo.md${md}.mdout -cpout ${ph}/apo.md${md}.cpout -inf ${ph}/apo.md${md}.mdinfo -x ${ph}/apo.md${md}.nc -cprestrt ${ph}/apo.md$((md+1)).cpin -r ${ph}/apo.md$((md+1)).rst7 -rem 4 -remlog rem.md${md}.log" >> "$remd_output" 
 
  echo "Explicit solvent pH-REMD
 &cntrl
  imin=0, irest=1, ntx=5, ntxo=2,
  ntpr=1000, ntwx=1000, ntwr=1000,
  nstlim=100, numexchg=200000, 
  dt=0.002, ntt=3, tempi=300,
  temp0=300, gamma_ln=5.0, ig=-1,
  ntc=2, ntf=2, cut=8, iwrap=1,
  ioutfm=1, icnstph=2, ntcnstph=100,
  solvph=${ph}, ntrelax=100, saltcon=0.1,
 /" >> "${ph}/apo.md${md}.mdin" 
 
 ph=$(bc <<< "$ph + $pH_step")
 rep=$((rep+1))
done
