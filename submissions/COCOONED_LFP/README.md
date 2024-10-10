## COCOONED model
### Model description
COCOONED (COupled CrOss-shOre, loNg-shorE, and foreDune evolution model) is a hybrid shoreline change model for predicting climate-induced coastal dynamics described in Antolínez et al. 2019 [[1](https://doi.org/10.1029/2018JF004790)]. It integrates both longshore and cross-shore processes, taking into account the effects of foredune erosion, wave action, and water level variations. The model operates at multiple spatial and temporal scales, considering storm events, seasonal, interannual, and decadal variations.

The model governing equation is given by:

$$ \frac{dY}{dt}=-\frac{1}{d} \frac{dQ_{L}}{dx}+K_{C}(Y_{\mathrm{S, eq}}-Y_{S})-\frac{1}{d}(q_x + q_y) $$

where $Y_S$ represents the position of the shoreline; $t$ is time; $Q_L$ is the gradient in longshore sediment transport rate; $x$ represents the alongshore coordinate; $d$ is the depth of closure; $Y_{\mathrm{S, eq}}$ refers to the cross-shore equilibrium position with $K_C$ defining the erosional and accretional rates; $q_x$ represents the alongshore related sediment source; and $q_y$ is the cross-shore related sediment source per unit shoreline and unit time.

For more detailed methodology and case study applications, refer to the paper: [Antolínez et al. (2019)](https://doi.org/10.1029/2018JF004790).

### Model implementation
COCOONED was applied to **Task1.Short-term prediction**, **Task2.Medium-term prediction** and **Task3.Long-term prediction**. The model used global wave and water level data as boundary conditions to simulate shoreline position along multiple transects. The predictions considered longshore sediment transport, cross-shore processes and sea level rise. 

The version of COCOONED applied in this submission was implemented in Julia from the original code, using an explicit fourth-order Runge-Kutta scheme to improve model performance. In addition, the parameters of the cross-shore module were calibrated individually for each transect due to the interaction between corss-shore and longshore transport. The model's calibration was perfomed using the optimization algorithm Borg-MOEA [[2](https://doi.org/10.1162/EVCO_a_00075)], using the ShoreShop 2.0 proposed loss function as objective to minimize.

### Modeler
:man_technologist: [Lucas de Freitas Pereira](https://ihcantabria.com/directorio-personal/lucas-de-freitas-pereira/) @ [![Linkedin](https://i.sstatic.net/gVE0j.png) LinkedIn](https://www.linkedin.com/in/lucas-de-freitas-pereira-a64a0879/)
### Contributors
:man_technologist: [Camilo Jaramillo Cardona](https://ihcantabria.com/directorio-personal/camilo-jaramillo/) @ [![Linkedin](https://i.sstatic.net/gVE0j.png) LinkedIn](https://www.linkedin.com/in/camilo-jaramillo-cardona-05b64789/)
:man_technologist: [Jose A. A. Antolinez](https://www.tudelft.nl/staff/j.a.a.antolinez/) @ [![Linkedin](https://i.sstatic.net/gVE0j.png) LinkedIn](https://www.linkedin.com/in/jaaantolinez/)

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
[[1](https://doi.org/10.1029/2018JF004790)] Antolínez, J., Méndez, F., Anderson, D., Ruggiero, P., Kaminsky, G. (2019), Predicting Climate-Driven Coastlines With a Simple and Efficient Multiscale Model. *Journal of Geophysical Research: EarthSurface*, 124, 1596-1624.\
[[2](https://doi.org/10.1162/EVCO_a_00075)] Hadka, D., Reed, P. (2013), Borg: An Auto-Adaptive Many-Objective Evolutionary Computing Framework. *Evolutionary Computation*, 21, 231-259.