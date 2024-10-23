Permutationally Invariant Network for Enhanced Sampling (PINES) is a data-driven method for the automatic discovery of high variance collective variables (CVs) and enhanced sampling to obtain free energy landscapes of both single and multi-component molecular systems. It can be conceived as a permutationally invariant extension to the Molecular Enhanced Sampling with Autoencoders (MESA) method. PINES comprises three main components (Fig. 1):

1. Permutation Invariant Vector (PIV) featurization (F):  Translationally, rotationally, and permutationally invariant representation of the molecular system.
2. Universal function approximators (Autoencoders): Discovery of high-variance CVs {($\xi_1$, $\xi_2$, ...)}
3. Molecular dynamics (MD) simulations with CV biasing method: An enhanced sampling MD simulation of the system by biasing along the high variance CVs learned by the autoencoders to improve sampling of the system. We use Parallel-Bias Metadynamics (PBMetaD) in this tutorial, but any CV-enhanced sampling technique can be employed for this part.

![PINES Workflow](figures/PINES.png)

In this introductory tutorial, we apply PINES to study the association or dissociation process of a NaCl ion pair in water. This is a classic system, where it is well known that the rearrangement of water molecules in the solvation shell of ions plays a critical role in driving the association or dissociation of NaCl. In other words, enhanced sampling of association or dissociation of Na+ and Cl- ions in water may require explicit biasing along water degrees of freedom. In this tutorial, we show how the permutational invariance built into PINES helps us discover solvent-inclusive high-variance CVs. This is challenging using traditional molecular representational techniques because water molecules are indistinguishable, and therefore their identity should not be embedded in the manifold of the system or the CVs. PINES offers a computationally efficient solution to handle this problem using PIV representation that automatically removes translational, rotational, and permutational variances. Below, we walk through each step of applying PINES to discover high-variance CVs and perform enhanced sampling MD simulations to study the free energy landscape of NaCl association or dissociation in water.