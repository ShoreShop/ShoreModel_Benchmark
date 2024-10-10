## SLRM model
### Model description
The SLRM is based on the horizontal behavior concept of suspended sediment from storms to derive an ordinary differential equation that describes temporal changes in shoreline position (Lim et al. [1]). The SLRM is also improved the model performance by considering the effect of the wave setup on shoreline changes. The model formulation is described as follows:

$$
\frac{∂S(t)}{∂t}=k_r (\frac{E_b}{a_r} -S(t))
$$

- $S(t)$ : the shoreline position at time $t$
- $E_b$ : the incident wave energy
- $k_r,a_r$ : the beach recovery and response factors

In addition, the SLRM also takes into account the effect of wave setup, as follows:

$$
S_{total}=S+m_bμH_b
$$

- $H_b$ : the breaking wave height
- $μ$ : the free parameter for the effect of wave setup
- $m_b$ : the beach slope

### Model implementation
The SLRM model was applied to ***Task1.Short-term prediction***, and ***Task2.Medium-term prediction***. The SLRM was implemented by calibrating free parameters ($μ$ and $k_r$) from the provided observation data. Since the sand grain size was given as one value, we implemented using the unified free parameters for all intersections. However, the model implementation for each intersection may be differentiated based on beach slope, wave data, etc.

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
[[1](https://doi.org/10.1016/j.geomorph.2022.108409)]
Lim, C., Kim, T.K. and Lee, J.L. (2022). Evolution model of shoreline position on sandy, wave-dominated beaches. *Geomorphology*. 108409.
