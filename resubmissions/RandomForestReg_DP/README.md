## Random Forest Regressor model
### Model description

A Random Forest is a machine learning algorithm that uses a collection of decision trees to make predictions[1]. Each one of these trees is a model that splits the data based on different features to make a decision. In this context, multiple decision trees are built using random subsets of the data and random subsets of the features. This randomness in both the data and features helps prevent overfitting, which can occur when a model becomes too tailored to the training data and performs poorly on new, unseen data.

When a prediction is needed, each individual tree in the forest makes its own prediction. For classification tasks, the Random Forest takes a "vote" from all the trees, where each tree chooses a class, and the class with the most votes becomes the final prediction. For regression tasks, the algorithm averages the predictions of all the trees to obtain the final result. This collective approach makes Random Forest more robust and accurate compared to individual decision trees, as it reduces the risk of errors or biases that might be present in any single tree.

### Model implementation

This shoreline predictive model used Random Forest Regressor (RFR) from Python sklearn machine library library, to predict shoreline positions from wave data and shoreline patterns. In mathematical terms, the model follows as:

$$
Y_{(t, i)} = \frac{1}{N} \sum_{n=1}^{N} \hat{Y}_{n_{(t, i)}}
$$

where

- $ Y $ is the shoreline position at time-step $t$ and lonshore position $i$;
- $ N $ is the number of trees in the Random Forest;
- $ \hat{Y}_{n_{(t, i)}} $ is the shoreline prediction from the n-th decision tree based on the input features at time-step $t$ and lonshore position $i$ which, in turn, is the product of the non-linear function $f_n$ considering all inputs, learned by the RFR model, as in:

$$
\hat{Y}_{n_{(t, i)}} = f_n\Big( 
  H_{s_{(t, i)}}, 
  \max_{k \in [t-14, t]} (H_{s_{(k, i)}}),
  \mean_{k \in [t-14, t]} (H_{s_{(k, i)}}),
  T_{p_{(t, i)}}, 
  \max_{k \in [t-14, t]} (T_{p_{(k, i)}}),
  \mean_{k \in [t-14, t]} (T_{p_{(k, i)}}),
  \theta_{p_{(t, i)}},  
  \max_{k \in [t-14, t]} (\theta_{p_{(k, i)}}),
  \mean_{k \in [t-14, t]} (\theta_{p_{(k, i)}}),
  {C}_{season_{(t, i)}}, 
  {C}_{year_{(t, i)}}
\Big)
$$

where

- $ H_{s_{(t, i)}} $ is the significant wave height at time-step $t$ and lonshore position $i$;
- $ max_{k \in [t-14, t]} H_s(k, i) $ is the maximum significant wave height observed over the 15-day rolling window up to time-step $t$ at lonshore position $i$;
- $ mean_{k \in [t-14, t]} H_s(k, i) $ is the mean significant wave height observed over the 15-day rolling window up to time-step $t$ at lonshore position $i$;
- $ T_p(t, i) $ is the peak wave period at time-step $t$ and lonshore position $i$;
- $ max_{k \in [t-14, t]} T_p(k, i) $ is the maximum peak wave period observed over the 15-day rolling window up to time-step $t$ at lonshore position $i$;
- $ mean_{k \in [t-14, t]} T_p(k, i) $ is the maximum peak wave period observed over the 15-day rolling window up to time-step $t$ at lonshore position $i$;
- $ \theta(t, i) $ is the wave atack angle at time-step $t$ and lonshore position $i$;
- $ max_{k \in [t-14, t]} \theta(k, i) $ is the maximum wave atack angle observed over the 15-day rolling window up to time-step $t$ at lonshore position $i$;
- $ mean_{k \in [t-14, t]} \theta(k, i) $ is the maximum wave atack angle observed over the 15-day rolling window up to time-step $t$ at lonshore position $i$;
- $ {C}_{season_{(t, i)}} $ is the seasonaly calculated Pearson correlation of shoreline positions across all lonshore positions $i$;
- $ {C}_{year_{(t, i)}} $ is the yearly calculated Pearson correlation of shoreline positions across all lonshore positions $i$.

The abovemention RFR model was applied to ***Task1.Short-term prediction***, and ***Task2.Medium-term prediction***, and using the nine transects all together. Hyperparameters were optimized based on cross-validation. No pre-processing or smoothing was applied to the input data. No pos-processing was applied to the outputs.

(*) For the first task the yearly Pearson correlations for the short-term (five-year) timespan (2019–2023) are derived from the last five years of the training set (2014–2018). Specifically, the correlation from 2014 is assigned to 2019, the correlation from 2015 to 2020, and so on, up to the correlation from 2018 being assigned to 2023. For the second task the yearly Pearson correlations for the medium-term, 48-year timespan (1951–1998) are based on a rolling 20-year window from the training set. For instance, 1998 corresponds to 2018, 1997 to 2017, and so forth. Additionally, the correlation distribution resets after 20 years.

### Model classification
#### Model mechanics
- [ ] Process-Based Models (PBM): couple hydrodynamics, waves, and morphodynamics through mass and momentum conservation laws.
- [ ] Hybrid Models (HM): use observational data to calibrate free parameters in the equilibrium configuration of a system.
- [x] Data-Driven Models (DDM): use observational data to train regression models (e.g. machine learning, statistical downscaling).
#### Model elements (multiple choices)
- [x] Cross-shore: model the shoreline position for each transect independently.
- [x] Long-shore: incorporate the interaction of shoreline position across different transects.
- [ ] Sea level: consider the impact of sea level rise on shoreline position.

### Modeller

- Daniel Pais, Ciências ULisboa, IDL & +ATLANTIC CoLAB (Portugal) ([dmpais@fc.ul.pt])

### References
[[1](https://doi.org/10.1023/A:1010933404324)]
Breiman, L. Random Forests. Machine Learning 45, 5–32 (2001).
