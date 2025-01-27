## SPADS model

### Model description
The Shoreline Prediction at Different Timescales (SPADS) model is a data-driven approach designed to predict shoreline changes more accurately across various temporal scales. Developed by (Montaño et al., 2021), SPADS is based on the Complete Ensemble Empirical Mode Decomposition (CEEMD) method (Huang et al., 1998). This model aims to improve the simulation of shoreline dynamics by addressing the shortcomings of traditional process-based models, which often struggle with short-term oscillations. SPADS utilizes CEEMD to identify the main timescales at which drivers and changes in shoreline position are most relevant, focusing on those that exhibit the greatest correlation. This approach allows for a more comprehensive analysis of shoreline behaviour across different temporal scales.
To account for the effects of sea level rise (SLR), the SPADS model incorporates an additional term based on the study by (Vitousek et al., 2017). This term, representing the contribution of SLR to shoreline retreat, is subtracted from the shoreline position initially predicted by the SPADS model. The term associated with the retreat of the coastline due to the SLR-related effect is defined as follows:
shoreline retreat (due to SLR)=  c/tanβ  ∂S/∂t
where tanβ refers to the slope of the beach, ∂S/∂t indicates the mean sea level rise over the time period being investigated and c is defined as the 'calibration factor' and in our case assumed to be equal to two. 

### Model implementation
The SPADS model was trained using the available shoreline dataset spanning from 1999 to 2018. This training phase allowed the model to learn the relationships between input wave parameters (significant wave height, peak period, and wave direction) and the output (shoreline position). Following the training, the model was used to forecast shoreline positions for the historical and future periods at a daily time step for each of the targeted transects (2, 5, and 8). The forecasting was divided into three main tasks:
Task 1: Short-term prediction (2019-2023)
Task 2: Medium-term prediction (1951-1998)
Task 3: Long-term prediction (2023-2100) under two climate scenarios (RCP 45 and RCP 85)
Finally, the SPADS model results were adjusted using the shoreline retreat formula for all forecasted timeframes to incorporate the influence of SLR. This post-processing step enhances the model's predictions by including the potential impacts of rising sea levels on shoreline positions.

### Model classification
#### Model mechanics
- [] Process-Based Models (PBM): couple hydrodynamics, waves, and morphodynamics through mass and momentum conservation laws.
- [] Hybrid Models (HM): use observational data to calibrate free parameters in the equilibrium configuration of a system.
- [x] Data-Driven Models (DDM): use observational data to train regression models (e.g. machine learning, statistical downscaling).

#### Model elements (multiple choices)
- [x] Cross-shore: model the shoreline position for each transect independently.
- [ ] Long-shore: incorporate the interaction of shoreline position across different transects.
- [ ] Sea level: consider the impact of sea level rise on shoreline position.

### References
Huang, N.E. et al. (1998) ‘The empirical mode decomposition and the Hilbert spectrum for nonlinear and non-stationary time series analysis’, Proceedings of the Royal Society of London. Series A: Mathematical, Physical and Engineering Sciences, 454(1971), pp. 903–995. Available at: https://doi.org/10.1098/rspa.1998.0193.
Montaño, J. et al. (2021) ‘A Multiscale Approach to Shoreline Prediction’, Geophysical Research Letters, 48(1). Available at: https://doi.org/10.1029/2020GL090587.
Vitousek, S. et al. (2017) ‘A model integrating longshore and cross-shore processes for predicting long-term shoreline response to climate change’, Journal of Geophysical Research: Earth Surface, 122(4), pp. 782–806. Available at: https://doi.org/https://doi.org/10.1002/2016JF004065.
 
