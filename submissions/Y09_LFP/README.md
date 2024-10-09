## Y09 model
### Model description
Y09 is an equilibrium-based shoreline evolution model described in Yates et al. 2009 [[1](https://doi.org/10.1016/j.coastaleng.2021.103983)]. The model is defined by the following equation:

$$ \frac{dS}{dt}=C^{+/-}E^{1/2}(E - E_{eq}) $$

where $S$ represents the position of the shoreline; $t$ is time; $C^+$ and $C^-$ are the accretion and erosion rates respectively; E is the incident waves energy; $E_{eq}$ is the equilibrium wave energy, defined as:

$$ E_{eq} = aS + b $$

where $a$ and $b$ are free parameters.

### Model implementation
Y09 was applied to **Task1.Short-term prediction** and **Task2.Medium-term prediction**. 
The model's calibration was perfomed using the optimization algorithm Borg-MOEA [[2](https://doi.org/10.1162/EVCO_a_00075)], using the ShoreShop 2.0 proposed loss function as objective to minimize. Adittionally, the initial position was considered as an additional parameter as proposed by Castelle et al. 2014 [[3](https://doi.org/10.1016/j.margeo.2013.11.003)].

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
- [ ] Long-shore: incorporate the interaction of shoreline position across different transects.
- [ ] Sea level: consider the impact of sea level rise on shoreline position.

### References
[[1](https://doi.org/10.1029/2009JC005359)] Yates, M., Guza, R., O'Reilly, W. (2009), Equilibrium shoreline response: Observations and modeling, *J. Geophys. Res. Oceans.*\
[[2](https://doi.org/10.1162/EVCO_a_00075)] Hadka, D., Reed, P. (2013), Borg: An Auto-Adaptive Many-Objective Evolutionary Computing Framework. *Evolutionary Computation*, 21, 231-259.\
[[3](https://doi.org/10.1016/j.margeo.2013.11.003)] Castelle, B., Marieu, V., Bujan, S., Ferreira, S., Parisot, J. P., Capo, S., Sénéchal, N., Chouzenoux, T. (2014), Equilibrium shoreline modelling of a high-energy meso-macrotidal multiple-barred beach. *Marine Geology*, 347, 85-94.

