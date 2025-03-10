## SLRM model
### Model description
The SLRM is based on the horizontal behavior concept of suspended sediment from storms to derive an ordinary differential equation that describes temporal changes in shoreline position (Lim et al. [1][2][3]). The SLRM is also improved the model performance by considering the effect of the wave setup on shoreline changes. The model formulation is described as follows:

$$
\frac{∂y(t)}{∂t} = \frac{∂y_c(t)}{∂t} + \frac{∂y_l(t)}{∂t} = k_r (\frac{E_b}{a_r} -S(t)) + \frac{∂y_l(t)}{∂t}
$$

- $y(t)$ : the shoreline position at time $t$
- $E_b$ : the incident wave energy
- $k_r,a_r$ : the beach recovery and response factors

In addition, the SLRM also takes into account the effect of wave setup, as follows:

$$
y_{total}=y+m_bμH_b
$$

- $H_b$ : the breaking wave height
- $μ$ : the free parameter for the effect of wave setup
- $m_b$ : the beach slope

### Model implementation (Pre ShoreShop 2.0 WorkShop)
The SLRM model was applied to ***Task1.Short-term prediction***, and ***Task2.Medium-term prediction***. The SLRM was implemented by calibrating free parameters ($μ$ and $k_r$) from the provided observation data. *Since the sand grain size was given as one value, we implemented using the unified free parameters for all intersections.* However, the model implementation for each intersection may be differentiated based on beach slope, wave data, etc.

### Model implementation (Post ShoreShop 2.0 WorkShop)
The SLRM model was applied to ***Task1.Short-term prediction***, and ***Task2.Medium-term prediction***. The SLRM was implemented by calibrating free parameters ($μ$ and $k_r$) from the provided observation data. *After the workshop, the model implemented cross-shore evolution using optimal free parameters for each intersection. The model also implemented longshore sediment transport caused by the wave direction.*

Here, shoreline change caused by longshore sediment transport was simulated using a simplified version of the numerical model proposed by Lim et al. [2][3].

### Model classification
#### Model mechanics
- [ ] Process-Based Models (PBM): couple hydrodynamics, waves, and morphodynamics through mass and momentum conservation laws.
- [x] Hybrid Models (HM): use observational data to calibrate free parameters in the equilibrium configuration of a system.
- [ ] Data-Driven Models (DDM): use observational data to train regression models (e.g. machine learning, statistical downscaling).
#### Model elements (multiple choices)
- [x] Cross-shore: model the shoreline position for each transect independently.
- [x] Long-shore: incorporate the interaction of shoreline position across different transects.
- [ ] Sea level: consider the impact of sea level rise on shoreline position.

### Modeller
- Changbin Lim, IHCantabria (art3440@naver.com; limc@unican.es)

### References
[[1](https://doi.org/10.1016/j.geomorph.2022.108409)]
Lim, C., Kim, T.K. and Lee, J.L. (2022). Evolution model of shoreline position on sandy, wave-dominated beaches. *Geomorphology*. 108409.

[[2](https://doi.org/10.3389/fmars.2023.1179598)]
Lim, C. and Lee, J.L. (2023). Derivation of governing equation for short-term shoreline response due to episodic storm
wave incidence: comparative verification in terms of longshore sediment transport. *Front. Mar. Sci.* 10:1179598.

[[3](https://doi.org/10.1016/j.apor.2024.104288)]
Lim, C., González, M. and Lee, J.L. (2024). Estimating cross-shore and longshore sediment transport from shoreline observation data. *Applied Ocean Research*. 104288.
