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
The ShorelineS model + Data assimilation were applied to ***Task1.Short-term prediction***, and ***Task2.Medium-term prediction***. Using the data assimilation (ensemble Kalman filter) considering the data between 1999 to 2018 to and the model to calibrate the longshore sediment transport and the wave direction. The calibrated parameter was then used to predict the short and medium-terms.  

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
