# Scientific-computing

This repo contains exercises for three lectures and one lab course relevant to scientific computing.

## Scientific computing 1:
	
The module introduces the steps of the scientific computing simulation pipeline on selected simulation scenarios, focusing especially on aspects of modelling and discretization:
* classification of mathematical models (discrete/continuous, deterministic/stochastic, etc.);
* discrete models (e.g. Markov chain models)
* modeling with ordinary differential equations for the example of population growth;
* numerical solution of systems of ordinary differential equations;
* modeling with partial differential equations (PDE) for the example of fluid dynamics;
* numerical discretization methods for partial differential equations (finite elements, time stepping, grids and adaptivity);
* limitations and errors encountered in models and discretized models
* adequacy and asymptotic behavior of models (stability, consistency, accuracy, and convergence of numerical methods)


## Scientific computing 2:
* iterative solution of large sparse systems of linear equations:
  * relaxation methods
  * multigrid methods
  * steepest descent
  * conjugate gradient methods
  * preconditioning
* molecular dynamics simulations
  * particle-based modeling (n-body simulation)
  * algorithms for efficient force calculation
  * parallelization
 

## Algorithms for scientific computing:
* Discrete Fourier Transform (DFT) and related transforms:
  * FFT: derivation and implementation
  * Fast discrete cosine/sine transforms: derivation and implementation via FFT
  * Applications: multi-dimensional data (images, video, audio) and FFT-based solvers for linear systems of equations
* Hierarchical numerical methods:
  * Hierarchical bases for one-and multi-dimensional problems
  * Computational cost versus accuracy; Sparse Grids
  * Applications: numerical quadrature, differential equations
  * Outlook: multigrid methods, Wavelets
* Space-filling curves:
  * Peano-and Hilbert curves: representation by algebraic and grammatical means
  * Tree-structured grids (quadtrees, octrees) and relation to space-filling curves
  * Applications: organisation of multi-dimensional data; parallel algorithms and cache oblivious algorithms



## Scientific computing lab
The lab course gives an application oriented introduction to the following topics:

* discrete systems based on simple state transitions (Markov chains)
* explicit and implicit time stepping methods for ordinary differential equations
* numerical methods for stationary and instationary partial differential equations
* solvers for large, sparse systems of linear equations
* adaptivity and adaptively refined discretization grids
* applications from fluid dynamics and heat transfer.
