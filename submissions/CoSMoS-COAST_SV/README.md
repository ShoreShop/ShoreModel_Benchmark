## CoSMoS-COAST-CONV model
### Model description
CoSMoS-COAST is a large-scale, long-term shoreline model integrating longshore and cross-shore transport, presented in Vitousek et al. 2017 [[1](https://doi.org/10.1002/2016JF004065)], 2021 [[2](https://doi.org/10.1029/2019JF005506)], 2023 [[3](https://doi.org/10.1029/2022JF006936)].  The model presented in this particular submission is standard version of the CoSMoS-COAST model [[4](https://doi.org/10.5066/P95T9188)].

The well-known CoSMoS-COAST model governing equation, which is given by:

$$ \frac{dY}{dt}=-\frac{1}{D_c} \frac{dQ}{dx}+\frac{Y_{\mathrm{eq}}-Y}{\tau}-\frac{c}{\tan\beta}\frac{dS}{dt}+v_{\mathrm{lt}} $$

where $$\frac{dY}{dt}$$ is the rate of change in the shoreline position $$Y$$, and the terms on the right-hand side represent (1) longshore transport, (2) wave-driven cross-shore (after Yates et al., 2009 [[5](https://agupubs.onlinelibrary.wiley.com/doi/pdf/10.1029/2009JC005359)] and Vitousek et al. 2021 [[2](https://doi.org/10.1029/2019JF005506)]), (3) sea-level driven profile recession (i.e., the "Bruun rule"), and (4) a residual (linear) trend, respectively.  See references [[1](https://doi.org/10.1002/2016JF004065)], [[2](https://doi.org/10.1029/2019JF005506)], & [[3](https://doi.org/10.1029/2022JF006936)] for details on each model component.  

### Model implementation
The CoSMoS-COAST model was applied to ***Task1.Short-term prediction***, ***Task2.Medium-term prediction***, and ***Task3.Long-term prediction***. For all transects togeather, the model parameters were calibrated using wave ($H_s$, $T_p$, $\theta$) and smoothed shoreline data from 1940 to 2018 using the littoral-cell-based ensemble Kalman filter algorithm described in [[3](https://doi.org/10.1029/2022JF006936)].  The calibrated model was then used to predict shoreline positions from 2019 to 2100, with given wave conditions.

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
Vitousek, S., Barnard, P. L., Limber, P., Erikson, L., & Cole, B. (2017). A model integrating longshore and cross-shore processes for predicting long-term shoreline response to climate change. Journal of Geophysical Research: Earth Surface, 122(4), 782-806.

[[2]()]
Vitousek, S., Cagigal, L., Montaño, J., Rueda, A., Mendez, F., Coco, G., & Barnard, P. L. (2021). The application of ensemble wave forcing to quantify uncertainty of shoreline change predictions. Journal of Geophysical Research: Earth Surface, 126(7), e2019JF005506.

[[3]()]
Vitousek, S., Vos, K., Splinter, K. D., Erikson, L., & Barnard, P. L. (2023). A model integrating satellite-derived shoreline observations for predicting fine-scale shoreline response to waves and sea-level rise across large coastal regions. Journal of Geophysical Research: Earth Surface, 128(7), e2022JF006936.

[[4]()]
Vitousek, S. (2023). CoSMoS-COAST: The coastal, one-line, assimilated, simulation tool of the coastal storm modeling system. US Geological Survey software release. https://doi.org/10.5066/P95T9188.

[[5]()]
Yates, M. L., Guza, R. T., & O'reilly, W. C. (2009). Equilibrium shoreline response: Observations and modeling. Journal of Geophysical Research: Oceans, 114(C9).
