## SVARX model
### Model description
VAR is a data-driven statistical technique for modelling and forecasting multivariate time series, which allows for interactions between multiple dependent variables. It has the following formula:

$$ SVARX(p) $$

It includes three components:

* Vector Autoregression (AR), order p accounts for the interaction of past values of shoreline position at each transect on the future shoreline position.
* Seasonality (S), which takes into account consistent seasonally varying cycles in shoreline position. This is the average monthly shoreline position of the detrended transect.
* Exogenous variables (X) adds forcing factors (or independent variables) to predict future shoreline positions
As per Stock & Watson (2001) [1].

The model has the following formula:

$$Y_t = B_0 +B_1Y_{t-1}+B_2NINO34_t+B_3IOD_t+B_4H_{S,150,(t)}+B_5month +\varepsilon$$

Where:

$$Y_t= \begin{bmatrix} Y_{1(t)} \\ 
Y_{2(t)} \\ 
Y_{3(t)} \\ 
Y_{4(t)} \\ 
Y_{5(t)} \\ 
Y_{6(t)} \\
Y_{7(t)} \\ 
Y_{8(t)} \\ 
Y_{9(t)} \end{bmatrix}, B_0 = \begin{bmatrix} B_{0(1)} \\ 
B_{0(2)} \\ 
B_{0(3)} \\ 
B_{0(4)} \\ 
B_{0(5)} \\ 
B_{0(6)} \\
B_{0(7)} \\ 
B_{0(8)} \\ 
B_{0(9)} \end{bmatrix}$$

$$B_1= \begin{bmatrix} B_{1(1,1)} & B_{1(1,2)} & B_{1(1,3)} & B_{1(1,4)} & B_{1(1,5)} & B_{1(1,6)} & B_{1(1,7)} & B_{1(1,8)} & B_{1(1,9)} \\ 
B_{1(2,1)} & B_{1(2,2)} & B_{1(2,3)} & B_{1(2,4)} & B_{1(2,5)} & B_{1(2,6)} & B_{1(2,7)} & B_{1(2,8)} & B_{1(2,9)} \\ 
B_{1(3,1)} & B_{1(3,2)} & B_{1(3,3)} & B_{1(3,4)} & B_{1(3,5)} & B_{1(3,6)} & B_{1(3,7)} & B_{1(3,8)} & B_{1(3,9)} \\ 
B_{1(4,1)} & B_{1(4,2)} & B_{1(4,3)} & B_{1(4,4)} & B_{1(4,5)} & B_{1(4,6)} & B_{1(4,7)} & B_{1(4,8)} & B_{1(4,9)} \\ 
B_{1(5,1)} & B_{1(5,2)} & B_{1(5,3)} & B_{1(5,4)} & B_{1(5,5)} & B_{1(5,6)} & B_{1(5,7)} & B_{1(5,8)} & B_{1(5,9)} \\ 
B_{1(6,1)} & B_{1(6,2)} & B_{1(6,3)} & B_{1(6,4)} & B_{1(6,5)} & B_{1(6,6)} & B_{1(6,7)} & B_{1(6,8)} & B_{1(6,9)} \\
B_{1(7,1)} & B_{1(7,2)} & B_{1(7,3)} & B_{1(7,4)} & B_{1(7,5)} & B_{1(7,6)} & B_{1(7,7)} & B_{1(7,8)} & B_{1(7,9)} \\ 
B_{1(8,1)} & B_{1(8,2)} & B_{1(8,3)} & B_{1(8,4)} & B_{1(8,5)} & B_{1(8,6)} & B_{1(8,7)} & B_{1(8,8)} & B_{1(8,9)} \\ 
B_{1(9,1)} & B_{1(9,2)} & B_{1(9,3)} & B_{1(9,4)} & B_{1(9,5)} & B_{1(9,6)} & B_{1(9,7)} & B_{1(9,8)} & B_{1(9,9)} \end{bmatrix}$$

