### Model implementation
This folder should contain results generated from a modified application of the ShoreFor model, with target variables adjusted to focus on the parameter \( r_0 \) from the log-spiral formula rather than cross-shore distance. The reconstructed shoreline was derived using the predicted \( r_0 \) values, and time-series data for cross-shore distances were subsequently extracted from nine transects across the full shoreline dataset.

### Model classification
#### Model mechanics
- [ ] Process-Based Models (PBM): couple hydrodynamics, waves, and morphodynamics through mass and momentum conservation laws.
- [x] Hybrid Models (HM): use observational data to calibrate free parameters in the equilibrium configuration of a system.
- [ ] Data-Driven Models (DDM): use observational data to train regression models (e.g. machine learning, statistical downscaling).
#### Model elements (multiple choices)
- [x] Cross-shore: model the shoreline position for each transect independently.
- [ ] Long-shore: incorporate the interaction of shoreline position across different transects.
- [ ] Sea level: consider the impact of sea level rise on shoreline position.

### References
[[1](https://doi.org/10.1016/j.coastaleng.2012.11.002)]  
Davidson, M.A., Splinter, K.D. and Turner, I.L. (2013), A simple equilibrium model for predicting shoreline change. *Coastal Engineering*, 73, pp.191-202.  
[[2](https://doi.org/10.1016/j.coastaleng.2012.11.002)]  
Splinter, K.D., I.L. Turner, M.A. Davidson, P. Barnard, B. Castelle, and J. Oltman-Shay (2014), A generalized equilibrium model for predicting daily to interannual shoreline response, *J. Geophys. Res. Earth Surf.*, 119, 1936–1958.  
[[3](https://doi.org/10.1086/627111)]  
Yasso, W.E. (1965), Plan Geometry of Headland-Bay Beaches. *The Journal of Geology*, 73, pp.702–714.  

