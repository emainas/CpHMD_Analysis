#!/bin/bash

#SBATCH --nodes=32
#SBATCH -p 2112_queue
#SBATCH --tasks-per-node=44
#SBATCH --cpus-per-task=1
#SBATCH -J tet.md1
#SBATCH -t 48:00:00
#SBATCH --mail-user emainas@unc.edu
#SBATCH --mail-type BEGIN
#SBATCH --mail-type END

module load amber/22p5  

mpirun -bind-to core:overload-allowed -np 1400 pmemd.MPI -ng 14 -groupfile remd.groupfile.md1
