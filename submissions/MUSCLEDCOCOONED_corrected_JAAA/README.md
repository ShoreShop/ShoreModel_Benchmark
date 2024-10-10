## COCOONED model
### Model description
COCOONED (COupled CrOss-shOre, loNg-shorE, and foreDune evolution model) is a hybrid shoreline change model for predicting climate-induced coastal dynamics described in Antolínez et al. 2019 [[1](https://doi.org/10.1029/2018JF004790)]. It models the effect of waves and water level variations on shoreline change due to both longshore and cross-shore processes, including foredune erosion. The model can be applied at several spatial and temporal scales, considering storm events, seasonal, interannual, and decadal variations.

The model governing equation is given by:

$$ \frac{dY}{dt}=-\frac{1}{d} \frac{dQ_{L}}{dx}+K_{C}(Y_{\mathrm{S, eq}}-Y_{S})-\frac{1}{d}(q_x + q_y) $$

where $Y_S$ represents the position of the shoreline; $t$ is time; $Q_L$ is the gradient in longshore sediment transport rate; $x$ represents the alongshore coordinate; $d$ is the depth of closure; $Y_{\mathrm{S, eq}}$ refers to the cross-shore equilibrium position with $K_C$ defining the erosional and accretional rates; $q_x$ represents the alongshore related sediment source; and $q_y$ is the cross-shore related sediment source per unit shoreline and unit time.

Further details on the model and its implementation are given in: [Antolínez et al. (2019)](https://doi.org/10.1029/2018JF004790).

The model was combined with the MUSCLEmorpho input reduction technique as provided in [Antolínez et al. (2016)](https://doi.org/10.1002/2015JC011107).

### Modelers
:man_technologist: [Jose A. A. Antolinez](https://www.tudelft.nl/staff/j.a.a.antolinez/) @ [![Linkedin](https://i.sstatic.net/gVE0j.png) LinkedIn](https://www.linkedin.com/in/jaaantolinez/)
### Contributors
:man_technologist: [Camilo Jaramillo Cardona](https://ihcantabria.com/directorio-personal/camilo-jaramillo/) @ [![Linkedin](https://i.sstatic.net/gVE0j.png) LinkedIn](https://www.linkedin.com/in/camilo-jaramillo-cardona-05b64789/)
:man_technologist: [Lucas de Freitas Pereira](https://ihcantabria.com/directorio-personal/lucas-de-freitas-pereira/) @ [![Linkedin](https://i.sstatic.net/gVE0j.png) LinkedIn](https://www.linkedin.com/in/lucas-de-freitas-pereira-a64a0879/)
:man_technologist: [Jakob C. Christiaanse]
:man_technologist: [Fernando J. Méndez]
### Model implementation
COCOONED was applied to **Task1.Short-term prediction**, **Task2.Medium-term prediction** and **Task3.Long-term prediction**. The model was set-up on the given transects and it was forced with the provided daily wave and water level data as boundary conditions. The predictions submitted were produced with the original python code including longshore and cross-shore terms in the shoreline evolution equation but excluding the foredune erosion equation. The numerical scheme was set to semi-implicit (0.25). The calibration was done as originally through grid search, choosing the best simulation out of 50 different model parameterisations. The MUSCLEmorpho methodology was applied on the (past and future) wave boundary conditions to reduce the daily wave climate into 64 daily wave patterns. This lead to timesteps in the model from 1 day to up to 8 days. The predictions provided here were obtained by bias correction of the predictions in the folder MUSCLEDCOCOONED_JAAA based on the satellite observations in the calibration period.

### Model classification
#### Model mechanics
- [ ] Process-Based Models (PBM): couple hydrodynamics, waves, and morphodynamics through mass and momentum conservation laws.
- [x] Hybrid Models (HM): use observational data to calibrate free parameters in the equilibrium configuration of a system.
- [ ] Data-Driven Models (DDM): use observational data to train regression models (e.g. machine learning, statistical downscaling).
#### Model elements (multiple choices)
- [x] Cross-shore: model the shoreline position for each transect independently.
- [x] Long-shore: incorporate the interaction of shoreline position across different transects.
- [x] Sea level: consider the impact of sea level rise on shoreline position.

### References
[[1](https://doi.org/10.1029/2018JF004790)] Antolínez, J., Méndez, F., Anderson, D., Ruggiero, P., Kaminsky, G. (2019), Predicting Climate-Driven Coastlines With a Simple and Efficient Multiscale Model. *Journal of Geophysical Research: EarthSurface*, 124, 1596-1624.

[[2](https://doi.org/10.1002/2015JC011107)] Antolínez, J., Méndez, P. Camus, S. Vitousek, E. M. González, P. Ruggiero, and P. Barnard (2016), Predicting Climate-Driven Coastlines With a Simple and Efficient Multiscale Model. *Journal of Geophysical Research: Oceans*, 121, 1-16.
