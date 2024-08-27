## CNN-LSTM model
### Model description
ShoreFor is an equilibrium-based cross-shore model first presented in Davidson et al. [[1](https://doi.org/10.5194/esurf-11-1145-2023)]. 
The model formulation used in this work follows the modifications of Splinter et al.  allowing for a more general equilibrium model with inter-site variability of model coefficients. 
The model formulation follows:

$$ dY/dt=c(F^++r F^- )+b $$

Where dY/dt is the rate of shoreline change, dependent on the magnitude of wave forcing F defined as:

$$ F=P^{0.5}((\Omega_\phi-\Omega))⁄\sigma $$

where P is the breaking wave energy flux and $\Omega$ is the dimensionless fall velocity. 
The model includes two coefficients. The first one, c which is the rate parameter accounting for the efficiency of cross-shore sediment transport and $\phi$ which defines the window width of a filter function, 
performing a weighted average of the antecedent dimensionless fall velocity and is a proxy for the ‘beach memory’. 
The model contains two constants, $r=(\sum{F^+})⁄(\sum{F^-})$ and $\sigma$ which is the standard deviation of $\Omega_\phi-\Omega$, both computed over the calibration segment of the wave data. 
The linear trend parameter, b, has been included to simplistically account for longer-term processes (e.g. longshore sediment transport, sediment supply, etc) not explicitly accounted in the model. 
The model is calibrated by choosing the minimum normalized mean square error (NMSE) of a least-squares regression solving for c, and b for different values of ∅ in the range of 5 to 1000 days.
### Model implementation
The ShoreFor model was applied to ***Task1.Short-term prediction***, ***Task2.Medium-term prediction***, and ***Task3.Long-term prediction***. For each transect, the coefficients for the equilibrium configuration were calibrated using wave ($H_s$ and $T_p$) and shoreline data from 1987 to 2018 with a daily time interval. Subsequently, the calibrated model was employed to predict shoreline positions from 1950 to 2023, maintaining the daily interval and utilizing wave data from the same period. Shoreline projections from 1951 to 1986 and from 2019 to 2023 were categorized as medium-term and short-term predictions, respectively. The medium-term shoreline prediction was adjusted to align with the context value provided for 1951-05-01. These procedures were iteratively applied across all nine transects. For long-term prediction, the model was re-calibrated based on the historical wave data from long-term waves and applied to predict the long-term shoreline data based on the long-term wave forecasts.

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
[[1](https://doi.org/10.5194/esurf-11-1145-2023)]
Gomez-de la Peña, E., Coco, G., Whittaker, C., & Montaño, J. (2023). On the use of convolutional deep learning to predict shoreline change. Earth Surface Dynamics, 11(6), 1145-1160.\

