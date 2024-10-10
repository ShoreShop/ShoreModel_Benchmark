## ShorelineEVOL model

### Model description
ShorelineEVOL [1] is a hybrid model that couples an equilibrium-based sub-model of cross-shore shoreline change [2] and a sub-model of longshore processes based on one-line (CERC) approach. It includes the: 1) Bruun Rule to simulate shoreline response to sea-level rise, 2) the additional sediment demand from coastlines adjacent to estuaries created when sea-level rise increases accommodation space in the estuary ([3], [4]), and 3) the effect of hard engineering structures such as seawalls and groynes/breakwaters on cross-shore and longshore sediment transport ([5],[6]).
The model simulates the shoreline position and is forced by wave parameters (significant wave height, peak wave period, wave direction) and water levels (astronomical tide, storm surge, sea level).

### Model implementation
The ShorelineEVOL model was applied to ***Task1.Short-term prediction***, ***Task2.Medium-term prediction***, and ***Task3.Long-term prediction***. The model coefficients (ka, ke, K, dyeq) were calibrated using the provided wave parameters (Hs, Tp, Dir), water levels (tide and SL) and shoreline data from 1999 to 2018 along with the shoreline position in 1951-05-01. The model was calibrated using the Dynamically Dimensioned Search (DDS) [7].
Subsequently, the calibrated model was employed to predict shoreline positions from 1951 to 2100. Shoreline projections from 2019 to 2023, from 1951 to 1998 and from 2019 to 2100 were categorized as short-term, medium-term and long-term predictions, respectively. 

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
[1] de Santiago, I., Camus, P., Gonzalez, M., Liria, P., Epelde, I., Chust, G., ... & Uriarte, A. (2021). Impact of climate change on beach erosion in the Basque Coast (NE Spain). Coastal Engineering, 167, 103916.
https://doi.org/10.1016/j.coastaleng.2021.103916
[2] Toimil, A., Losada, I. J., Camus, P., & Díaz-Simal, P. (2017). Managing coastal erosion under climate change at the regional scale. Coastal Engineering, 128, 106-122.
https://doi.org/10.1016/j.coastaleng.2017.08.004
[3] Stive, M. J., & Wang, Z. B. (2003). Morphodynamic modeling of tidal basins and coastal inlets. In Elsevier oceanography series (Vol. 67, pp. 367-392). Elsevier.
https://doi.org/10.1016/S0422-9894(03)80130-7
[4] Ranasinghe, R., Duong, T. M., Uhlenbrook, S., Roelvink, D., & Stive, M. (2013). Climate-change impact assessment for inlet-interrupted coastlines. Nature Climate Change, 3(1), 83-87.
https://doi.org/10.1038/nclimate1664
[5] Hanson, H., & Kraus, N. C. (1986). Seawall boundary condition in numerical models of shoreline evolution.
[6] Kraus, N. C., Hanson, H., & Blomgren, S. H. (1995). Modern functional design of groin systems. In Coastal Engineering 1994 (pp. 1327-1342).
https://doi.org/10.1061/9780784400890.097
[7] Tolson, B. A., & Shoemaker, C. A. (2007). Dynamically dimensioned search algorithm for computationally efficient watershed model calibration. Water Resources Research, 43(1).
https://doi.org/10.1029/2005WR004723

