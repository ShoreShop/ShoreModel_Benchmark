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
-STT: Start time for training\
-ETT: End time for training\
-STSP: Start time for short-term prediction\
-ETSP: End time for short-term prediction\
-STMP: Start time for medium-term prediction\
-ETMP: End time for medium-term prediction\
-STLP: Start time for long-term prediction\
-ETLP: End time for long-term prediction
```
python shorefor.py -fp_in {} -fp_out {} -STT {} -ETT {} -STSP {} -ETSP {} -STMP {} -ETMP {} -STLP {} -ETLP {}
```
