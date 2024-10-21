#!/bin/bash

plumed driver --plumed plumed_calcPIV_newSFP_piv91.dat --mf_xtc md_whole.xtc >& out.out

sed -i '/#END OF FRAME/d' PINES_representation_traj.dat

python3 genNPYfile.py
