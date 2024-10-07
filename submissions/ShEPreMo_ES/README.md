## Shoreline Evolution Prediction Model (ShEPreMo)
### Model description

ShEPreMo [1,2], a modified version of ShoreFor [3,4], integrates process-based longhore sediment transport and shoreline migration due to water level fluctuations in addition to cross-shore sediment transport. This is achieved by substituting the linear $b$ term in ShoreFor with these processes. The rate of shoreline position change, $dx/dt$, is given by

$$ \underbrace{\frac{dx}{dt}}_{\text{1}}= \underbrace{a(F^+ rF^-)}_{\text{2}}-\underbrace{\frac{b}{h_c}\frac{\partial Q}{\partial y}}_{(3)}-\underbrace{\frac{c}{tan \beta}\frac{\partial S}{\partial t}}_{(4)}+\underbrace{d}_{(5)} $$

where $x$ represents the position of shoreline, $t$ is time. The terms (1), (2), (3), (4), and (5) represent the rate of shoreline change, cross-shore sediment transport, longshore sediment transport, shoreline migration due to water level fluctuations, and unresolved processes, respectively. a, b, c, and d are calibration coefficients.


### Model implementation
ShEPreMo was applied to ***Task1.Short-term prediction***, ***Task2.Medium-term prediction***, and ***Task3.Long-term prediction***. For all transects, the model coefficients were calibrated independently using breaking wave characteristics ($H_{sb}$, $T_p$, $\theta_{b}$) and smoothed historical shoreline data from 1999 to 2018 using gaussian smoothing. The calibrated model was then used to predict short-term (from 2019-01-01 to 2023-12-31), medium term (from 1951-05-01 to 1998-12-31), and longterm (2019-01-01 to 2100-12-31) shoreline positions with daily timestep.

### Model classification
#### Model mechanics
- [ ] Physics-Based Models (PBM): couple hydrodynamics, waves, and morphodynamics through mass and momentum conservation laws.
- [x] Hybrid Models (HM): use observational data to calibrate free parameters in the equilibrium configuration of a system.
- [ ] Data-Driven Models (DDM): use observational data to train regression models (e.g. machine learning, statistical downscaling).
#### Model elements 
- [x] Cross-shore: model the shoreline position for each transect independently.
- [x] Long-shore: incorporate the interaction of shoreline position across different transects.
- [x] Sea level: consider the impact of sea level rise on shoreline position.
- [x] Linear trend: consider the impact a residual linear trend on shoreline position.

### References
[[1]()]
Sogut, E., Aretxabaleta, A., Ashton, A. D., Barnhardt, W. A., Doran, K. S., Sherwood, C. R., Palmsten, M. L., & Vitousek, S. (2023, December). Monitoring and predicting shoreline response to waves and interannual water-level variability in the Great Lakes. In AGU Fall Meeting Abstracts (Vol. 2023, No. 2431, pp. EP43C-2431).

[[2]()]
Sogut, E., Aretxabaleta, A., Ashton, A. D., Barnhardt, W. A., Doran, K. S., Sherwood, C. R., Palmsten, M. L., & Vitousek, S. (2024, February). Shoreline response to ice-cover altered hydrodynamics of Lake Superior. In 2024 Ocean Sciences Meeting. AGU.

[[3]()]
Davidson, M. A., Splinter, K. D., & Turner, I. L. (2013). A simple equilibrium model for predicting shoreline change. Coastal Engineering, 73, 191-202.

[[4]()]
Splinter, K. D., Turner, I. L., Davidson, M. A., Barnard, P., Castelle, B., & Oltman‐Shay, J. (2014). A generalized equilibrium model for predicting daily to interannual shoreline response. Journal of Geophysical Research: Earth Surface, 119(9), 1936-1958.
