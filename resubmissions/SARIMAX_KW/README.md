## SARIMAX model
### Model description
SARIMAX is a data-driven statistical technique for modelling and forecasting time series with the following formula:

$$ SARIMAX(p,d,q)(P,D,Q,s) $$

It includes seven components:

* Autoregression (AR), order p accounts for the interaction of past values of shoreline position on the future shoreline position.
* Moving average (MA), order d accounts for past errors or 'shocks' in the model prediction on future shoreline position.
* Integration or 'differencing' (I), order q is used to difference the shoreline position if the shoreline time series is non-stationary, creating a stationary time series to forecast. Stationary time series' are those whose mean and variance fo not change over time
* Seasonal autoregression (SAR), order P,period s accounts for the interacton of past values of shoreline position within the same month on future instances in that month
* Seasonal moving average (SMA), order D, period s accounts for past errors or 'shocks' in the model prediction within the same month on future instances in that month
* Seasonal integration  (SI), order Q, period s is used if there is non-stationarity in the time series from a seasonal component
* Exogenous variables (X) adds forcing factors (or independent variables) to predict future shoreline positions
As per Hyndman & Athanasopoulos [1].

The model is formulated at each transect following:

AR terms:

$$ y_t = \phi_0 +\sum_{i=1}^p \phi_iy_{t-i}+\varepsilon_{t}$$

MA terms:

$$ y_t = \theta_0 +\sum_{i=1}^q \theta_i\varepsilon_{t-i}+\varepsilon_t$$

SAR terms:

$$ y_t = \Phi_0 +\sum_{i=1}^P \Phi_iy_{t-si}+\varepsilon_{t}$$

SMA terms:

$$ y_t = \Theta_0 +\sum_{i=1}^Q \Theta_i\varepsilon_{t-si}+\varepsilon_t$$

and X terms:

$$ y_t= \beta_0 + \beta_1 NINO3.4_t +\beta_2 DMI_t +\beta_3 H_{S,150,i(t)}$$

Where $y_t$ is the shoreline position at transect i, time t, NINO3.4 is the climate index describing changes in the El Niño Southern Oscillation (ENSO), DMI is the climate index describing changes in the Indian Ocean Dipole (IOD) and $H_{S,150,i(t)}$ is the monthly 150-day rolling mean of nearshore significant wave height at transect i.

The SARIMAX model was applied to ***Task1.Short-term prediction***, ***Task2.Medium-term prediction***, and ***Task3.Long-term prediction***. For each transect, the model was trained on the observed shoreline data at that transect, using the pmdarima_autoarima package [2], using the KPSS test for trend and constant stationarity [3] and the Kruskal test for seasonality [4]. The short term model was forecast using all exogenous variables and the long term model was forecast using only the $H_{S,150,i(t)}$ for either the RCP4.5 or RCP8.5 climate projections. For the medium term model, the model parameters and orders were fit to a model given three years of false data before 1951 (using a simple linear model of wave height, seasonality and trend) in order to allow for autoregressive terms. It was then forecast using those previous shoreline positions, ENSO, IOD and $H_{S,150,i(t)}$ information.
### Model classification
#### Model mechanics
- [ ] Process-Based Models (PBM): couple hydrodynamics, waves, and morphodynamics through mass and momentum conservation laws.
- [ ] Hybrid Models (HM): use observational data to calibrate free parameters in the equilibrium configuration of a system.
- [x] Data-Driven Models (DDM): use observational data to train regression models (e.g. machine learning, statistical downscaling).
#### Model elements (multiple choices)
- [x] Cross-shore: model the shoreline position for each transect independently.
- [ ] Long-shore: incorporate the interaction of shoreline position across different transects.
- [ ] Sea level: consider the impact of sea level rise on shoreline position.

### References
[[1](([https://otexts.org/fpp2/]))]
Hyndman, R.J., & Athanasopoulos, G. (2021) Forecasting: principles and practice, 3rd edition, OTexts: Melbourne, Australia.

[[2](([http://www.alkaline-ml.com/pmdarima]))]
Smith, Taylor G., et al. pmdarima: ARIMA estimators for Python, 2017-

[[3](([https://doi.org/10.1016/0304-4076(92)90104-Y]))]
Kwiatkowski, D., Phillips, P.C.B., Schmidt, P., Shin, Y. Testing the null hypothesis of stationarity against the alternative of a unit root: How sure are we that economic time series have a unit root? Journal of Econometrics, Volume 54, Issues 1–3, 1992. https://www.sciencedirect.com/science/article/pii/030440769290104Y

[[4](([https://doi.org/10.2307/2280779]))]
Kruskal, W. H., & Wallis, W. A. (1952). Use of ranks in one-criterion variance analysis. Journal of the American Statistical Association, 47, 583–621 
