Permutationally Invariant Networks for Enhanced Sampling (PINES) is a data-driven
method for studying free energy landscapes of both single and multi-molecular systems.
PINES discovers collective variables (CVs) that are translationally, rotationally, and
permutationally invariant in an iterative manner by taking permutationally invariant
vectors (PIV) as input and passing them through a regularized autoencoder to discover
high-variance CVs  using the Molecular Enhanced Sampling with Autoencoders (MESA) technique.
In this advanced PLUMED tutorial, we first provide an overview of
the PINES method and demonstrate its application to study ion dissociation in water.


We use Jupyter notebooks that cover the entire iterative process of PINES — initial
simulation setup, feature determination for constructing PIVs, dimensionality reduction
using regularized autoencoders, whitening the latent space using principal component
analysis, and generating PLUMED files for biasing using parallel bias metadynamics. All
the input files required to run the tutorial will also be provided with the tutorial.

The primary learning objectives from this tutorial are permutationally invariant molecular representations,
high-variance CVs, autoencoders, and enhanced sampling methods at a high level
along with a practical understanding of PINES to molecular systems in PLUMED. We
assume the user is familiar with CV biasing enhanced sampling methods and usage of
metadynamics introduced in early PLUMED tutorials.

```mermaid
flowchart TB;
  A[PINES Paper] ==> C[Description] 
  B[MESA Paper] --> C
  C ==> D[Notebook];
  E[Metadynamics] -.-> D;
  click A "ref1" "The paper about the PINES method introduced in this tutorial";
  click B "ref2" "The paper about the MESA method, the previous iteration of PINES which is not permutation invariant";
  click C "DESCRIPTION.md" "A very brief introduction to PINES and the instructions for the exercises";
  click D "notebooks/PINES_tutorial.ipynb" "A python notebook file containing the exercise";
  click E "ref3" "This tutorial teaches you how to run metadynamics simulations";
```
