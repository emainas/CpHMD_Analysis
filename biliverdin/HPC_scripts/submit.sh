#!/bin/bash

#SBATCH --nodes=18
#SBATCH -p 2112_queue
#SBATCH --tasks-per-node=44
#SBATCH --cpus-per-task=1
#SBATCH -J bla.md1
#SBATCH -t 18:00:00
#SBATCH --mail-user emainas@unc.edu
#SBATCH --mail-type BEGIN
#SBATCH --mail-type END

module load amber/22p5  

mpirun -bind-to core:overload-allowed -np 792 pmemd.MPI -ng 18 -groupfile remd.groupfile.md1
