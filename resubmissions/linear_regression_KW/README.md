## Linear Regression model
### Model description
This is a simple linear regression model with independent terms, fit using the linregress tool from scipy.stats [1].

The model formulation follows:

$$ Y_{i(t)}= \beta_{0,i} + \beta_{1,i} NINO3.4_{(t)} +\beta_{2,i} DMI_{(t)} +\beta_{3,i} H_{S,150,i(t)}$$

Where Yi(t) is the shoreline position at transect i, time t, NINO3.4 is the climate index describing changes in the El Niño Southern Oscillation (ENSO), DMI is the climate index describing changes in the Indian Ocean Dipole (IOD) and H_S,150,i(t) is the monthly 150-day rolling mean of nearshore significant wave height at transect i.

The model includes three coefficients for the parameters and one constant for an intercept, which are found using ordinary least squares (OLS)

The linear regression model was applied to ***Task1.Short-term prediction***, ***Task2.Medium-term prediction***, and ***Task3.Long-term prediction***, with a linear regression model for each transect.

### Model classification
#### Model mechanics
- [ ] Process-Based Models (PBM): couple hydrodynamics, waves, and morphodynamics through mass and momentum conservation laws.
- [ ] Hybrid Models (HM): use observational data to calibrate free parameters in the equilibrium configuration of a system.
- [x] Data-Driven Models (DDM): use observational data to train regression models (e.g. machine learning, statistical downscaling).
#### Model elements (multiple choices)
- [x] Cross-shore: model the shoreline position for each transect independently.
- [ ] Long-shore: incorporate the interaction of shoreline position across different transects.
- [ ] Sea level: consider the impact of sea level rise on shoreline position.

### References
[[1](https://doi.org/10.1038/s41592-019-0686-2)]
Pauli Virtanen, Ralf Gommers, Travis E. Oliphant, Matt Haberland, Tyler Reddy, David Cournapeau, Evgeni Burovski, Pearu Peterson, Warren Weckesser, Jonathan Bright, Stéfan J. van der Walt, Matthew Brett, Joshua Wilson, K. Jarrod Millman, Nikolay Mayorov, Andrew R. J. Nelson, Eric Jones, Robert Kern, Eric Larson, CJ Carey, İlhan Polat, Yu Feng, Eric W. Moore, Jake VanderPlas, Denis Laxalde, Josef Perktold, Robert Cimrman, Ian Henriksen, E.A. Quintero, Charles R Harris, Anne M. Archibald, Antônio H. Ribeiro, Fabian Pedregosa, Paul van Mulbregt, and SciPy 1.0 Contributors. (2020) SciPy 1.0: Fundamental Algorithms for Scientific Computing in Python. Nature Methods, 17(3), 261-272. 
