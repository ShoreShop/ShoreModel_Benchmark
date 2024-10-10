## Model description

[](https://github.com/ShoreShop/ShoreModel_Benchmark/blob/main/submissions/ShoreFor/README.md#model-description)

A combination of two lodels has been implemented in the present exercise. Namely the ShoreFor model proposed by Davidson et al. [[1](https://doi.org/10.1016/j.coastaleng.2012.11.002)], was used to simulated Cross shore transport processes and the rotation model proposed by Jaramillo et al. [[2](https://doi.org/10.1016/j.coastaleng.2020.103789)] to account for the rotation of the embayed beach. Both models are described below as well as the methodology applied for their calibration.

### ShoreFor model

In ShoreFor the shoreline displacement is defined as a function of the nearshore wave power and a disequilibrium state of the beach. In the approach of Davidson et al. [[1](https://doi.org/10.1016/j.coastaleng.2012.11.002)] adopted in the present work, the rate of shoreline change $dx/dt$ (m/s) is defined as:

$\frac{dx}{dt} = c^{\pm} P^{0.5} (\Omega_{eq} - \Omega)$

Where $\frac{dx}{dt}$ is the rate of shoreline change, dependent on the magnitude of the wave forcing P is the breaking wave energy flux and  Ω  is the dimensionless fall velocity. The model includes two coefficients. The first one, c which is the rate parameter accounting for the efficiency of cross-shore sediment transport and  ϕ  which defines the window width of a filter function, performing a weighted average of the antecedent dimensionless fall velocity and is a proxy for the ‘beach memory’.  The model is calibrated by choosing the minimum root mean square error (RMSE) of a least-squares regression solving for $ c^{\pm} $ for different values of ∅ in the range of 5 to 2000 days.

An additional parameter has been $dx_0$ has been used to account
In the present work the empirical equilibrium shoreline model ShoreFor developed by Davidson et al. [[1](https://doi.org/10.1016/j.coastaleng.2012.11.002)]. was used to simulate shoreline evolution. In ShoreFor the shoreline displacement is defined as a function of the nearshore wave power and a disequilibrium state of the beach. In the approach o f Davidson et al. [[1](https://doi.org/10.1016/j.coastaleng.2012.11.002)] the rate of shoreline change $dx/dt$ (m/s) is defined as:

$\frac{dx}{dt} = c^{\pm} P^{0.5} (\Omega_{eq} - \Omega)$

where the model's forcing term is the product of the incident wave power $P$ (W) computed using linear wave theory, and the model free parameter $c^{\pm}$ representing the response rate of the shoreline with units of velocity per measure incident wave power. The parameter $c^{\pm}$ is separated into accretion $c^{+}$ when $\Omega_{eq} > \Omega$ and erosion $c^{-}$ when $\Omega_{eq} < \Omega$ components, accounting for the fact that accretion and erosion are observed to evolve at different rates. \cite{Davidson2013} included a term $b$ in their formulation accounting for linear trends stemming from longer term processes that are not explicitly addressed in the model. In the present work this term is disregarded due to the relatively small trend calculated from the SDS data. The term inside the parenthesis in equation \ref{eq:ShoreFor} is a disequilibrium term which is based on the premise that shoreline state and morphological change are inter-related. $\Omega$ is the so called dimensionless fall velocity defined as:

$\Omega = \frac{H_s}{T_p w_s}$

where $H_s$ and $T_p$ are the instantaneous significant wave height and peak wave period respectively and $w_s$ is the terminal fall velocity of the beach's median grain diameter $d_{50}$ calculated using Stoke's law. The time varying equilibrium condition $\Omega_{eq}$ is a weighted average of the antecedent dimensionless fall velocity $\Omega$ defined as:

$\Omega_{eq} =  \sum_{j=0}^{2 \phi} \Omega_j 10^{-j/\phi} \left[  \sum_{j=0}^{2 \phi} 10^{-j/\phi}  \right]^{-1}$

where $j$ is the number of days prior to the present time and the memory decay $\phi$ is a model free parameter indicating the number of days it takes for the weighting to reach 10\%, 1\% and 0.1\% of the instantaneous value at $\phi$, $2\phi$ and $3\phi$ days prior to the present. The formulation used in the present work and shown in Equation \ref{eq:Equilibrium dimensionles fall velocity} incorporates all past beach state information for the past $2\phi$ days, yielding a minimum weighting factor of 1\%.

### Rotation model

In the rotation model proprosed by Jaramillo et al. [[2](https://doi.org/10.1016/j.coastaleng.2020.103789)], the rate of change in orientation  $d\alpha_s/dt$ (degrees/s) is defined as:

$d\alpha_s/dt = L^{\pm} P  \Delta\alpha_{s}(\theta)$

where the model's forcing term is the product of the incident wave power $P$ (W) computed using linear wave theory, and the model free parameter $L^{\pm}$ representing the response rate of the shoreline with units of degrees per measure incident wave power. The parameter $L^{\pm}$ is separated into accretion $L^{+}$ when $\Delta\alpha_{s}(\theta) > 0$ and erosion $L^{-}$ when $\Delta\alpha_{s}(\theta) < 0$ components.

The orientation disequilibrium term $\Delta\alpha_{s}(\theta)$, is expressed as

$\Delta\alpha_{s}(\theta) = \alpha_s - \frac{\theta - b}{\alpha}$

where $\alpha_s $ is the orientation of the beach, $\theta$ is the incoming wave direction and $\{alpha}$ and b are model free parameters.

The calculated beach rotation was translated to shoreline change by multiplying the cosine of the orientation with a pivot arm f as shown below:

$S(t) = f  (\cos{\alpha_s(t)} - \overline{\cos{\alpha_s(t)}})$

All free parameters of the rotation model namely  $L^{\pm}$, $\alpha$, b and the pivot arm f have been calibrated using a simulated anealing non linear optimization algoritm.

### Model implementation

Initially the rotation of the beach has been calculated an translated into shoreline movement at each transect as described above. Succesively the rotation component of the shoreline timeseries at each transect has been subtracted from the data. The resulting timeseries has been used to calibrate the ShoreFor parameters using a simulated annealing non linear optimization algorithm.

A data assimilation routine has been used to keep the model in track during the medium and long term predictions.

#### Model mechanics
- [ ] Process-Based Models (PBM): couple hydrodynamics, waves, and morphodynamics through mass and momentum conservation laws.
- [ ] Hybrid Models (HM): use observational data to calibrate free parameters in the equilibrium configuration of a system.
- [ ] Data-Driven Models (DDM): use observational data to train regression models (e.g. machine learning, statistical downscaling).
#### Model elements
- [ ] Cross-shore: model the shoreline position for each transect independently.
- [ ] Long-shore: incorporate the interaction of shoreline position across different transects.
- [ ] Sea level: consider the impact of sea level rise on shoreline position.

### References

[](https://github.com/ShoreShop/ShoreModel_Benchmark/blob/main/submissions/ShoreFor/README.md#references)

[[1](https://doi.org/10.1016/j.coastaleng.2012.11.002)] Davidson, M.A., Splinter, K.D. and Turner, I.L. (2013), A simple equilibrium model for predicting shoreline change.  _Coastal Engineering_, 73, pp.191-202.  

[[2](https://doi.org/10.1016/j.coastaleng.2020.103789) Jaramillo C., Gonzalez, M., Medina R. and Turki I.  (2021), An equilibrium-based shoreline rotation model, _Coastal Engineering_ 163, 103789 ]
