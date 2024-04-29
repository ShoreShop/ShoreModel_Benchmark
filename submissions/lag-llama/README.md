## Lag-Llama
### Model description
[Lag-Llama](https://github.com/time-series-foundation-models/lag-llama?tab=readme-ov-file) is a general-purpose foundation model for univariate probabilistic time series forecasting.
The model architecture is based on a simple yet effective transformer design. This is in contrast to other recent time series transformers that incorporate fairly complex custom inductive biases.
In terms of pretraining data, Lag-Llama was trained on a diverse corpus of over 7,000 real-world time series datasets spanning domains like energy, transportation, economics, and nature. 
In total, the pretraining data contained over 350 million datapoints. This establishes a broad knowledge base that Lag-Llama can draw upon.
A key innovation is Lag-Llama’s representation of the data which is based on lagged values of the series plus datetime features. Lag-Llama’s encoding approach provides an elegant way to capture diverse range of frequencies in a generalizable way.
For details on lag-llama models, training data and procedures, and experimental results, please refer to the paper [Lag-Llama: Towards Foundation Models for Probabilistic Time Series Forecasting](https://arxiv.org/abs/2310.08278).
### Model implementation
For ShoreShop2.0, Chronos-Forecasting was used for ***Task1.Short-term prediction***. For each transect, shoreline position data between 1987 and 2018 in `shoreline_obs.csv` was resampled to monthly interval and used as input context data. The model was then applied to predict the monthly shoreline position between 2019-01-01 and 2023-12-31. The monthly output was resampled back to daily interval for submission. Wave data was not used in this model. The above processes were iteratively applied to all 9 transects.
## Model classification

#### Model mechanics
- [ ] Process-Based Models (PBM): couple hydrodynamics, waves, and morphodynamics through mass and momentum conservation laws.
- [ ] Hybrid Models (HM): use observational data to calibrate free parameters in the equilibrium configuration of a system.
- [x] Data-Driven Models (DDM): use observational data to train regression models (e.g. machine learning, statistical downscaling).
#### Model elements
- [x] Cross-shore: model the shoreline position for each transect independently.
- [ ] Long-shore: incorporate the interaction of shoreline position across different transects.
- [ ] Sea level: consider the impact of sea level rise on shoreline position.
