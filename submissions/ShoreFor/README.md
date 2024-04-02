## ShoreFor model
ShoreFor is an equilibrium-based cross-shore model first presented in Davidson et al. [[1](https://doi.org/10.1016/j.coastaleng.2012.11.002)]. 
The model formulation used in this work follows the modifications of Splinter et al. [[2](https://doi.org/10.1002/2014JF003106)] allowing for a more general equilibrium model with inter-site variability of model coefficients. 
The model formulation follows:

$$ dY/dt=c(F^++r F^- )+b $$

Where dY/dt is the rate of shoreline change, dependent on the magnitude of wave forcing F defined as:

$$ F=P^{0.5}((\Omega_\phi-\Omega))⁄\sigma $$

where P is the breaking wave energy flux and $\Omega$ is the dimensionless fall velocity. 
The model includes two coefficients. The first one, c which is the rate parameter accounting for the efficiency of cross-shore sediment transport and $\phi$ which defines the window width of a filter function, 
performing a weighted average of the antecedent dimensionless fall velocity and is a proxy for the ‘beach memory’. 
The model contains two constants, $r=(\sum{F^+})⁄(\sum{F^-})$ and $\sigma$ which is the standard deviation of $\Omega_\phi-\Omega$  , both computed over the calibration segment of the wave data. 
The linear trend parameter, b, has been included to simplistically account for longer-term processes (e.g. longshore sediment transport, sediment supply, etc) not explicitly accounted in the model. 
The model is calibrated by choosing the minimum normalized mean square error (NMSE) of a least-squares regression solving for c, and b for different values of ∅ in the range of 5 to 1000 days.
### References
[[1](https://doi.org/10.1016/j.coastaleng.2012.11.002)]
Davidson, M.A., Splinter, K.D. and Turner, I.L. (2013), A simple equilibrium model for predicting shoreline change. *Coastal Engineering*, 73, pp.191-202.\
[[2](https://doi.org/10.1016/j.coastaleng.2012.11.002)]
Splinter, K. D., I. L. Turner, M. A. Davidson, P. Barnard, B. Castelle, and J. Oltman-Shay (2014), A generalized equilibrium model for predicting daily to interannual shoreline response, *J. Geophys. Res. Earth Surf*., 119, 1936–1958,
