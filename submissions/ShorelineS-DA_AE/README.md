## ShoreFor model
### Model description
ShoreFor is an equilibrium-based cross-shore model first presented in Davidson et al. [[1](https://doi.org/10.1016/j.coastaleng.2012.11.002)]. 
The model formulation used in this work follows the modifications of Splinter et al. [[2](https://doi.org/10.1002/2014JF003106)] allowing for a more general equilibrium model with inter-site variability of model coefficients. 
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


## ShorelineS model + Data Assimilation 
### Model description
ShorelineS is a Shoreline Simulation model first presented in Roelvink et al. [[1](https://doi.org/10.3389/fmars.2020.00535)]. Its description of coastlines is of strings of grid points that can move around, expand and shrink freely. In this work data assimilation framework introduced by Saleh [[2](https://doi.org/10.25831/fm0p-bb25)] is used to calibrate the longshore calibration parameter in the model.
The model formulation follows:

$$ dn/dt = -1/Dc * dQs/ds - RSLR/tan(beta) + 1/Dc * Σ(qi) $$

where n is the cross-shore coordinate, s the longshore coordinate, t is time, Dc is the active profile height, Qs is the longshore transport (m3/yr), tan β is the average profile slope between the dune or barrier crest and the depth of closure, RSLR is the relative sea-level rise (m/yr) and qi is the source/sink term (m3/m/yr) due to cross-shore transport, overwashing, nourishments, sand mining and exchanges with rivers and tidal inlets.

For Qs, we used CERC 3:

$$ QS = Q_cal * b * √g * γ^-0.52 * HS_{br}^{2.5} * (sin(2 * ΔPHIbr) - 2 * cos(ΔPHIbr) * ΔHS)  $$

where Hs_br is the significant wave height at the point of breaking (m), ΔPHIbr is the relative angle of waves at the breaking point, Q_cal is a calibration parameter, γ is the breaker criterion, b is:

$$ b = 1/16 * 0.35 * ρ_w / ((ρ_s - ρ_w) * (1 - p)) $$
  
where ρ_w the density of the water (kg/m3), ρ_s the density of the sediment (kg/m3), and g is the acceleration of gravity (m/s2).
   
### Model implementation
The ShorelineS model + Data assimilation were applied to ***Task1.Short-term prediction***, and ***Task2.Medium-term prediction***. 

### Model classification
#### Model mechanics
- [x] Process-Based Models (PBM): couple hydrodynamics, waves, and morphodynamics through mass and momentum conservation laws.
- [x] Hybrid Models (HM): use observational data to calibrate free parameters in the equilibrium configuration of a system.
- [ ] Data-Driven Models (DDM): use observational data to train regression models (e.g. machine learning, statistical downscaling).
#### Model elements (multiple choices)
- [ ] Cross-shore: model the shoreline position for each transect independently.
- [x] Long-shore: incorporate the interaction of shoreline position across different transects.
- [ ] Sea level: consider the impact of sea level rise on shoreline position.

### References
[[1](https://doi.org/10.3389/fmars.2020.00535)]
Roelvink, D., Huisman, B., Elghandour, A., Ghonim, M. and Reyns, J. (2020), Efficient Modeling of Complex Sandy Coastal Evolution at Monthly to Century Time Scales. *Frontiers in Marine Science*, 7, 535.\
[[2](https://doi.org/10.25831/fm0p-bb25)]
Saleh, M. (2021), The application of Ensemble Kalman Filter: Data assimilation in simple one-line and free-form coastline evolution modelsو *Delft : IHE Delft Institute for Water Education*
