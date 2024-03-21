# Shoreshop_Benchmark
This repository is a testbed for shoreline modeling algorithms. It contains all benchmark datasets, input files, evaluation codes and evaluation results.

## Background and Objectives
Both hybrid and data-driven models have been developed to predict the shoreline change in response to waves conditions at different temporal scales. 
The first ShoreShop 1.0 ([Blind testing of shoreline evolution models](https://www.nature.com/articles/s41598-020-59018-y)) in 2018 blindly tested 19 shoreline models to predict shoreline position in four-years' period.
Standing on the succuss of the ShoreShop 1.0 and considering the fast development of data-driven models and the surge of shoreline measurements, in the ShoreShop 2.0, we want to showcase the diversity of different methods that can be used to predict the shoreline change.
By incorporating the core features of ShoreShop1.0, especially the blind test element, the ShoreShop 2.0 also aims at understanding:
1. The applicability of shoreline models given cost-free datasets (e.g. satellite-derived shorelines and hindcasts of waves).
2. The potential of shoreline models for long-term (i.e. 50 years) in addition to short-term (i.e. 5 years) prediction.
3. The longshore variance of shoreline model accuracy.

### Notebooks

The following notebooks are available in this repo:
- [1_preprocess_datasets.ipynb](https://github.com/kvos/SDS_Benchmark/blob/main/1_preprocess_datasets.ipynb): download and preprocesse the grountruth data at the four benchmark sites.
- [2_check_shoreline_accuracy.ipynb](https://github.com/kvos/SDS_Benchmark/blob/main/2_check_shoreline_accuracy.ipynb): compare your satellite-derived shoreline time-series against the groundtruth (adjust to read your submission files).
- [3_evaluate_submissions_Landsat_MSL.ipynb](https://github.com/kvos/SDS_Benchmark/blob/main/3_evaluate_submissions_Landsat_MSL.ipynb): evaluate all the submissions using Landsat against the MSL contour.
- [4_evaluate_Landsat_vs_Sentinel2.ipynb](https://github.com/SatelliteShorelines/SDS_Benchmark/blob/main/4_evaluate_Landsat_vs_S2.ipynb): evaluate the time-series obtained from Landsat and Sentinel-2 for the submissions that use individual images (no composites).
- [5_evaluate_wave_correction.ipynb](https://github.com/SatelliteShorelines/SDS_Benchmark/blob/main/5_evaluate_wave_correction.ipynb): evaluate the effect of adding a wave-setup correction.

## Task description
### Beach_X
The target site in this workshop is a real beach (Beach_X) in the world. But for the purpose of blind test, we wiped out the geographical information about this site.\
The only information we know is that this is a east-facing sandy beach. The mean grain size ***D50 ≈ 0.3 mm***.\
9 shore-normal transects are defined from North to South with 100 m longshore distance to quantify the shoreline position. The coordinates for the landward and seaward ends of transects are provided in `transects_coords.csv`.
The coords in this file were originally in local coordinate system and intentionally shifted but not distorted nor rotated, so these coords are still in easting and northing with unit of meter but they do not tell the location of the beach in the real world.

<img src="figures/transects.jpg" width="200">

### Tasks
Given the shoreline position data in 1950 and in the 1987~2018 period and as well as the wave data in the 1950~2024 period, this workshop includes two tasks:

- ***Task1-Shortterm prediction***: Predict shoreline position at the target datetimes between 2018 and 2024 with timestep about two-weeks.
- ***Task2-Longterm prediction***: Predict shoreline position at the target dateimtes between 1950 and 1987 with timestep about 10 years interval.

### Modeling rules
- Participants may use any type of model including but not limited to hydrid and data-driven models.
- Participants need to complete at least 1 task but it is encouraged to attempt both two tasks.
- Participants must provide a short description to the method used. 
- It is optional to submit the codes for the methods used.


### Evaluation
The target transects used for evaluation include Transects 1, 4 and 7 in the North end, the middle and the South end of the beach respectively.\
For each of these transects, the model prediction will be evaluated against the hidden shoreline data at target datetimes. \
[Taylor diagram](https://en.wikipedia.org/wiki/Taylor_diagram) (consisting NMSE, Correlation and STD) will be used to visualize and compare the model performance for each of the target transect.\
 ***(What is the exat scoring metrics? Need a discussion.)***

## Input data
The following files are provided for shoreline prediction.
- `shorelines_obs_short.csv`: Shoreline position between 1987 and 2018 for model calibration/training for each transect. 
- `shorelines_target_short.csv`: Target dates of short-term shoreline prediction, shoreline position values need to be filled with model prediction.
- `shorelines_target_long.csv`: Target dates of long-term shoreline prediction including the shoreline position for 1950, other missing shoreline position values need to be filled with model prediction.
- `Wave data (Hs.csv, Tp.csv, Dp.csv)`: Hindcast significant wave height, peak wave period and peak wave direction between 1979 and 2024 for each transect.
The following constants are also provided.
- `Depth of wave data`: 10 (m)
- `Mean grain size D50`: 0.3 (mm)


### Shoreline
Shoreline data used in this workshop is derived from publich satellite (Landsat 5, 7, 8&9) images with [CoastSat](https://github.com/kvos/CoastSat) — a public toolbox. \
The satellite derived shoreline (SDS) data for model calibration/training starts from 1987 and ends at 2018 with 455 inequal time steps. \
The shoreline position (m) is defined as the distance between the landward end of a transect to the intersection of the shoreline and the transect. \
The table below shows some records of shoreline position data. The first colum shows the time of the record. Columns 2 to 10 are the shoreline position for each trasect respectively.

| Datetime            | Transect1 | Transect2 | Transect3 | Transect4 | Transect5 | Transect6 | Transect7 | Transect8 | Transect9 |
|---------------------|-----------|-----------|-----------|-----------|-----------|-----------|-----------|-----------|-----------|
| 1987-05-22 23:08:08 | 193.596313| 193.206069| 183.484031| 182.999537| 178.345458| 182.781619| 182.423618| 180.652317| 184.611496|
| 1987-09-11 23:10:29 | 210.681254| 211.017242| 208.327198| 208.519306| 192.358667| 188.768767| 183.809033| 175.184561| 176.438575|
| 1987-09-27 23:10:51 | 216.590212| 218.646195| 219.003388| 210.751201| 201.107611| 203.260943| 195.617559| 177.395789| NaN       |
| ...                 | ...       | ...       | ...       | ...       | ...       | ...       | ...       | ...       | ...       |
| 2018-11-03 23:44:02 | 204.162356| 198.982894| 192.175758| 202.318754| 199.186722| 191.612484| 190.450079| 181.909032| 185.167295|
| 2018-11-11 23:40:18 | 207.899633| NaN       | NaN       | 202.668012| 205.670864| 198.775827| 187.910613| 179.173260| 189.710822|
| 2018-12-29 23:39:00 | NaN       | 200.380261| 198.665360| 201.163941| 195.283675| 202.880374| 198.586605| 195.795065| NaN       |

Satellite derived shoreline position data matches the field survey data in the Beach_X very well.
<img src="figures/shorelines_temporal.jpg" width="200">


### Wave data
The nearshore wave data used in this workshop was obtained by downscaling offshore directional wave spectra to nearshore areas.
The offshore wave data is from the [CAWCR Wave Hindcast](https://data.csiro.au/collection/csiro:39819) produced by CSIRO. 
The [BinWaves](https://www.sciencedirect.com/science/article/pii/S1463500324000337) was applied for wave downscaling.
The significant wave height (Hs), peak wave period (Tp) and peak wave direction (Dp) were extracted along each shore-normal transect at 10 (m) depth contour with daily interval from 1979 to 2023.
<img src="figures/wave_roses.jpg" width="200">

## Outputs and Deliverables

Each team should fill the missing values in the `shorelines_target_short.csv` and/or the `shorelines_target_long.csv` and rename these two files into `shorelines_prediction_short.csv` and `shorelines_prediction_long.csv` respectively.
The `submission` folder will contain the shoreline change time-series from the different participating teams. An example of submission is provided in the `example_submission` folder. 


## How to submit

To submit your results, please:
(steps 4&5 are optional for participants to share the codes)

1. [fork](https://github.com/SatelliteShorelines/SDS_Benchmark/fork) this repository;
2. Create a subfolder in the submission folder and name as 'ModelName_AuthorInitials';
3. Copy `shorelines_prediction_short.csv` and/or `shorelines_prediction_long.csv` into the created folder in step 2;
4. Create a subfolder in the algorithm folder and name as 'ModelName_AuthorInitials';
5. Copy your commented code as well as a README.md with instructions on how to run the code to reproduce the outputs into the created folder in step 4 \;
6. Create a [Pull request](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request-from-a-fork) to the original repository to submit your results.


If you need any help with this submission, please post in the [GitHub Issues](https://github.com/SatelliteShorelines/SDS_Benchmark/issues) page.

### Deadline

The deadline for this first round of analysis is the end of the year (**01/12/2022**).

## Questions and Comments

Please put any questions on the [GitHub Issues](https://github.com/SatelliteShorelines/SDS_Benchmark/issues) page so that everybody can read/comment.

## Acknowledgements

We acknowledge the Killian Vos and Laura Cagigal for sharing the CoastSat and BinWaves codes.
We also ac' creators of this repository which was used as a template: https://github.com/gwmodeling/challenge
