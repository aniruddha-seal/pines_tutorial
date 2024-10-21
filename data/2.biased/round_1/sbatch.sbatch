#!/bin/bash

# email on start, end, and abortion
#SBATCH --mail-type=ALL
#SBATCH --mail-user=aniruddhaseal@uchicago.edu

#SBATCH --job-name=NaCL_biased

#SBATCH --output=out.out
#SBATCH --error=error.err
#SBATCH --partition=gm4-pmext
#SBATCH --account=pi-andrewferguson
#SBATCH --qos=gm4

# max wall time for job (HH:MM:SS)
#SBATCH --time=1-12:00:00

# number of GPU(s) per node, if available
#SBATCH --gres=gpu:1

# number of nodes for this job
#SBATCH --nodes=1

# number of processes to run per node
#SBATCH --ntasks-per-node=4

# number of threads per cpu
#SBATCH --cpus-per-task=5


# THIS EXAMPLE USES 1 GPU NODE - 1 MPI TASK - 4 THREADS PER TASK

NCPU=$(($SLURM_NTASKS_PER_NODE))
NTHR=$(($SLURM_CPUS_PER_TASK))
NNOD=$(($SLURM_JOB_NUM_NODES))

NP=$(($NCPU * $NNOD * $NTHR))

module unload openmpi gcc cuda python
module load openmpi/4.1.1+gcc-10.1.0 cuda/11.2

# PLUMED and GROMACS paths
export PLUMED_ROOT=/project/andrewferguson/armin/grom_new/plumed-2.8.3
export PATH=$PATH:/project/andrewferguson/armin/grom_new/plumed-2.8.3/build_gpu2/bin
export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/project/andrewferguson/armin/grom_new/plumed-2.8.3/build_gpu2/lib/pkgconfig
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/project/andrewferguson/armin/grom_new/plumed-2.8.3/build_gpu2/lib
export LIBRARY_PATH=$LIBRARY_PATH:/project/andrewferguson/armin/grom_new/plumed-2.8.3/build_gpu2/lib
export CPATH=$CPATH:/project/andrewferguson/armin/grom_new/plumed-2.8.3/build_gpu2/include
export PLUMED_KERNEL=/project/andrewferguson/armin/grom_new/plumed-2.8.3/build_gpu2/lib/libplumedKernel.so

source /project/andrewferguson/armin/grom_new/gromacs-2021.6/installed-files-gpu2/bin/GMXRC

gmx mdrun -s md.tpr -ntomp "$NP" -deffnm biased -plumed plumed_parameterized.dat -cpi biased.cpt