$$B_2 = \begin{bmatrix} B_{2(1)} \\ 
B_{2(2)} \\ 
B_{2(3)} \\ 
B_{2(4)} \\ 
B_{2(5)} \\ 
B_{2(6)} \\
B_{2(7)} \\ 
B_{2(8)} \\ 
B_{2(9)} \end{bmatrix},B_3 = \begin{bmatrix} B_{3(1)} \\ 
B_{3(2)} \\ 
B_{3(3)} \\ 
B_{3(4)} \\ 
B_{3(5)} \\ 
B_{3(6)} \\
B_{3(7)} \\ 
B_{3(8)} \\ 
B_{3(9)} \end{bmatrix}, B_4 = \begin{bmatrix} B_{4(1)} \\ 
B_{4(2)} \\ 
B_{4(3)} \\ 
B_{4(4)} \\ 
B_{4(5)} \\ 
B_{4(6)} \\
B_{4(7)} \\ 
B_{248)} \\ 
B_{4(9)} \end{bmatrix}, B_5 = \begin{bmatrix} B_{5(1)} \\ 
B_{5(2)} \\ 
B_{5(3)} \\ 
B_{5(4)} \\ 
B_{5(5)} \\ 
B_{5(6)} \\
B_{5(7)} \\ 
B_{5(8)} \\ 
B_{5(9)} \end{bmatrix}$$

$$month = \begin{bmatrix} seas_{jan} & seas_{feb} & seas_{mar} & seas_{apr} & seas_{may} & seas_{jun} & seas_{jul} & seas_{aug} & seas_{sep} & seas_{oct} & seas_{nov} & seas_{dec}  \end{bmatrix} $$

Where NINO3.4 is the climate index describing changes in the El Niño Southern Oscillation (ENSO), DMI is the climate index describing changes in the Indian Ocean Dipole (IOD) and $H_{S,150,i(t)}$ is the monthly 150-day rolling mean of nearshore significant wave height at transect i.

The SVARX model was applied to ***Task1.Short-term prediction***, ***Task2.Medium-term prediction***, and ***Task3.Long-term prediction***. For each transect, the model was trained on the observed shoreline data at that transect, using the statsmodels.tsa.statespace.varmax package [2], using the KPSS test for trend and constant stationarity [3] and the Kruskal test for seasonality [4]. The tool uses a kalman filter to determine coefficients $B_0$, $B_1$, $B_2$, $B_3$ and $B_4$, while $B_5$ was calculated manually. The best performing model contained no moving average terms, hence a SVARX and not SVARMAX equation. The short term model was forecast using all exogenous variables and the long term model was forecast using only the $H_{S,150,i(t)}$ for either the RCP4.5 or RCP8.5 climate projections. For the medium term model, the model parameters and orders were fit to a model given three years of false data before 1951 (using a simple linear model of wave height, seasonality and trend) in order to allow for autoregressive terms. It was then forecast using those previous shoreline positions, ENSO, IOD and $H_{S,150,i(t)}$ information.
### Model classification
#### Model mechanics
- [ ] Process-Based Models (PBM): couple hydrodynamics, waves, and morphodynamics through mass and momentum conservation laws.
- [ ] Hybrid Models (HM): use observational data to calibrate free parameters in the equilibrium configuration of a system.
- [x] Data-Driven Models (DDM): use observational data to train regression models (e.g. machine learning, statistical downscaling).
#### Model elements (multiple choices)
- [x] Cross-shore: model the shoreline position for each transect independently.
- [x] Long-shore: incorporate the interaction of shoreline position across different transects.
- [ ] Sea level: consider the impact of sea level rise on shoreline position.

### References
[[1](([https://doi.org/10.1257/jep.15.4.101]))]
Stock, J., & Watson, M. (2001) Vector Autoregressions. Journal of Economic Perspectives, 15 (4): 101–115.

[[2]]
Seabold, Skipper, and Josef Perktold. “statsmodels: Econometric and statistical modeling with python.” Proceedings of the 9th Python in Science Conference. 2010.

[[3](([https://doi.org/10.1016/0304-4076(92)90104-Y]))]
Kwiatkowski, D., Phillips, P.C.B., Schmidt, P., Shin, Y. Testing the null hypothesis of stationarity against the alternative of a unit root: How sure are we that economic time series have a unit root? Journal of Econometrics, Volume 54, Issues 1–3, 1992. https://www.sciencedirect.com/science/article/pii/030440769290104Y

[[4](([https://doi.org/10.2307/2280779]))]
Kruskal, W. H., & Wallis, W. A. (1952). Use of ranks in one-criterion variance analysis. Journal of the American Statistical Association, 47, 583–621 
