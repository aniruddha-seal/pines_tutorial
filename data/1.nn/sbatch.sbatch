#!/bin/bash

# email on start, end, and abortion
#SBATCH --mail-type=ALL
#SBATCH --mail-user=nherringer@uchicago.edu

#SBATCH --job-name=FVE_NaCl_Tut

#SBATCH --output=out.out
#SBATCH --partition=andrewferguson-gpu
#SBATCH --account=pi-andrewferguson
#SBATCH --nodes=1            # SET NUM NODES
#SBATCH --gres=gpu:1        # SET NUM GPUS
#SBATCH --ntasks-per-node=1  # SETS NUM MPI RANKS (1 PER GPU)
#SBATCH --cpus-per-task=10    # SET NUM THREADS


# THIS EXAMPLE USES 1 GPU NODE - 1 MPI TASK - 4 THREADS PER TASK

# SET NUMBER OF MPI TASKS
# SET NUMBER OF MD STEPS

#LOAD GROMACS MODULE

#module unload cuda gcc openmpi cmake eigen gsl blast clang/7.1.0+gcc-6.1 boost python vmd
#module load gcc/10.2.0
#module load openmpi/3.1.2
#module load cmake/3.15
#module load eigen/3.2
#module load gsl
#module load blast
#module load cuda/11.2
#module load python/anaconda-2020.02
#module load vmd/1.9.3
#source /home/nherringer/gromacs-2021.1/installed-files/bin/GMXRC

#module load use.deprecated
#module load cuda/10.0
#module load openmpi/2.0.2
#source /project2/andrewferguson/Kirill/plumed_mods/plumed-2.5.2/sourceme.sh
#source /project2/andrewferguson/Kirill/gromacs_2019.2/bin/GMXRC
#module load Anaconda3/2019.03
#source activate nherringer


#module load openmpi/4.1.2+gcc-7.4.0
#module load gsl
#module load cuda/11.2
#module load python
#export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$PLUMEDPATH/lib
#export PATH=$PATH:$PLUMEDPATH/bin

module load python
source activate torchML

bash auto_train.sh >& out.out
