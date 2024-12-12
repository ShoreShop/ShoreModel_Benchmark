# Submission of prediction results

This folder contains the resubmitted shoreline prediction results after ShoreShop2.0.

Examples of submission are provided in the `ShoreFor`. There is one folder per model and each folder contains the files below:
- `README.md`: contains the description of the model
- `shorelines_prediction_short.csv`: contains the short-term shoreline prediction.
- `shorelines_prediction_medium.csv`: contains the medium-term shoreline prediction.
- `shorelines_prediction_long.csv`: contains the long-term shoreline prediction.


## Format of description
The `README.md` file contains the model description which includes three main parts.
1. **Model description**: explains the main concepts of the model
2. **Model implementation**: explains the workflow of using the input data to produce long-term and short-term predictions
3. **Model labelling**: tick box for model characteristics to facilitate model classification

#### Model mechanics
- [ ] Process-Based Models (PBM): couple hydrodynamics, waves, and morphodynamics through mass and momentum conservation laws.
- [ ] Hybrid Models (HM): use observational data to calibrate free parameters in the equilibrium configuration of a system.
- [ ] Data-Driven Models (DDM): use observational data to train regression models (e.g. machine learning, statistical downscaling).
#### Model elements
- [ ] Cross-shore: model the shoreline position for each transect independently.
- [ ] Long-shore: incorporate the interaction of shoreline position across different transects.
- [ ] Sea level: consider the impact of sea level rise on shoreline position.

An example of README file is provided for ShoreFor under `/submissions/ShoreFor/README.md`.



## Format of predictionoutputs

The `.csv` files contain a column of datetime and a shoreline position column per transect:
- **Datetime**: Datetime in UTC+00:00 with a daily time interval
- **Transect#**: Shoreline positions for Transect#

An example of csv file is provided for ShoreFor under `/submissions/ShoreFor/shorelines_prediction_short.csv`.


| Datetime   | Transect1            | Transect2            | Transect3            | Transect4            | Transect5            | Transect6            | Transect7            | Transect8            | Transect9            |
|------------|----------------------|----------------------|----------------------|----------------------|----------------------|----------------------|----------------------|----------------------|----------------------|
| 1987-01-01 | 205.11891124323904   | 204.08758882666254   | 202.13085258743203   | 196.0803359484226    | 191.45061977131854   | 192.19580155837912   | 188.9250340205432    | 181.18928571858038   | 186.1579163228854    |
| 1987-01-02 | 204.96795060773775   | 203.89685722156625   | 201.9861879622457    | 196.00855816341195   | 191.4088724799744    | 192.17626593099686   | 188.8536051845174    | 181.34124192506576   | 186.26790913355129   |
| 1987-01-03 | 204.49541279316261   | 203.30074133873066   | 201.5327261308358    | 195.77939759832606   | 191.2724461464227    | 192.11240926928244   | 188.52548726304047   | 181.8269282636832    | 186.62048483455578   |
| 1987-01-04 | 203.73068219799922   | 202.33639762989486   | 200.7978806583673    | 195.40535829017648   | 191.04777253177662   | 192.00695825072114   | 188.08705149212935   | 182.621923462988     | 187.19839638237983   |
| 1987-01-05 | 203.21089345468576   | 201.6808932287746    | 200.29720338326715   | 195.1491510566559    | 190.89275913934344   | 191.9337614290439    | 188.15802321712619   | 183.16648726079416   | 187.59364107073932   |

## How to submit

1. [fork](https://github.com/yongjingmao/ShoreModel_Benchmark/fork) this repository;
   - Begin by forking the original workshop repository to your GitHub account.
2. Create a Submission Folder:
   - Inside the resubmission folder, create a subfolder named ModelName_AuthorInitials. Replace ModelName with the name of your model and AuthorInitials with your initials.
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
