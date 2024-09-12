## GAT-LSTM model
### Model description
GAT-LSTM is a data-driven model that combines the Graph Attention Network (GAT, [[1](https://doi.org/10.48550/arXiv.1710.10903)]) and Long short-term memory (LSTM, [[2](https://doi.org/10.1162/neco.1997.9.8.1735)]). In this approach, the shoreline is a simplified as sequentially linked graph with each transect representing a node. After the simplification, the GAT is applied to extract the spatial characteristics of shorelines, which, toghether with wave parameters (i.e. Hs, Tp, and Dir), is then used as the input to LSTM. The LSTM model follows the structure described in [[3](https://dx.doi.org/10.2139/ssrn.4790010)]


### Model implementation
The GAT-LSTM model was applied to ***Task1.Short-term prediction***, ***Task2.Medium-term prediction***, and ***Task3.Long-term prediction***. The daily shoreline and wave ($H_s$, $T_p$, $Dir$) data for all transects between 1999 and 2018 were sliced into sequences with 128 days with a step of 1 day. The resultant sequences were split into 70% training and 30% validation datasets. The first shoreline data in each sequence was used as the context and the predicted shoreline position was evaluated against the remaining 127 days in the sequence. The MSE was used as the loss function. Early stopping was set based on the validation score.
Subsequently, the trained model was employed to predict shoreline positions from 1950 to 2100. 

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
[[1](https://doi.org/10.48550/arXiv.1710.10903)]
Veličković, P., Cucurull, G., Casanova, A., Romero, A., Lio, P. and Bengio, Y., 2017. Graph attention networks. arXiv preprint arXiv:1710.10903.\
[[2](https://doi.org/10.1162/neco.1997.9.8.1735)]
Sepp Hochreiter, Jürgen Schmidhuber; Long Short-Term Memory. Neural Comput 1997; 9 (8): 1735–1780.\
[[3](https://dx.doi.org/10.2139/ssrn.4790010)]
Calcraft, Kit and Splinter, Kristen D. and Simmons, Joshua and Marshall, Lucy, ­­Can Lstm Neural Networks Learn Physically Meaningful Principles? A Case Study in Sandy Shoreline Modelling.
