## Nonstationary CoSMoS-COAST model
### Model description
CoSMoS-COAST-Nonstat is based on [CoSMoS-COAST_SV](https://github.com/ShoreShop/ShoreModel_Benchmark/tree/main/submissions/CoSMoS-COAST_SV). 
The only difference is that CoSMoS-COAST-Nonstat uses nonstationary parameters for the cross-shore component by increasing the corresponding parameter process-noise in the data-assimilation process.
The future states of nonstationary parameters are predicted following [[1]( https://doi.org/10.3389/fmars.2022.1012041)].

### Model implementation
The CoSMoS-COAST model was applied to ***Task1.Short-term prediction***, ***Task2.Medium-term prediction***, and ***Task3.Long-term prediction***. 
For all transects togeather, the model parameters were calibrated using wave ($H_s$, $T_p$, $\theta$) and shoreline data from 1999 to 2018 using the littoral-cell-based Ensemble Kalman Filter Algorithm (EnKF).  
For nonstationary parameters for cross-shore sediment transport of the cross-shore component, based on the correlation between calibrated parameters and long-term wave climates, future states were predicted following [[1]( https://doi.org/10.3389/fmars.2022.1012041)].
The model with calibrated stationary parameters and predicted nonstationary parameters was then used to predict shoreline positions from 2019 to 2100.

### Model classification
#### Model mechanics
- [ ] Process-Based Models (PBM): couple hydrodynamics, waves, and morphodynamics through mass and momentum conservation laws.
- [x] Hybrid Models (HM): use observational data to calibrate free parameters in the equilibrium configuration of a system.
- [ ] Data-Driven Models (DDM): use observational data to train regression models (e.g. machine learning, statistical downscaling).
#### Model elements (multiple choices)
- [x] Cross-shore: model the shoreline position for each transect independently.
- [x] Long-shore: incorporate the interaction of shoreline position across different transects.
- [x] Sea level: consider the impact of sea level rise on shoreline position.

### Modelers
:man_technologist: Yongjing Mao (yongjing.mao@unsw.edu.au)

### References
[[1]( https://doi.org/10.3389/fmars.2022.1012041)]
Raimundo, Kristen D. Splinter, Mitchell D. Harley, and Ian L. Turner. "Improving multi-decadal coastal shoreline change predictions by including model parameter non-stationarity." Frontiers in Marine Science 9 (2022): 1012041.

