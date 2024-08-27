## CNN-LSTM model
### Model description

TheCNN-LSTM hybrid neural network architecture can be viewed as an array of two submodels: a CNN unit followed by an LSTM one. The CNN component is used to extract features of the input data, while the LSTM component is used to learn how those features change with time. The architecture as presented in Gomez-de la Pena et al. [[1](https://doi.org/10.5194/esurf-11-1145-2023)] was used, where the CNN unit consists of two convolutional layers followed by a max-pooling layer. Dropout is then applied as a regularization techinique. The distilled feature vector obtained with the CNN unit is then used in the LSTM layer. The models are trained using the symmetric index of agreement derived in Duveiller et al. 2016 [[2](https://doi.org/10.1038/srep19401)].

### Model implementation
The CNN-LSTM models were applied to ***Task1.Short-term prediction***. For each transect, Look back period (corresponding to 75, 90, 120, 150 days), learning-rate (1e-4, 1e-5) , dropout (0.3-0.7). Inputs were resampled to daily frequency and linearly interpolated. For transects 3 and 4 a rolling average of 20 days period was further applied. Wave direction was transformed to x and y components. Hs + Wave dir X and y components were used as model inputs. Shoreline data was used as target. The models were trained for 15 epochs with an early stopping Policy. 

Models were trained until 2014, evaluated until 2018. When performance was deemed appropiate, predictions where produced until 2023.


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
[[1](https://doi.org/10.5194/esurf-11-1145-2023)]
Gomez-de la Peña, E., Coco, G., Whittaker, C., & Montaño, J. (2023). On the use of convolutional deep learning to predict shoreline change. Earth Surface Dynamics, 11(6), 1145-1160.\
[[2](https://doi.org/10.1038/srep19401)]
Duveiller, G., Fasbender, D., & Meroni, M. (2016). Revisiting the concept of a symmetric index of agreement for continuous datasets. Scientific reports, 6(1), 19401.



