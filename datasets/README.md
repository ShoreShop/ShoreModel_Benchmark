## Input datasets

This folder contains all the input datasets for shoreline models. Each folder contains a README.md file that further describes the dataset

### Coordinates
The coordinates for the landward and seaward ends of transects are provided in `transects_coords.csv`.
These coordinates are in a local coordinate system, deliberately shifted (not distorted or rotated), and are expressed in easting and northing with a unit of meters. \
They do not reveal the actual geographical location of Beach_X.
Columns:
- **ID**: ID of each transect
- **Land_x**: Eastings of landward end of transects
- **Land_y**: Northings of landward end of transects
- **Sea_x**: Eastings of seaward end of transects
- **Sea_y**: Northings of seaward end of transects

| ID        | Land_x      | Land_y      | Sea_x       | Sea_y       |
|-----------|-------------|-------------|-------------|-------------|
| Transect1 | 463.810852  | 880.924590  | 748.408892  | 599.888166  |
| Transect2 | 383.756554  | 792.082469  | 694.641549  | 540.433331  |
| Transect3 | 316.183743  | 699.231069  | 644.833124  | 471.282315  |
| Transect4 | 257.524125  | 610.852678  | 593.043798  | 393.113504  |
| Transect5 | 204.799094  | 527.785536  | 538.509074  | 307.356214  |
| Transect6 | 146.184639  | 442.402003  | 483.870858  | 227.919454  |
| Transect7 | 87.900983   | 342.714416  | 441.075510  | 155.000819  |
| Transect8 | 36.335441   | 234.596687  | 406.417477  | 82.993029   |
| Transect9 | 0.000000    | 129.837061  | 378.240760  | 0.000000    |

### Slope
The beach-face slope along each transect is provided in `slope.csv`.
Columns:
- **ID**: ID of each transect
- **Slope**: Beachface slope
