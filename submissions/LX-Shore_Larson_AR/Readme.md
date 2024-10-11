## LX-Shore model with use of the formula of Larson for the wave module

Contributors : Arthur Robinet (a.robinet@brgm.fr), Clément Bouvier (c.bouvier@brgm.fr), Déborah Idier (d.idier@brgm.fr), Bruno Castelle (bruno.castelle@u-bordeaux.fr)

### Model description
LX-Shore is a two-dimensional plan-view cellular-based one-line shoreline change model for wave-dominated sandy coasts presented first in Robinet *et al.* [[1](https://doi.org/10.1016/j.envsoft.2018.08.010),[2](https://doi.org/10.1016/j.margeo.2020.106118)]. The model framework consists in a 2D plan-view grid where each cell is filled with a fractional amount of sediment (F). A cell with a sediment fraction F = 1 (0) is fully dry (subaqueous). Shoreline cells are cells with 0 < F =< 1 and having a contact with at least one water cell (F = 0). The shoreline is obtained using an interface reconstruction method applied to the line of shoreline cells. At each time step, the sediment fraction in each shoreline cell is adjusted according to the balance between incoming and leaving sediment fluxes.

The model can simulate shoreline change resulting from gradients in total longshore sediment transport and/or from cross-shore transport driven by the variability in incident wave energy. Several longshore sediment flux formulations are implemented in LX-Shore, including the formula of Kamphuis [[3](https://doi.org/10.1061/(ASCE)0733-950X(1991)117:6(624))]. The cross-shore transport is resolved using an adaptation of the ShoreFor model [[4](https://doi.org/10.1016/j.coastaleng.2012.11.002),[5](https://doi.org/10.1002/2014JF003106)] where the disequilibrium term is computed from offshore wave conditions instead of breaking wave conditions. In addition, waves are fully coupled with the shoreline changes and computed using either the SWAN spectral wave model [[6](https://doi.org/10.1029/98JC02622)], or the formula of Larson *et al.* [[7](https://doi.org/10.1061/(ASCE)WW.1943-5460.0000030)].

LX-Shore can handle complex shoreline geometries (e.g. sand spits, islands), including non-erodible areas such as coastal defences and headlands. 

### Model implementation
The LX-Shore model was applied to ***Task1.Short-term prediction*** and ***Task2.Medium-term prediction*** with the use of the formula of Larson for the wave module. Both longshore and cross-shore sediment transport modules were switched on for ***Task1.Short-term prediction***. Only the longshore sediment transport module was switched on for ***Task2.Medium-term prediction*** as inclusion of the cross-shore sediment transport strongly decreased the skill of the modelling. 

The size of the square cells composing the morphological grid over which the sediment fraction is computed was set to 50 m. The geometries of the two headlands that bound the beach were included to initialise the amount of non-erodible sediment fraction present in each cell of the morphological grid. The headland geometries have certainly been strongly idealised as only a few indications have been provided about their location, orientation, cross-shore and longshore extension. 

Time series of 10-m-depth wave conditions given at each transect were averaged together to generate single time series of longshore-averaged Hs, Dp and Tp that were used as LX-Shore inputs. Time series of wave conditions provided with a daily time step were linearly interpolated with a hourly time step and the few wave conditions with NaN values were replaced also by linear interpolation. To account for the existence of a possible directional spreading of the waves, a +/- 30 ° Gaussian random perturbation was added at each time step of the interpolated time series of Dp. 

The simulation time step was set to 1 h, which is equal to the time step used for interpolation of time series of wave conditions.

The longshore sediment transport was computed using the formula of Kamphuis [[2](https://doi.org/10.1061/(ASCE)0733-950X(1991)117:6(624))] with a calibration multiplication factor (fql) set to 3 in order to minimize the loss function at transect no. 8 over the calibration period (1999-2018).

The cross-shore transport is resolved using an adaptation of the ShoreFor model [[3](https://doi.org/10.1016/j.coastaleng.2012.11.002),[4](https://doi.org/10.1002/2014JF003106)] where the disequilibrium term is computed from the 10 m depth wave conditions instead of breaking wave conditions. The forcing terms in LX-Shore is computed with the alongshore-variable breaking wave conditions computed along the simulated shoreline. The three ShoreFor free parameters (φ, c and b) were optimized using a simulated annealing procedure minimizing the RMSE on the spatial average of the demeaned rotation-free time series of shoreline positions at transects no. 2, 3, 4 and 5 over the calibration period (1999-2018). The rotation-free time series of shoreline positions were obtained by removing from the observed time series of shorelines position the rotation signal that LX-Shore was able to simulate. A preliminary LX-Shore simulation, in which only the longshore transport was switched on, was therefore required to generate this rotation signal at the transects.

Overall, only four calibration parameters (fql, φ, c and b) were tuned to simulate shoreline change along the entire embayment.

With LX-Shore, the simulated mean planshape can deviate from the observed mean planshape [[2](https://doi.org/10.1061/(ASCE)0733-950X(1991)117:6(624))], which potentially results from approximations in the resolution of some physical processes (e.g. over-simplification of the wave transformations, alongshore-uniform beach profile shape). To balance this behaviour, simulated cross-shore shoreline positions were post-processed in two steps. First, the simulated mean planshape was subtracted to all simulated shorelines in order to extract the simulated shoreline variability about the mean. Second, the observed mean planshape was added to the demeaned simulated shorelines in order to compute the simulated shoreline variability about the observed mean, allowing then the comparison between simulated and observed shoreline positions.

### Model classification
#### Model mechanics
- [ ] Process-Based Models (PBM): couple hydrodynamics, waves, and morphodynamics through mass and momentum conservation laws.
- [x] Hybrid Models (HM): use observational data to calibrate free parameters in the equilibrium configuration of a system.
- [ ] Data-Driven Models (DDM): use observational data to train regression models (e.g. machine learning, statistical downscaling).
#### Model elements (multiple choices)
- [x] Cross-shore: model the shoreline position for each transect independently.
- [x] Long-shore: incorporate the interaction of shoreline position across different transects.
- [ ] Sea level: consider the impact of sea level rise on shoreline position.

### References
[[1](https://doi.org/10.1016/j.envsoft.2018.08.010)]  Robinet, A.; Idier, D.; Castelle, B.; Marieu, V. A Reduced-Complexity Shoreline Change Model Combining Longshore and Cross-Shore Processes: The LX-Shore Model. _Environmental Modelling & Software_ **2018**, _109_, 1–16.

[[2](https://doi.org/10.1016/j.margeo.2020.106118)] Robinet, A.; Castelle, B.; Idier, D.; Harley, M.D.; Splinter, K.D. Controls of Local Geology and Cross-Shore/Longshore Processes on Embayed Beach Shoreline Variability. _Marine Geology_ **2020**, _422_, 106118.

[[3](https://doi.org/10.1061/(ASCE)0733-950X(1991)117:6(624))] Kamphuis, J.W. Alongshore Sediment Transport Rate. _Journal of Waterway, Port, Coastal, and Ocean Engineering_ **1991**, _117_, 624–640.

[[4](https://doi.org/10.1016/j.coastaleng.2012.11.002)] Davidson, M.A.; Splinter, K.D.; Turner, I.L. A Simple Equilibrium Model for Predicting Shoreline Change. _Coastal Engineering_ **2013**, _73_, 191–202.

[[5](https://doi.org/10.1002/2014JF003106)] Splinter, K.D.; Turner, I.L.; Davidson, M.A.; Barnard, P.; Castelle, B.; Oltman-Shay, J. A Generalized Equilibrium Model for Predicting Daily to Interannual Shoreline Response. _Journal of Geophysical Research: Earth Surface_ **2014**, _119_, 1936–1958.

[[6](https://doi.org/10.1029/98JC02622)] Booij, N.; Ris, R.C.; Holthuijsen, L.H. A Third-Generation Wave Model for Coastal Regions: 1. Model Description and Validation. _Journal of Geophysical Research: Oceans_ **1999**, _104_, 7649–7666.

[[7](https://doi.org/10.1061/(ASCE)WW.1943-5460.0000030)] Larson, M.; Hoan, L.X.; Hanson, H. Direct Formula to Compute Wave Height and Angle at Incipient Breaking. _Journal of Waterway, Port, Coastal, and Ocean Engineering_ **2010**, _136_, 119–122.
