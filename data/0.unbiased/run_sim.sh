#!/bin/bash

NTASKS=$(($SLURM_NTASKS_PER_NODE * $SLURM_JOB_NUM_NODES))

# SET NUMBER OF OPENMP THREADS
OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK


cd 1_solvate



# Solvate
gmx solvate -box 2.5 2.5 2.5 -cs spc216.gro -o box.gro -p topol.top
gmx grompp -f ions.mdp -c box.gro -p topol.top -o ions.tpr
echo SOL | gmx genion -s ions.tpr -o ions.gro -p topol.top -pname NA -nname CL -np 1 -nn 1
cd ..

cp 1_solvate/ions.gro 2_em
cp 1_solvate/topol.top 2_em

cd 2_em

# Energy minimize and equilibrate

gmx grompp -f minim.mdp -c ions.gro -p topol.top -o em.tpr -maxwarn 3
mpirun -np $NTASKS gmx mdrun -ntomp $OMP_NUM_THREADS -v -deffnm em

gmx grompp -f nvt.mdp -c em.gro -r em.gro -p topol.top -o nvt.tpr -maxwarn 3
mpirun -np $NTASKS gmx mdrun -ntomp $OMP_NUM_THREADS -v -deffnm nvt

cd ..

cp 2_em/nvt.gro 3_md/
cp 2_em/nvt.cpt 3_md/
cp 2_em/topol.top 3_md/

cd 3_md/

gmx grompp -f md.mdp -c nvt.gro -t nvt.cpt -p topol.top -o md.tpr -maxwarn 2
mpirun -np $NTASKS gmx mdrun -ntomp $OMP_NUM_THREADS -v -deffnm md -plumed plumed.dat
echo 0 | gmx trjconv -f md.xtc -s md.tpr -o md_whole.xtc -pbc whole
