## Segmentation-ShoreFor model
### Model description
The Segmentation-ShoreFor model is based on the ShoreFor model proposed by Davidson et al. [[1](https://doi.org/10.1016/j.coastaleng.2012.11.002)] and Splinter et al. [[2](https://doi.org/10.1002/2014JF003106)] and the model free parameters are treated as non-stationary which is related to the wave conditions. 
The model formulation follows:

$$ \frac{d Y}{d t}=\left\{\begin{array}{l}
C^a(t) \cdot F^{+}+b \\
C^e(t) \cdot F^{-}+b
\end{array}\right.$$

Where dY/dt is the rate of shoreline change, dependent on the magnitude of wave forcing F defined as:

$$ F=P^{0.5}((\Omega_\phi-\Omega))⁄\sigma $$

In the model, the free parameters $C^a$ and $C^e$ are no longer considered constant but are treated as non-stationary, varying over time and calculated for each segment. The length of each segment is determined by wave conditions and the availability of shoreline observations within that segment. Ultimately, the shoreline is calculated based on the relationship between $\Omega$ and the time-varying parameters $C^a$ and $C^e$.
### Model implementation
The model was applied to ***Task1.Short-term prediction***, ***Task2.Medium-term prediction***  (P.S.: due to the limitations of the wave-driven equilibrium model, residual wave effects influence the shoreline in the medium-term hindcast. As a result, the hindcast prior to 1975 deviates from the equilibrium position and should be considered for reference or discussion purposes only.)

In the initial stage, the wave climate was analyzed, revealing a seasonal pattern: from January to June, the significant wave height is higher compared to the period from July to December (Figure 1). Therefore, each year was divided into two intervals, "Jan-Jun" and "Jul-Dec," resulting in 40 windows for the 20-year shoreline record. The model was applied to each window to determine the best-fit free parameters and the window-average $\Omega$. To ensure the reliability of these parameters, only windows with at least 8 available observations were considered. The scatter plots between $\Omega$ and $C^a$, $C^e$ at transects 1-9 are shown in Figure 2. The regression slopes between $\Omega$ and $C^a$ at transects 1-6 align with our previous findings at Hasaki Beach, where a positive slope was observed between $\Omega$ and $C^a$. However, due to the limited data availability at this location compared to Hasaki Beach, and the lower statistical confidence in the regression, the median values of $C^a$ and $C^e$ were applied across each transect from 1950 to 2023. The results are presented in Figure 3 (short-term) and Figure 4 (mid-term).

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
[[1](https://doi.org/10.1016/j.coastaleng.2012.11.002)]
Davidson, M.A., Splinter, K.D. and Turner, I.L. (2013), A simple equilibrium model for predicting shoreline change. *Coastal Engineering*, 73, pp.191-202.\
[[2](https://doi.org/10.1016/j.coastaleng.2012.11.002)]
Splinter, K. D., I. L. Turner, M. A. Davidson, P. Barnard, B. Castelle, and J. Oltman-Shay (2014), A generalized equilibrium model for predicting daily to interannual shoreline response, *J. Geophys. Res. Earth Surf*., 119, 1936–1958,