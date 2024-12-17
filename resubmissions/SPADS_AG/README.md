Contributors: Amirmahdi Gohari, Giovanni Coco, Karin Bryan

## SPADS model

### Model description
The Shoreline Prediction at Different Timescales (SPADS) model is a data-driven approach designed to predict shoreline changes more accurately across various temporal scales. Developed by (Montaño et al., 2021), SPADS is based on the Complete Ensemble Empirical Mode Decomposition (CEEMD) method (Huang et al., 1998). This model aims to improve the simulation of shoreline dynamics by addressing the shortcomings of traditional process-based models, which often struggle with short-term oscillations. SPADS utilizes CEEMD to identify the main timescales at which drivers and changes in shoreline position are most relevant, focusing on those that exhibit the greatest correlation. This approach allows for a comprehensive analysis of shoreline behaviour across different temporal scales.


### Model implementation
The SPADS model was trained using the available shoreline dataset spanning from 1999 to 2018. A smoothing method (Garcia, 2010) is applied on the satellite data to reduce noises and therefore enhance the accuracy of the data and making it more reliable for analysing trends and patterns over time. This smoothing method uses a penalized least squares approach with the discrete cosine transform for efficient data handling and automatically selects the optimal smoothing level by minimizing the generalized cross-validation score.
The training phase allowed the model to learn the relationships between input wave parameters (significant wave height, peak period, and wave direction) and the output (shoreline position). Following the training, the model was used to forecast shoreline positions for the short term future period (2019-2023) at a daily time step for each of the targeted transects (2, 5, 8).

### Model classification
- [ ] Process-Based Models (PBM): couple hydrodynamics, waves, and morphodynamics through mass and momentum conservation laws.
- [ ] Hybrid Models (HM): use observational data to calibrate free parameters in the equilibrium configuration of a system.
- [x] Data-Driven Models (DDM): use observational data to train regression models (e.g. machine learning, statistical downscaling).
#### Model elements (multiple choices)
- [x] Cross-shore: model the shoreline position for each transect independently.
- [ ] Long-shore: incorporate the interaction of shoreline position across different transects.
- [ ] Sea level: consider the impact of sea level rise on shoreline position.

### References
Huang, N.E. et al. (1998) ‘The empirical mode decomposition and the Hilbert spectrum for nonlinear and non-stationary time series analysis’, Proceedings of the Royal Society of London. Series A: Mathematical, Physical and Engineering Sciences, 454(1971), pp. 903–995. Available at: https://doi.org/10.1098/rspa.1998.0193.

Montaño, J. et al. (2021) ‘A Multiscale Approach to Shoreline Prediction’, Geophysical Research Letters, 48(1). Available at: https://doi.org/10.1029/2020GL090587.

Garcia, D. (2010). Robust smoothing of gridded data in one and higher dimensions with missing values. Computational Statistics and Data Analysis, 54(4). https://doi.org/10.1016/j.csda.2009.09.020
 
