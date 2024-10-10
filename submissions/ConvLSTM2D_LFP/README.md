## ConvLSTM2D 
## Model Description
This model uses a **ConvLSTM2D-based architecture** [[1](https://doi.org/10.48550/arXiv.1506.04214)] to predict shoreline positions using spatio-temporal data. The model integrates convolutional and LSTM layers to capture both spatial and temporal dependencies in the input data. The architecture is designed to handle time series input, where each time step consists of a 2D spatial grid, such as a grid representing shoreline positions over time. 
The mesh consists of two ConvLSTM2D layers followed by a dense output layer. This model is designed for short-term prediction of shoreline positions for multiple transects. The input data (`x`) consist of spatio-temporal sequences where each time step is represented by a grid of shoreline positions. The output (`y`) is a vector of shoreline positions for each transect.

### Model Implementation
The model was applied to **Task1.Short-term prediction**. It was trained to minimize the custom loss function specified for ShoreShop 2.0, with additional metrics such as Hubber loss.

The hyperparameters of the model were found by [Bayesian Optimization](https://keras.io/api/keras_tuner/tuners/bayesian/) with 200 trials and a random seed of 42. The model is compiled using the **Adam optimizer** with the specified learning rate, and it is trained for 150 epochs with 15% of the data used for validation.

### Modeler
:man_technologist: [Lucas de Freitas Pereira](https://ihcantabria.com/directorio-personal/lucas-de-freitas-pereira/) @ [![Linkedin](https://i.sstatic.net/gVE0j.png) LinkedIn](https://www.linkedin.com/in/lucas-de-freitas-pereira-a64a0879/)
### Contributors
:man_technologist: [Camilo Jaramillo Cardona](https://ihcantabria.com/directorio-personal/camilo-jaramillo/) @ [![Linkedin](https://i.sstatic.net/gVE0j.png) LinkedIn](https://www.linkedin.com/in/camilo-jaramillo-cardona-05b64789/)
:man_technologist: [Jose A. A. Antolinez](https://www.tudelft.nl/staff/j.a.a.antolinez/) @ [![Linkedin](https://i.sstatic.net/gVE0j.png) LinkedIn](https://www.linkedin.com/in/jaaantolinez/)

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
[[1](https://doi.org/10.48550/arXiv.1506.04214)] Xingjian Shi, Zhourong Chen, Hao Wang, Dit-Yan Yeung, Wai-Kin Wong, Wang-chun Woo (2015), Convolutional LSTM Network: A Machine Learning Approach for Precipitation Nowcasting. *Advances in neural information processing systems*.
