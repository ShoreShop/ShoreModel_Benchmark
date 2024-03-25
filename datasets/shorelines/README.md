**Shoreline datasets**
- `shorelines_obs.csv`: Shoreline position between 1987 and 2018 for model calibration/training for each transect. 
- `shorelines_target_short.csv`: Target dates of short-term shoreline prediction, shoreline position values need to be filled with model prediction.
- `shorelines_target_long.csv`: Target dates of long-term shoreline prediction including the shoreline position for 1950, other missing shoreline position values need to be filled with model prediction.
- `shorelines_groundtruth.csv`: Groundtruth data from phtogrammetry.

Each of these files follows the same structure:
- **Datetime**: Datetime in UTC+00:00
- **Transect#**: Shoreline positions for Transect#


| Datetime               | Transect1 | Transect2 | Transect3 | Transect4 | Transect5 | Transect6 | Transect7 | Transect8 | Transect9 |
|------------------------|-----------|-----------|-----------|-----------|-----------|-----------|-----------|-----------|-----------|
| 1987-05-22 23:08:08    | 193.596313| 193.206069| 183.484031| 182.999537| 178.345458| 182.781619| 182.423618| 180.652317| 184.611496|
| 1987-09-11 23:10:29    | 210.681254| 211.017242| 208.327198| 208.519306| 192.358667| 188.768767| 183.809033| 175.184561| 176.438575|
| 1987-09-27 23:10:51    | 216.590212| 218.646195| 219.003388| 210.751201| 201.107611| 203.260943| 195.617559| 177.395789| NaN       |
| 1987-11-14 23:11:47    | 204.220877| 199.040433| 200.969868| 199.910419| 187.276875| 191.465551| 180.601306| 167.144832| 170.410094|
| 1988-02-18 23:13:23    | 195.191788| 187.487088| 197.401703| 193.596704| 199.793985| 193.661102| 193.167045| 191.399071| 195.001288|
| ...                    | ...       | ...       | ...       | ...       | ...       | ...       | ...       | ...       | ...       |
| 2018-09-16 23:43:20    | 213.394475| 208.873642| 207.614407| 200.922483| 189.609754| 197.508301| 186.292343| 175.528700| NaN       |
| 2018-10-18 23:43:58    | NaN       | 205.638208| 204.622951| 195.457303| 201.689672| 196.422823| 190.711102| 184.904075| NaN       |
| 2018-11-03 23:44:02    | 204.162356| 198.982894| 192.175758| 202.318754| 199.186722| 191.612484| 190.450079| 181.909032| 185.167295|
| 2018-11-11 23:40:18    | 207.899633| NaN       | NaN       | 202.668012| 205.670864| 198.775827| 187.910613| 179.173260| 189.710822|
| 2018-12-29 23:39:00    | NaN       | 200.380261| 198.665360| 201.163941| 195.283675| 202.880374| 198.586605| 195.795065| NaN       |
