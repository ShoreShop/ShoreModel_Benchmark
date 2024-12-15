import os

import datetime
import pandas as pd
import numpy as np
from scipy.fft import fft
import string

from sklearn.metrics import r2_score, mean_squared_error
import skill_metrics as sm
from sklearn.metrics import r2_score


def cal_metrics(df_ref, df_model, norm=True):
    
    '''
    This function calculates std, corr and crmse
    
    Input:
    df_ref: DataFrame for reference (obs/target)
    df_model: DataFrame for model (calibration/prediction)
    norm: Apply normalization (default=True)
    
    Output:
    std: (Normalized) standard deviation
    corr: Correlation coefficient
    crmse: (Normalized) centered root mean sequare error
    score: Distance to target in the Taylor diagram (Loss)
    '''
    
    # Extract the model result at time points fo reference
    df_ref = df_ref.loc[(~df_ref.isna()).any(1), :]
    df_model = df_model.resample('1D').interpolate().reindex(df_ref.index, method='nearest')
    #m_idx = df_model.index.intersection(df_ref.index)

    # Take average for transects
    ref = df_ref.to_numpy().reshape(-1)
    model = df_model.to_numpy().reshape(-1)
    
    std0 = np.nanstd(ref)
    std = np.nanstd(model)
    corr = np.corrcoef(model, ref)[0, 1]
    crmse = sm.centered_rms_dev(model,ref)
    rmse = sm.rmsd(model,ref)
    
    if norm==True:
        std = std/std0
        crmse = crmse/std0
        rmse = rmse/std0
    
    loss = np.sqrt((1-std)**2+(1-corr)**2+(0-rmse)**2)
    
    return {'std':std, 'corr':corr, 'crmse':crmse, 'loss':loss}

def mielke_lambda(observed, model):
    N = len(observed)
    
    # Calculate means
    mean_obs = np.mean(observed)
    mean_model = np.mean(model)
    
    # Calculate variances
    var_obs = np.var(observed)
    var_model = np.var(model)
    
    # Calculate the squared difference term
    squared_diff = np.mean((observed - model) ** 2)
    
    # Compute the lambda value
    lambda_value = 1 - (squared_diff / (var_obs + var_model + (mean_obs - mean_model) ** 2))
    
    return lambda_value

def percentile_mean(data, lower_percentile, upper_percentile, axis=None):
    """
    Calculate the mean of values within a specified percentile range along a given axis.
    
    Parameters:
    - data: NumPy array, the input data.
    - lower_percentile: float, the lower bound percentile (0-100).
    - upper_percentile: float, the upper bound percentile (0-100).
    - axis: int or None, the axis along which to compute the percentile mean. 
            If None, it flattens the array and computes over the entire data.
    
    Returns:
    - percentile_mean: the mean of values within the specified percentile range.
    """
    
    # Compute the percentile bounds
    lower_bound = np.nanpercentile(data, lower_percentile, axis=axis, keepdims=True)
    upper_bound = np.nanpercentile(data, upper_percentile, axis=axis, keepdims=True)
    
    # Create a mask for values within the percentile range
    mask = (data >= lower_bound) & (data <= upper_bound)
    
    # Apply the mask and calculate the mean along the specified axis
    filtered_data = np.where(mask, data, np.nan)  # Set values outside the range to NaN
    return np.nanmean(filtered_data, axis=axis)

def fluctuation_frequency(series):
    # Apply FFT and get the magnitudes of the frequencies
    fft_values = np.abs(fft(series.values))
    # Sum the magnitudes of the high-frequency components (ignoring the zero frequency)
    return np.sum(fft_values[1:])  # Exclude the first element which is the DC component (mean)