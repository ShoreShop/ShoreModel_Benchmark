## Get Started
### Setup environment
```
conda create -n ShoreFor
conda activate ShoreFor
conda install -c conda-forge matplotlib numpy pandas statsmodels scipy scikit-learn
```
### Run ShoreFor model
1. Change directory
```
cd ShoreModel_Benchmark/algorithms/ShoreFor
```
2. Run model with default arguments
```
python shorefor.py
```
3. Check help for arguments available
```
python shorefor.py -h
```
4. Run script with specific arguments
-fp_in: Input file path\
-fp_out: Output file path\
-ST: Start time\
-ETT: End time for training\
-ETP: End time for prediction\
```
python shorefor.py -fp_in {} -fp_out {} -ST {} -ETT {} -ETP {}
```
