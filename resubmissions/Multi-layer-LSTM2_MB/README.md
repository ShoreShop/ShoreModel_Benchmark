## Multiple layer LSTM network for discrete data
### Resubmission using smoothed shorelines
This model was trained using **all the smoothed shoreline positions** between 1999 and 2018. The other settings are the same as those for Multi-layer LSTM below, which was submitted first.

### Model description
**LSTM (Long Short-Term Memory) network** is one of the recurrent neural networks (RNNs) specifically designed to learn long-term dependencies in sequential data. LSTM networks have a memory cell that can retain information for extended periods, making it exceptionally well-suited for tasks involving sequences such as natural language processing, speech recognition, and time series forecasting. LSTM networks employ gates to control the flow of information into and out of the memory cell: input, forget, and output gates. LSTMs are more powerful tool for modeling sequential data than traditional RNNs.

By feeding the output of an LSTM layer as input to the next time step, we can generate predictions for unknown time series data. Furthermore, stacking multiple LSTM layers creates a deep learning architecture capable of modeling even more intricate time series variations. This multi-layer approach leads the network to more accurate and robust predictions.

For instance, in shoreline change prediction, a LSTM network can capture both short-term shoreline changes due to waves and tidal cycles and long-term shoreline changes like erosion trend and retreat associated with sea-level rise.

### Model implementation

The LSTM networks were applied to ***Task1.Short-term prediction*** and ***Task3.Long-term prediction***. The input data is waves, water levels, tides, previous shoreline positions and elapsed days from the previous measurement. The output data is the shoreline positions. All the transects were predicted together and the 1-year sequential data of waves and tides were used as input. In other words, the input data has 13516 dimensions (Hs: 9\*365, Tp:9\*365, θ(sin):9\*365, θ(cos):9\*365, tide: 365, water level: 1, previous shoreline position: 9, elapsed days: 1). **All The historical data** from 1999 to 2018 was used for training the network. Here is the summary of the networks architecture and hyperparameters: LSTM layers=2, hidden units=400, dropout rate=0.1, Epochs=100. Dropout layers were inserted after each LSTM layer to prevent overlearning.

#### Model mechanics
- [ ] Process-Based Models (PBM): couple hydrodynamics, waves, and morphodynamics through mass and momentum conservation laws.
- [ ] Hybrid Models (HM): use observational data to calibrate free parameters in the equilibrium configuration of a system.
- [x] Data-Driven Models (DDM): use observational data to train regression models (e.g. machine learning, statistical downscaling).
#### Model elements
- [x] Cross-shore: model the shoreline position for each transect independently.
- [x] Long-shore: incorporate the interaction of shoreline position across different transects.
- [x] Sea level: consider the impact of sea level rise on shoreline position.

### References
[[1]()]
Banno, M., & Kuriyama, Y. (2022). Test of LSTM networks in long-term beach morphological changes. ICCE 2022.
