#!/bin/bash

#SBATCH --nodes=1
#SBATCH -p debug_queue
#SBATCH --tasks-per-node=44
#SBATCH --cpus-per-task=1
#SBATCH -J bla.md1
#SBATCH -t 00:01:00

module load amber/22p5  

mpirun -bind-to core:overload-allowed -np 36 pmemd.MPI -ng 18 -groupfile remd.groupfile.md1
