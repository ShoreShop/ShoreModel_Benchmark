## Chronos-Forecasting
### Model description
[Chronos](https://github.com/amazon-science/chronos-forecasting) is a family of **pretrained time series forecasting models** based on large language model (LLM) architectures, developed by Amazon Science. 
A time series is transformed into a sequence of tokens via scaling and quantization, and a language model is trained on these tokens using the cross-entropy loss. 
Once trained, probabilistic forecasts are obtained by sampling multiple future trajectories given the historical context. 
Chronos models have been trained on a large corpus of publicly available time series data, as well as synthetic data generated using Gaussian processes.
For details on Chronos models, training data and procedures, and experimental results, please refer to the paper [Chronos: Learning the Language of Time Series](https://arxiv.org/abs/2403.07815).
### Model implementation
For ShoreShop2.0, Chronos-Forecasting was used for ***Task1.Short-term prediction***. For each transect, Shoreline position data between 1987 and 2018 in `shoreline_obs.csv` was resampled to monthly interval and used as input context data. The model was then applied to predict the monthly shoreline position between 2019-01-01 and 2023-12-31. The monthly output was resampled back to daily interval for submission. Wave data was not used in this model. The above processes were iteratively applied to all 9 transects.

