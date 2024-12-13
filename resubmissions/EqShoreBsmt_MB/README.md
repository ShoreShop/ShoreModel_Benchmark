## Equilibrium shoreline change model with Bruun rule influence
### Resubmission using smoothed shorelines
This model was calibrated using smoothe shoreline positions between 1999 and 2018.

### Model description
Equilibrium shoreline change model with Bruun rule influence (provisionally, **EqShoreB**) is an equilibrium-based cross-shore shoreline change model presented by by Banno et al. (2015). This model is based on the concept of an equilibrium shoreline change model, and the model calculates shoreline changes from disequilibrium between current shoreline position and the equilibrium shoreline position, which is determined uniquely by waves and sea level. The square root of wave energy flux, that is H*T<sup>0.5</sup>, is used as the wave force term.

dy/dt = β<sub>1</sub>E<sub>f</sub><sup>0.5</sup>(y<sub>eq</sub>-y)+ε (1)

where dy/dt = cross-shore shoreline change at a reference level (m/day); β<sub>1</sub> = model parameter; E<sub>f</sub> = offshore wave energy flux (N/s); y<sub>eq</sub> = equilibrium shoreline position (m); y = present shoreline position (m); and ε = residual error (m/day).

The equilibrium shoreline position comprises the basic shoreline position determined by the wave regime and the shoreline change due to the sea level rise based on the Bruun rule (Bruun, 1962):

y<sub>eq</sub> = y<sub>0</sub>+Δy<sub>SLR</sub>   (2)

where y<sub>0</sub> = basic equilibrium shoreline position (m) corresponding to the mean sea level; and Δy<sub>eq</sub> = change in the equilibrium shoreline position from y0 due to a sea level rise (m).

The basic equilibrium shoreline position y<sub>0</sub> is approximated by a linear combination of the root of the wave energy flux to avoid the model becoming too complicated:

y<sub>0</sub> ~ A<sup>-1.5</sup> = W<sub>\*</sub>/h<sub>\*</sub><sup>1.5</sup> ~ (β<sub>3</sub>E<sub>f</sub><sup>0.5</sup>+β<sub>4</sub>)/(β<sub>1</sub>E<sub>f</sub><sup>0.5</sup>+β<sub>2</sub>)   (3)

where A = scale parameter (m<sup>0.33</sup>), h<sub>\*</sub> = wave base (m); and W<sub>*</sub> = seaward distance (m) at the wave base, β<sub>1</sub> to β<sub>4</sub> = model parameters. 
The change in the equilibrium shoreline position due to a sea level rise, which is indicated by the term Δy<sub>SLR</sub>, is based on the Bruun rule. As well as the approximation in Eq. (3), the terms are approximated by a linear combination of the wave energy flux to simplify the model structure.

ΔySLR = (W*S)/(h*+B) - S/tanα ~ (β<sub>5</sub>E<sub>f</sub><sup>0.5</sup>+β<sub>6</sub>)S/(β<sub>1</sub>E<sub>f</sub><sup>0.5</sup>+β<sub>2</sub>)   (4)

where B = berm height (m); S = sea level rise (m); α = foreshore slope; η<sub>ave</sub> = sea level (m); η<sub>ave</sub> = mean sea level (m); and β<sub>1</sub> to β<sub>6</sub> = model parameters.

Long-term uncertainty in the equilibrium shoreline position was considered in the original paper, but it is not evaluated in this testing.

### Model implementation

The EqShoreB was applied to ***Task1.Short-term prediction*** and ***Task3.Long-term prediction***. The input data is waves, water levels, tides and previous shoreline positions. The output data is the shoreline positions. The coefficients were calibrated for each transect. The calculated shoreline positions were calibrated with the measured shoreline positions from 1987 to 2018. The time interval of the calculation is 1 day. The lack of input data was linearly interpolated.

Since the model parameters could not be estimated successfully for some transects, only the results for Transects 5 and 8 are shown for reference.

#### Model mechanics
- [ ] Process-Based Models (PBM): couple hydrodynamics, waves, and morphodynamics through mass and momentum conservation laws.
- [x] Hybrid Models (HM): use observational data to calibrate free parameters in the equilibrium configuration of a system.
- [ ] Data-Driven Models (DDM): use observational data to train regression models (e.g. machine learning, statistical downscaling).
#### Model elements
- [x] Cross-shore: model the shoreline position for each transect independently.
- [ ] Long-shore: incorporate the interaction of shoreline position across different transects.
- [x] Sea level: consider the impact of sea level rise on shoreline position.

### References
[[1]()]
Banno, M., Kuriyama, Y., & Hashimoto, N. (2015). Equilibrium-based foreshore beach profile change model for long-term data. In The proceedings of the coastal sediments 2015.
