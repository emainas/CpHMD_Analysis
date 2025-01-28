#!/bin/bash

#SBATCH --nodes=1
#SBATCH -p debug_queue
#SBATCH --tasks-per-node=44
#SBATCH --cpus-per-task=1
#SBATCH -J tet.TEST
#SBATCH -t 00:01:00

module load amber/22p5  

mpirun -bind-to core:overload-allowed -np 28 pmemd.MPI -ng 14 -groupfile remd.groupfile.md1
