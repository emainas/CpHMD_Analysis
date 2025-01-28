#!/bin/bash

ml amber/22p5

pH_min=3.5   # The lowest pH
pH_max=10.0   # The highest pH
pH_step=0.5

# the MC step is 100 so print the "chunk" every MC step to get the actual state vectors 

m=$pH_min
while (( $(bc <<< "$m <= $pH_max") )); do
	cphstats -i mon.md1.cpin reordered.cpout.pH_${m} --no-calcpka --chunk 100 --chunk-out pH_${m}_state_vectors.dat -p
        m=$(bc <<< "$m + $pH_step") 
done
