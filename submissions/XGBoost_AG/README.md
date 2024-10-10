## XGBoost model

### Model description
XGBoost, or Extreme Gradient Boosting, is a highly efficient and scalable machine learning library that implements gradient-boosted decision trees for supervised learning tasks such as regression, classification, and ranking. It stands out for its algorithmic optimizations including a novel tree learning algorithm, handling sparse data, and built-in regularization to prevent overfitting. The algorithm employs parallel and distributed computing to handle large-scale data efficiently, while its unique features like handling missing values automatically and built-in tree pruning make it both robust and practical. It has consistently demonstrated superior performance in machine learning competitions and real-world applications, particularly in cases where the data is structured, and features are well-defined. 
To account for the effects of sea level rise (SLR), the XGBoost model incorporates an additional term based on the study by (Vitousek et al., 2017). This term, representing the contribution of SLR to shoreline retreat, is subtracted from the shoreline position initially predicted by the XGBoost model. The term associated with the retreat of the coastline due to the SLR-related effect is defined as follows: 
shoreline retreat (due to SLR)=  c/tanβ  ∂S/∂t
where tanβ refers to the slope of the beach, ∂S/∂t indicates the mean sea level rise over the time period being investigated and c is defined as the 'calibration factor' and in our case assumed to be equal to two.

### Model implementation

The XGBoost regression model predicts shoreline positions using past shoreline data along with wave parameters (Hs, Tp, Dir). It incorporates time-based features (seasonality, trend), lagged values, and rolling statistics to capture temporal dependencies effectively. Trained on historical data (1999-2019), the model leverages both past shoreline data and wave parameters to predict future and past shoreline positions, enhancing performance through optimized hyperparameters. At the end, the XGBoost model results were adjusted using the shoreline retreat formula for all forecasted timeframes to incorporate the influence of SLR.


### Model classification
- [ ] Process-Based Models (PBM): couple hydrodynamics, waves, and morphodynamics through mass and momentum conservation laws.
- [ ] Hybrid Models (HM): use observational data to calibrate free parameters in the equilibrium configuration of a system.
- [x] Data-Driven Models (DDM): use observational data to train regression models (e.g. machine learning, statistical downscaling).
#### Model elements (multiple choices)
- [x] Cross-shore: model the shoreline position for each transect independently.
- [ ] Long-shore: incorporate the interaction of shoreline position across different transects.
- [x] Sea level: consider the impact of sea level rise on shoreline position.

### References
Vitousek, S., Barnard, P. L., Limber, P., Erikson, L., & Cole, B. (2017). A model integrating longshore and cross-shore processes for predicting long-term shoreline response to climate change. Journal of Geophysical Research: Earth Surface, 122(4), 782–806. https://doi.org/https://doi.org/10.1002/2016JF004065
 
