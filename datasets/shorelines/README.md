**Shoreline datasets**
- `shorelines_obs.csv`: Shoreline position between 1987 and 2018 for model calibration/training for each transect. 
- `shorelines_target_short.csv`: Target dates of short-term shoreline prediction, shoreline position values need to be filled with model prediction.
- `shorelines_target_medium.csv`: Target dates of medium-term shoreline prediction including the shoreline position for 1950, other missing shoreline position values need to be filled with model prediction.
- `shorelines_groundtruth.csv`: Groundtruth data from phtogrammetry.

Each of these files follows the same structure, below is the example for `shorelines_obs.csv`:
- **Datetime**: Datetime in UTC+00:00
- **Transect#**: Shoreline positions for Transect#


| Datetime               | Transect1 | Transect2 | Transect3 | Transect4 | Transect5 | Transect6 | Transect7 | Transect8 | Transect9 |
|------------------------|-----------|-----------|-----------|-----------|-----------|-----------|-----------|-----------|-----------|
| 1987-05-22 23:08:08    | 193.60    | 193.21    | 183.48    | 183.00    | 178.35    | 182.78    | 182.42    | 180.65    | 184.61    |
| 1987-09-11 23:10:29    | 210.68    | 211.02    | 208.33    | 208.52    | 192.36    | 188.77    | 183.81    | 175.18    | 176.44    |
| 1987-09-27 23:10:51    | 216.59    | 218.65    | 219.00    | 210.75    | 201.11    | 203.26    | 195.62    | 177.40    | NaN       |
| ...                    | ...       | ...       | ...       | ...       | ...       | ...       | ...       | ...       | ...       |
| 2018-11-03 23:44:02    | 204.16    | 198.98    | 192.18    | 202.32    | 199.19    | 191.61    | 190.45    | 181.91    | 185.17    |
| 2018-11-11 23:40:18    | 207.90    | NaN       | NaN       | 202.67    | 205.67    | 198.78    | 187.91    | 179.17    | 189.71    |
| 2018-12-29 23:39:00    | NaN       | 200.38    | 198.67    | 201.16    | 195.28    | 202.88    | 198.59    | 195.80    | NaN       |

