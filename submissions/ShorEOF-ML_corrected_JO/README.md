## ShorEOF-ML model
### Model description
This model is named **ShorEOF-ML** (pronounced "shore of ML") to reflect its focus on shoreline prediction using Empirical Orthogonal Functions (EOF) and Machine Learning (ML). [Click here for the Rmarkdown code presenting the analysis.](https://htmlpreview.github.io/?https://github.com/JulianOG/ShoreModel_Benchmark/blob/main/submissions/ShorEOF-ML_JO/code/ShorEOF-ML.html) 

In this analysis, we explore the use of [**Principal Component Analysis (PCA)**](https://www.coastalwiki.org/wiki/Analysis_of_coastal_processes_with_Empirical_Orthogonal_Functions#Applications_of_Empirical_Orthogonal_Functions_.28EOF.29), specifically through **Empirical Orthogonal Functions (EOFs)**, to model and predict **shoreline change** [Short and Trembanis 2004](https://bioone.org/journals/journal-of-coastal-research/volume-20/issue-2/1551-5036(2004)020%5b0523%3aDSPIBO%5d2.0.CO%3b2/Decadal-Scale-Patterns-in-Beach-Oscillation-and-Rotation-Narrabeen-Beach/10.2112/1551-5036(2004)020[0523:DSPIBO]2.0.CO;2.short). The goal is to identify key patterns in coastal variability—both spatial (e.g., entire beach retreat/advance or shoreline rotation) and temporal (e.g. changing ocean conditions)—and use these patterns to create a predictive model of shoreline change driven by ocean conditions.

**Update/corrected after reviewing first submission 1) to use the cost function used to compare modes 2) fix the wave directions 3) smooth the shoreline transects**

#### What is EOF Analysis?

EOF analysis is a powerful tool for decomposing complex spatial-temporal data into simpler patterns. In this case, we use EOFs to capture the primary modes of shoreline variability. These modes may represent large-scale changes, such as:

- **Beach retreat** (the entire shoreline moving landward for positive PC time series values or seaward for negative values).
- **Shoreline rotation** (one side of the shoreline retreats while another advances and vice versa for negative values).

By breaking down the shoreline data into its nine principal components (PCs), we can better understand how the coastline responds to environmental factors like wave energy and water levels. These PCs form the backbone of our model, summarizing the most significant patterns of variability in a compact and interpretable way.

#### Machine Learning to Predict Shoreline Change

Once we have the principal components, the next step is to predict these PCs using **machine learning**. We use a variety of oceanographic inputs, such as wave height, wave direction, and water levels, to train a model that can predict future shoreline positions based on these inputs.

The machine learning model attempts to forecast the **PC time series**, which can then be mapped back to the physical shoreline changes using the EOFs. While the predictions show some promise, we are still evaluating the overall accuracy and robustness of the model. The analysis identifies the important ocean factors that drive each of the PCs related to the EOF of shoreline retreat or rotation. 

#### Inspiration for the Analysis

This work draws inspiration from a range of recent work in coastal modelling:

- **James Thompson**'s [conference presentation](https://scholar.google.com.au/citations?view_op=view_citation&hl=en&user=4vwRMF8AAAAJ&sortby=pubdate&citation_for_view=4vwRMF8AAAAJ:ldfaerwXgEUC), which uses EOF analysis to link shoreline rotation with the **Southern Annular Mode** (a key climate variability driver).
- **Emilio Echevarria**'s [conference presentation](https://ics2024.exordo.com/programme/presentation/175), which combines EOF-based data reduction with machine learning to predict shoreline change from **XBeach** hindcast numerical simulations.
- Discussion with **Stephanie-Contardo** on using lag data (delta changes in conditions) for prediction.

#### Ongoing work

While we are still refining the model, this approach offers a promising path forward for predicting coastal change. By combining EOF analysis with machine learning, we can capture complex patterns in coastal systems and link them to oceanographic drivers. The ongoing challenge is to ensure the accuracy and generalizability of the model, especially in the face of dynamic environmental conditions.

Stay tuned as we continue to refine this method and explore its potential for coastal management and shoreline prediction!

### Model classification
#### Model mechanics
- [ ] Process-Based Models (PBM): couple hydrodynamics, waves, and morphodynamics through mass and momentum conservation laws.
- [ ] Hybrid Models (HM): use observational data to calibrate free parameters in the equilibrium configuration of a system.
- [x] Data-Driven Models (DDM): use observational data to train regression models (e.g. machine learning, statistical downscaling).
#### Model elements (multiple choices)
- [ ] Cross-shore: model the shoreline position for each transect independently.
- [x] Long-shore: incorporate the interaction of shoreline position across different transects.
- [x] Sea level: consider the impact of sea level rise on shoreline position.

### References
In-line links above e.g.
[Short and Trembanis 2004](https://bioone.org/journals/journal-of-coastal-research/volume-20/issue-2/1551-5036(2004)020%5b0523%3aDSPIBO%5d2.0.CO%3b2/Decadal-Scale-Patterns-in-Beach-Oscillation-and-Rotation-Narrabeen-Beach/10.2112/1551-5036(2004)020[0523:DSPIBO]2.0.CO;2.short)
