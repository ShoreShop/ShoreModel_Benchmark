## CNN-LSTM model
### Model description

CNN-LSTM hybrid neural networks can be viewed as an array of two submodels: a CNN unit followed by an LSTM one. The CNN component is used to extract features of the input data, while the LSTM component is used to learn how those features change with time. The architecture as presented in Gomez-de la Pena et al. [[1](https://doi.org/10.5194/esurf-11-1145-2023)] was used, where the CNN unit consists of two convolutional layers followed by a max-pooling layer. Dropout was then applied as a regularization techinique. The distilled feature vector obtained with the CNN unit was then used in the LSTM layer.

The changes in this revised version are:
	-The learning rate and dropout hyperparameters were optimized using an open source hyperparameter optimization framework [[2](https://optuna.org/)]. 
	-The loss function was changed to the Shoreshop metric. 
	-Input smoothing with Garcia (2010) smoother [[3](https://doi.org/10.1016/j.csda.2009.09.020)], following the smoothing carried out by Sean Vitousek in CoSMoS-Conv.


### Model implementation
The CNN-LSTM models were applied to ***Task1.Short-term prediction***. For each transect, shoreline data was resampled to daily frequency and used as the target data. Wave direction was transformed to x and y components and used along with wave height as model inputs. Data was split in train and development sets. Models were trained with an early stopping policy; when the development loss stopped improving, training was stopped. Once trained, models were applied to predict the shoreline position (2019-2023). 

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
Gomez-de la Peña, E., Coco, G., Whittaker, C., & Montaño, J. (2023). On the use of convolutional deep learning to predict shoreline change. *Earth Surface Dynamics*, 11(6), 1145-1160.\
[[2](https://doi.org/10.48550/arXiv.1907.10902)]
Takuya Akiba, Shotaro Sano, Toshihiko Yanase, Takeru Ohta, and Masanori Koyama (2019). “Optuna: A Next-generation Hyperparameter Optimization Framework.” Proceedings of the 25th (ACM) (SIGKDD) International Conference on Knowledge Discovery and Data Mining.\
[[3](https://doi.org/10.1016/j.csda.2009.09.020)]
Garcia, Damien (2010). “Robust Smoothing of Gridded Data in One and Higher Dimensions with Missing Values.” *Computational Statistics & Data Analysis*, 54 (4), 1167–78.



