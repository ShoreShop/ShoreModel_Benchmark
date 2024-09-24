## CoSMoS-COAST-CONV model
### Model description
CoSMoS-COAST is a large-scale, long-term shoreline model integrating longshore and cross-shore transport, presented in Vitousek et al. 2017 [[1](https://doi.org/10.1002/2016JF004065)], 2021 [[2](https://doi.org/10.1029/2019JF005506)], [[3](https://doi.org/10.1029/2022JF006936)].  The model presented in this submission (COSMOS-COAST-CONV) is an experimental/lite version of the full CoSMoS-COAST model that heavily uses discrete convolution operations. The code of this experimental model is included with the submission.

The CoSMoS-COAST model governing equation is:

$$ \frac{dY}{dt}=-\frac{1}/{D_c} \frac{dQ}{dx}+ (Y_{eq}-Y)/\tau-c/\tan\Beta \frac{dS}{dt}+v_{lt} $$

where $$ \frac{dY}{dt}$$ is the rate of change in the shoreline position $Y$$$.

The current, experimental model is calibrated using a constrained optimization routine (and not the ensemble Kalman filter method of the published model).  The optimization method minimizes the loss function given in the ShoreShop instructions.  Based on the smoothed shoreline data provided, the model obtains a respectable RMS error of ~5.7 m across all transects during the calibration period.  The manner in which the numerical method of the experimental model uses discrete convolution operations will be described in an upcoming manuscript.

### Model implementation
The CoSMoS-COAST model was applied to ***Task1.Short-term prediction***, ***Task2.Medium-term prediction***, and ***Task3.Long-term prediction***. For each transects individually, the model parameters were calibrated using wave ($H_s$, $T_p$, $\theta$) and smoothed shoreline data from 1940 to 2018 with a daily time step.  The calibrated model was then used to predict shoreline positions from 1950 to 2100.  

### Model classification
#### Model mechanics
- [ ] Physics-Based Models (PBM): couple hydrodynamics, waves, and morphodynamics through mass and momentum conservation laws.
- [x] Hybrid Models (HM): use observational data to calibrate free parameters in the equilibrium configuration of a system.
- [ ] Data-Driven Models (DDM): use observational data to train regression models (e.g. machine learning, statistical downscaling).
#### Model elements 
- [x] Cross-shore: model the shoreline position for each transect independently.
- [x] Long-shore: incorporate the interaction of shoreline position across different transects.
- [x] Sea level: consider the impact of sea level rise on shoreline position.

### References
[[1]()]
Vitousek, S., Barnard, P. L., Limber, P., Erikson, L., & Cole, B. (2017). A model integrating longshore and cross-shore processes for predicting long-term shoreline response to climate change. Journal of Geophysical Research: Earth Surface, 122(4), 782-806.

[[2]()]
Vitousek, S., Cagigal, L., Montaño, J., Rueda, A., Mendez, F., Coco, G., & Barnard, P. L. (2021). The application of ensemble wave forcing to quantify uncertainty of shoreline change predictions. Journal of Geophysical Research: Earth Surface, 126(7), e2019JF005506.

[[3]()]
Vitousek, S., Vos, K., Splinter, K. D., Erikson, L., & Barnard, P. L. (2023). A model integrating satellite-derived shoreline observations for predicting fine-scale shoreline response to waves and sea-level rise across large coastal regions. Journal of Geophysical Research: Earth Surface, 128(7), e2022JF006936.

[[4]()]
Vitousek, S. (2023). CoSMoS-COAST: The coastal, one-line, assimilated, simulation tool of the coastal storm modeling system. US Geological Survey software release. https://doi. org/10.5066/P95T9188.

