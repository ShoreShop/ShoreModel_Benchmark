# ShoreShop 2.0: Advancements in Shoreline Change Prediction Models
This repository is a testbed for shoreline modelling algorithms. It contains all benchmark datasets, input files, codes, and results.

## Background and Objectives
### Background
Shoreline change prediction has witnessed the evolution of both hybrid and data-driven models, offering valuable insights into how coastlines respond to varying wave conditions across different timescales. Building on the success of the ShoreShop 1.0 ([Blind testing of shoreline evolution models](https://www.nature.com/articles/s41598-020-59018-y)) in 2018, which tested 19 shoreline models in predicting shoreline positions over a four-year period, ShoreShop 2.0 aims to further explore and showcase the evolution of predictive methods.
### Objectives
- **Diverse Methodology Showcase**: With the rapid advancements in data-driven models and the increasing availability of shoreline measurements, ShoreShop 2.0 intends to highlight the diversity of methods available for predicting shoreline changes.
- **Blind Testing Element**: Drawing inspiration from ShoreShop 1.0, ShoreShop 2.0 retains its core feature of blind testing to provide unbiased evaluations of the predictive models.
- **Key Focus Areas**:
  1. Assessing the performance of shoreline models using freely available datasets such as satellite-derived shorelines and modelled wave conditions.
  2. Evaluating the capabilities of shoreline models for short-term (5 years) and medium-term (50 years) predictions while discussing their potential long-term predictions (80 years).
  3. Investigating the variability in shoreline model accuracy along the coastlines of an embayed beach.

Join us at ShoreShop 2.0 to learn about the latest advancements, share insights, and foster collaborative efforts in shoreline change prediction.

### Notebooks

The following notebooks are available in this repo:
- [1.data_explore.ipynb](https://github.com/yongjingmao/ShoreModel_Benchmark/blob/main/1.data_explore.ipynb): explore the input transect, shoreline and wave data.
- [2.model_compare.ipynb](https://github.com/yongjingmao/ShoreModel_Benchmark/blob/main/2.model_compare.ipynb): compare and evaluate all the submitted model predictions against the target shoreline positions.

## Task description
### Beach_X
A real-world Beach_X serves as the target site for this workshop. To ensure a blind test, all geographical information regarding this beach has been intentionally removed. \
What we do know is that Beach_X is an east-facing embayed sandy beach with a mean grain size ***D50 ≈ 0.3 mm***.\
9 shore-normal transects are established from North to South with a 100-meter longshore distance to measure shoreline position. The coordinates for the landward and seaward ends of transects are provided in `transects_coords.csv`.
These coordinates are in a local coordinate system, deliberately shifted (not distorted or rotated), and are expressed in easting (x) and northing (y) with a unit of meters. They do not reveal the actual geographical location of Beach_X.

<img src="figures/transects.jpg" width="400">

### Tasks
Given two years shoreline position data in the 1999-2018 period, along with the shoreline position in 1950 as well as wave and sea level data spanning from 1950 to 2100, participants are tasked with:

- ***Task1.Short-term prediction***: Predict the shoreline position between **2019-01-01 and 2023-12-31** with **daily** timestep.
- ***Task2.Medium-term prediction***: Predict the shoreline position between **1951-05-01 and 1998-12-31** with **daily** timestep.
- ***Task3.Long-term prediction***: Predict the shoreline position between **2019-01-01 and 2100-12-31** with **daily** timestep (no evaluation).

### Evaluation
- **Target transects**: The target transects used for evaluation include ***Transects 2, 5 and 8*** in the North end, the middle and the South end of the beach respectively.
- **Target shorelines**: For each target transect, the model prediction will be evaluated against the observed shoreline data at target datetimes. The target datetimes for short-term and medium-term tasks are in `shorelines_target_short.csv` and `shorelines_target_medium.csv`. For blind testing, the observed shoreline data in the target window will be withheld for all participants. The long-term prediction will **not** be evaluated, and the results are only for discussion.
- **Evaluation metrics**: [Taylor diagram](https://en.wikipedia.org/wiki/Taylor_diagram) (consisting of root-mean-square-error (RMSE), Correlation and standard deviation (STD)) will be used to visualize and compare the model performance for each of the target transect.\
RMSE and STD of prediction are normalized by dividing them by the STD of the observation (target). This ensures that all three statistical parameters in the diagram fall within the range of [0, 1]. The distance $Dist_{i}$ between the model points and the target point (the black triangle) in the Taylor diagram is calculated for each target transect. The average distance across all target transects $Dist_{avg}$ serves as the final metric for ranking the model performance. A smaller distance indicates better model performance.
  
$$ RMSE_{norm} = \frac{RMSE_{pred}}{STD_{targ}},   STD_{norm} = \frac{STD_{pred}}{STD_{targ}}$$

$$ Dist_i = \sqrt{(0-RMSE_{norm})^2+(1-Corr)^2+(1-STD_{norm})^2} $$
  
$$ Dist_{avg} = \frac{1}{n} \sum_{i=1}^n Dist_i $$
  
  
<img src="figures/TaylorDiagram.jpg" width="1500">

### Modeling rules
- Participants should not attempt to locate and retrieve extra shoreline information beyond that provided for Beach_X.
- Participants may use any type of model, including but not limited to hybrid and data-driven models.
- Participants must complete at least one task, although attempting both is encouraged.
- Participants must provide a brief description of the methodology used. 
- Code submission is optional.

## Input data
The following files are provided for shoreline prediction.
- `shorelines_obs.csv`: Shoreline position between 1999 and 2018 for model calibration/training for each transect. 
- `shorelines_target_short.csv`: Target dates where short-term shoreline prediction will be evaluated.
- `shorelines_target_medium.csv`: Target dates where medium-term shoreline prediction will be evaluated. The shoreline position for 1950 is also provided as context for prediction.
- `Hindcast wave data (Hs.csv, Tp.csv, Dir.csv)`: Hindcast significant wave height, peak wave period and mean wave direction between 1950 and 2024 for each transect. Hindcast wave data can be used for short-term and medium-term shoreline modelling.
- `Longterm wave data (Hs.csv, Tp.csv, Dir.csv)`: Historical (1980-2005) and forecast (2006-2100) significant wave height, peak wave period and mean wave direction between 2005 and 2100 for each transect. Longterm wave data can be used for long-term shoreline modelling.
- `Sea level data (SLR_obs.csv, SLR_proj.csv)`: Annually mean of sea level between 1980 and 2100, including the gauge measurement (1980-2018) and the projections (2019-2100) under RCP4.5 and 8.5 scenarios.
  
The following constants are also provided.
- `Depth of wave data`: 10 (m)
- `Mean grain size D50`: 0.3 (mm)


### Shoreline
The shoreline data (`shorelines_obs.csv`) utilized in the ShoreShop 2.0 workshop is derived from public satellite images captured by Landsat 5, 7, 8, and 9 satellites. This data has been processed using [CoastSat](https://github.com/kvos/CoastSat), a public toolbox specifically designed for coastline analysis. \
The satellite-derived shoreline (SDS) data for model calibration/training starts from 1999 and ends at 2018 with 347 time steps. \
The shoreline position (m) is defined as the distance from the landward end of a transect to the intersection of the shoreline and the transect. \
All the shorelines have been corrected to reflect the instantaneous position at Mean Sea Level.\
The satellite-derived shoreline position data exhibits a high level of accuracy and closely aligns with the ground truth data for Beach_X, ensuring reliable model calibration and training.

<img src="figures/shorelines_temporal.jpg" width="800">

For short-term shoreline prediction, The `shorelines_target_short.csv` contains the target dates from 2019 to 2023. All shoreline position values are intentionally withheld for all participants. During the evaluation phase, participants' predictions will be compared against the withheld shoreline position data from the SDS dataset.

For medium-term shoreline prediction, `shorelines_target_medium.csv` provides shoreline data for the date 1st May 1951, serving as the context data for the medium-term prediction task. Additional target dates are included for medium-term prediction. Participants' predictions will be evaluated against photogrammetry (pre-1989) and SDS (1989-1998) data available for the respective target dates.

### Hindcast Wave data
The nearshore wave data used in this workshop was obtained by downscaling offshore directional wave spectra to nearshore areas.
The offshore wave data is from the [CAWCR Wave Hindcast](https://data.csiro.au/collection/csiro:39819) produced by CSIRO. 
The [BinWaves](https://www.sciencedirect.com/science/article/pii/S1463500324000337) approach was applied for wave downscaling.
The significant wave height (Hs), peak wave period (Tp) and mean wave direction (Dir) were extracted along each shore-normal transect at 10 (m) depth contour with a daily interval from 1979 to 2023. Wave roses for the three target transects are shown below to demonstrate the minimal longshore variation of wave conditions.

<img src="figures/wave_roses.jpg" width="800">

### Longterm Wave data
A short introduction to forecast wave data\
The historical data in the long-term folder is slightly different from the hindcast wave data in the same period. Therefore, re-train/re-calibration can be necessary for data-driven and hybrid models to predict long-term shoreline position.


### Sea level rise data
`SLR_obs.csv` contains the annual sea level data from gauge measurement (1980-2018). `SLR_proj.csv` contains the projection under the RCP 4.5 and 8.5 scenarios (2019-2100). Both the measurement and the projection are relative to the mean of the observation. 
The projection data is from NASA's [SEA LEVEL PROJECTION TOOL](https://sealevel.nasa.gov/ipcc-ar6-sea-level-projection-tool), which is based on the regional sea level projections provided in the IPCC 6th Assessment Report (AR6). Sea level is the same for all transects.

<img src="figures/SLR_ts.jpg" width="500">

### Bathymetry data
Similar to the vast majority of beaches worldwide, Beach_X does not have nearshore bathymetry data available. Therefore, participants are challenged to adapt their models accordingly, as this workshop emphasizes evaluating shoreline model performance using freely accessible datasets.

## Outputs and Deliverables

Participants should provide short-term, medium-term and long-term model predictions for **all transects** as `shorelines_prediction_short.csv`, `shorelines_prediction_medium.csv`, and `shorelines_prediction_long.csv`.\
Both the short-term and medium-term model predictions should have **daily interval**. For models that do not generate daily outputs, please interpolate the results to daily.\
All prediction submissions should be placed in the designated submission folder.
The submission folder will have shoreline predictions from various participants.
An illustrative example of submission is provided in the `submissions/ShoreFor` folder for reference. 

## Model classification

Participants should copy and check the boxes below in the model description to assist in classifying the submitted model. An example of a model description can be found [here](https://github.com/yongjingmao/ShoreModel_Benchmark/blob/main/submissions/ShoreFor/README.md).

#### Model mechanics
- [ ] Process-Based Models (PBM): couple hydrodynamics, waves, and morphodynamics through mass and momentum conservation laws.
- [ ] Hybrid Models (HM): use observational data to calibrate free parameters in the equilibrium configuration of a system.
- [ ] Data-Driven Models (DDM): use observational data to train regression models (e.g. machine learning, statistical downscaling).
#### Model elements
- [ ] Cross-shore: model the shoreline position for each transect independently.
- [ ] Long-shore: incorporate the interaction of shoreline position across different transects.
- [ ] Sea level: consider the impact of sea level rise on shoreline position.
 

## How to submit

To submit your results, please:

1. [fork](https://github.com/yongjingmao/ShoreModel_Benchmark/fork) this repository;
   - Begin by forking the original workshop repository to your GitHub account.
2. Create a Submission Folder:
   - Inside the submission folder, create a subfolder named ModelName_AuthorInitials. Replace ModelName with the name of your model and AuthorInitials with your initials.
3. Place Your Prediction Files:
   - Copy your completed prediction files (`shorelines_prediction_short.csv`, `shorelines_prediction_medium.csv` and/or `shorelines_prediction_long.csv`) into the subfolder created in Step 2.
4. Provide Your Model Description (an example is [here](https://github.com/yongjingmao/ShoreModel_Benchmark/blob/main/submissions/ShoreFor/README.md)):
   - Include a README.md file providing a clear description of the model you used.
   - Copy and complete the model classification checkboxes to the README.md.
5. Include Your Code (Optional):
   - Create another subfolder within the algorithm folder named ModelName_AuthorInitials.
   - Copy your commented code into this subfolder.
   - Include a README.md file providing clear instructions on how to run your code to reproduce the prediction outputs.
6. Submit Your Results:
   - Create a [Pull request](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request-from-a-fork) to the original workshop repository to submit your prediction results and optional code.

If you need any help with this submission, please post on the [GitHub Issues](https://github.com/yongjingmao/ShoreModel_Benchmark/issues) page.

### Deadline

The deadline for the submission is the end of the year (**01/10/2024**).

## Questions and Comments

Please put any questions on the [GitHub Issues](https://github.com/yongjingmao/ShoreModel_Benchmark/issues) page so that everybody can read/comment.

## Acknowledgements

We acknowledge the Killian Vos and Laura Cagigal for sharing the CoastSat and BinWaves codes.
