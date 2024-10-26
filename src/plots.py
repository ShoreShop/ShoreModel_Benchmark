import os

import datetime
import pandas as pd
import numpy as np
from scipy.fft import fft
import string

from sklearn.metrics import r2_score, mean_squared_error

import matplotlib.pyplot as plt
from matplotlib.cm import get_cmap
from matplotlib.colors import ListedColormap
from matplotlib import gridspec
import matplotlib.lines as mlines
import seaborn as sns
import skill_metrics as sm
from sklearn.metrics import r2_score

import matplotlib.patches as mpatches

import plotly.graph_objs as go
from plotly.subplots import make_subplots
import matplotlib.colors as mcolors  # For RGBA to hex conversion
from src.utilities import cal_metrics, mielke_lambda, percentile_mean, fluctuation_frequency

def plot_ts(tran_ids, df_obs=None, dfs_cali=None, df_targ=None, dfs_pred=None, task='cali', 
            output_path=None, zorders=None, colors=None, loss=None):
    
    '''
    This function plot time series of observation, calibration, target and prediction
    
    Input: 
    tran_ids: id of target transects to plot
    df_obs: DataFrame for observation
    dfs_cali: DataFrames for calibration from different models
    df_target: DataFrame for target
    dfs_pred: DataFrames for prediction from different models
    task (cali|medium|short): Type of tasks, choose from calibration, medium-term and short-term predictions
    output_path: Output path to save figure
    '''
    
    fig, axes = plt.subplots(len(tran_ids), 1, figsize=(10, 2.5*len(tran_ids)))
    letters = string.ascii_lowercase # Letters used to label subplots
    if zorders is None:
        zorders = range(len(dfs_pred))
    
    for i, tran_id in enumerate(tran_ids):
        if len(tran_ids) == 1:
            ax = axes
        else:
            ax = axes[i]

        # Add subtitle
        ax.set_title(tran_id)
        # Add label
        ax.text(0.01,0.95, letters[i] + ') ', 
                    bbox=dict(boxstyle="square", ec='k',fc='w',alpha=0.5), 
                    ha='left',va='top', transform=ax.transAxes, zorder=10)
        
        # Plot observation
        if df_obs is not None:
            ax.plot(df_obs.index, df_obs[tran_id], color='k', label='Obs', linestyle='-')

        if (dfs_cali is not None)&(dfs_pred is None):
            # Plot model calibration
            n_items = len(dfs_cali.keys())
            
            for j, model in enumerate(dfs_cali.keys()):
                ax.plot(dfs_cali[model].index, dfs_cali[model][tran_id], 
                        color=colors[model], label=model, linestyle='-')

        if df_targ is not None:
            # Plot target time series
            if len(df_targ)<20:
                fmt='o'
            else:
                fmt='.'
            ax.errorbar(df_targ.index, df_targ[tran_id], color='k', 
                yerr=7, fmt=fmt, zorder=100, alpha=0.8, label='Targ')
            

        if dfs_pred is not None:
            # Plot model prediction
            n_items = len(dfs_pred.keys())
           
            for j, model in enumerate(dfs_pred.keys()):
                if loss is None:
                    model_label =  model
                else:
                    model_label = '{} (Loss:{:.2f})'.format(model, loss[model])
                ax.plot(dfs_pred[model].index, dfs_pred[model][tran_id], 
                        linestyle='-', color=colors[model], label=model_label, 
                        zorder=zorders[model], alpha=1)
                
            ax.set_xlim(dfs_pred[model].index[0], dfs_pred[model].index[-1])


        # Add legend and ylabel for first plot
        if i == 2: 
            ax.legend(ncol=3, bbox_to_anchor=[1, -0.15], loc=1,
                      edgecolor='k', fontsize=8);
            ax.set_ylabel('Shoreline Position (m)')
            
        fig.subplots_adjust(hspace=0.3)

    
    if output_path is not None:
        fig.savefig(output_path, dpi=300, 
                    bbox_inches="tight", pad_inches=0.01)
        print('\nSaved plot to {}'.format(output_path))

    return fig


def plot_ts_interactive(tran_ids, df_obs=None, dfs_cali=None, df_targ=None, dfs_pred=None, task='cali', 
                        output_path=None, zorders=None, colors=None, loss=None):
    '''
    This function plots interactive time series of observation, calibration, target, and prediction.
    
    Input: 
    tran_ids: id of target transects to plot
    df_obs: DataFrame for observation
    dfs_cali: DataFrames for calibration from different models
    df_target: DataFrame for target
    dfs_pred: DataFrames for prediction from different models
    task (cali|medium|short): Type of tasks, choose from calibration, medium-term, and short-term predictions
    output_path: Output path to save figure (optional)
    colors: Dictionary of model names to RGBA color arrays
    '''
    
    if zorders is None:
        zorders = range(len(dfs_pred))
    
    # Create subplots with one row per transect
    fig = make_subplots(rows=len(tran_ids), cols=1, shared_xaxes=True, 
                        vertical_spacing=0.05, subplot_titles=tran_ids)
    
    letters = string.ascii_lowercase
    
    for i, tran_id in enumerate(tran_ids):
        show_legend = True if i == 0 else False  # Only show the legend in the first subplot

        # Plot observation
        if df_obs is not None:
            fig.add_trace(
                go.Scatter(x=df_obs.index, y=df_obs[tran_id], mode='lines', 
                           name=f'Obs', line=dict(color='black'), 
                           legendgroup='Obs', showlegend=show_legend, visible='legendonly'),
                row=i+1, col=1
            )
        
        # Plot calibration (if no prediction is provided)
        if (dfs_cali is not None) & (dfs_pred is None):
            for model in dfs_cali.keys():
                color_hex = mcolors.to_hex(colors[model])  # Convert RGBA to hex
                fig.add_trace(
                    go.Scatter(x=dfs_cali[model].index, y=dfs_cali[model][tran_id], 
                               mode='lines', name=f'Cali {model}', 
                               line=dict(color=color_hex), 
                               legendgroup=f'Cali {model}', showlegend=show_legend, visible='legendonly'),
                    row=i+1, col=1
                )
        
        # Plot target (default visibility)
        if df_targ is not None:
            target_fmt = 'markers' if len(df_targ) < 20 else 'lines+markers'
            fig.add_trace(
                go.Scatter(x=df_targ.index, y=df_targ[tran_id], mode=target_fmt, 
                           name=f'Targ', error_y=dict(type='data', array=[7]*len(df_targ)), 
                           line=dict(color='black', dash='dot'),
                           legendgroup='Targ', showlegend=show_legend, visible=True),
                row=i+1, col=1
            )
        
        # Plot prediction
        if dfs_pred is not None:
            for model in dfs_pred.keys():
                if loss is None:
                    model_label =  model
                else:
                    model_label = '{} (Loss:{:.2f})'.format(model, loss[model])
                color_hex = mcolors.to_hex(colors[model])  # Convert RGBA to hex
                fig.add_trace(
                    go.Scatter(x=dfs_pred[model].index, y=dfs_pred[model][tran_id], 
                               mode='lines', name=f'{model_label}', 
                               line=dict(color=color_hex),
                               legendgroup=f'{model}', showlegend=show_legend, visible='legendonly'),
                    row=i+1, col=1
                )

    # Update layout for better visualization
    fig.update_layout(
        height=300 * len(tran_ids), width=1000,
        title_text=f"Time Series for {task.capitalize()} Task",
        hovermode="x unified",
        showlegend=True
    )

    # Update x-axis title for all subplots
    fig.update_xaxes(title_text='Date', row=len(tran_ids), col=1)
    
    # Add overall y-axis label for the middle subplot
    fig.update_yaxes(title_text='Shoreline Position (m)', row=len(tran_ids)//2 + 1, col=1)
    
    # Save the figure if an output path is provided
    if output_path is not None:
        fig.write_image(output_path)
        print(f'Saved interactive plot to {output_path}')

    return fig

def plot_taylor(metrics, model_types, colors, legend='Invidivual',  aver_scores=None, ax=None):
    
    '''
    This function plots Taylor diagram based metrics
    
    Input:
    metrics (dict): Metrics to plot in the diagram   
        -Format of metrics:
        -metrics = {
            'Observation/Target': metric_dict
            'Calibration/Prediction':{
            'model1': metric_dict,
            'model2': metric_dict,
                }
            }

    legend (string): The style of legend ('Individual'|'Average'|None)
        - None: No legend plotted
        -'Individual': Label each subplot based on the score for the individual transect
        -'Average': Label the first subplot with the average score (need to provide the average score)
    aver_scores (series): The average score for each model
    ax: Ax used for plot    
    
    Output:
    ax: Ax with plot
    '''
    
    
    # Set variables for plot
    
    MARKERS = {
    'HM': '*',
    'DDM':'o',
    'PBM': 'd',
    'ENS': 's',
    }

    # specify some styles for the correlation component
    COLS_COR = {
        'grid': '#DDDDDD',
        'tick_labels': '#000000',
        'title': '#000000'
    }

    # specify some styles for the standard deviation
    COLS_STD = {
        'grid': '#DDDDDD',
        'tick_labels': '#000000',
        'ticks': '#DDDDDD',
        'title': '#000000'
    }

    # specify some styles for the root mean square deviation
    STYLES_RMS = {
        'color': '#AAAADD',
        'linestyle': '--'
    }

    MODEL_TYPES = model_types
    MODEL_COLORS = colors

    
    # Create fig and ax
    if ax is None:
        fig, ax = plt.subplots(1,1)

    # build legend handles    
    legend_handles = []

    stdev0, ccoef0, crmse0, loss0 = list(metrics.values())[0].values()
    sm.taylor_diagram(ax,
                      np.asarray((stdev0, stdev0)), 
                      np.asarray((crmse0, crmse0)), 
                      np.asarray((ccoef0, ccoef0)),
                      markercolors = {"face": "#000000","edge": "#000000"},
                      markersize = 9, markersymbol = '^',
                      styleOBS = ':', colOBS = "#000000", alpha = 1.0,
                      titleSTD = 'off', titleRMS = 'off',
                      showlabelsRMS = 'on',
                      tickRMS = np.linspace(0.25, 1, 4),
                      colRMS = STYLES_RMS['color'],
                      tickRMSangle = 125,
                      styleRMS = STYLES_RMS['linestyle'],
                      colscor = COLS_COR, colsstd = COLS_STD,
                      styleCOR='-', styleSTD='-',
                      colframe='#DDDDDD',
                      labelweight='normal',
                      titlecorshape='linear')



    # add label below the marker
    ax.set_xlim(0, 1.1)
    ax.text(stdev0-0.075, 0.05, list(metrics.keys())[0][0:4]+'.', verticalalignment="top",
            horizontalalignment="center", fontweight="bold")

    # create one overlay for each model marker
    for i, (model_id, metric_dict) in enumerate(list(metrics.values())[1].items()):
        stdev, ccoef, crmse, loss = metric_dict.values()
        sm.taylor_diagram(ax,
                          np.asarray((stdev0, stdev)),
                          np.asarray((crmse0, crmse)),
                          np.asarray((ccoef0, ccoef)),
                          markersymbol = MARKERS[MODEL_TYPES[model_id]],
                          markercolors = {
                            "face": MODEL_COLORS[model_id],
                            "edge": MODEL_COLORS[model_id]
                          },
                          markersize = 9,
                          alpha = 1.0,
                          overlay = 'on',
                          styleCOR = '-',
                          styleSTD = '-')
        

        if (legend == 'Average')&(aver_scores is not None):
            score_label = aver_scores[model_id]
        else:
            score_label = loss
        
        marker = mlines.Line2D([], [], 
                           marker=MARKERS[MODEL_TYPES[model_id]],
                           markersize=9,
                           markerfacecolor=MODEL_COLORS[model_id],
                           markeredgecolor=MODEL_COLORS[model_id],
                           linestyle='None',
                           label='{} (Loss:{:.2f})'.format(model_id,score_label))

        legend_handles.append(marker)
    
    if (legend == 'Average')&(aver_scores is not None):
        legend_orders = list(aver_scores.argsort())       
        legend_handles = [legend_handles[i] for i in legend_orders]
    
    # set titles (upper, left, bottom)
    #ax.set_title(list(metrics.keys())[1], loc="left", y=1.1)

    # add y label
    ax.set_ylabel("Normalized Standard Deviation")

    # add xlabel
    ax.set_xlabel("Normalized Standard Deviation")
    
    # Add legend of CRMSE line to handles
    legend_handles.append(mlines.Line2D([], [],
                      color=STYLES_RMS['color'],
                      linestyle=STYLES_RMS['linestyle'],
                      label="Normalized CRMSE"))
    # add legend
    if legend == 'Individual':
        ax.legend(handles=legend_handles, bbox_to_anchor=[0,-0.2], loc=2, ncol=(i+1)//5+1)
    elif legend == 'Average':
        ax.legend(handles=legend_handles, bbox_to_anchor=[1,-0.2], loc=1, ncol=4)
        ax2 = ax.inset_axes([1, 1, 0.15, 0.15])
        for key, value in MARKERS.items():
            ax2.scatter([], [], color='k', marker=value, label=key)
            ax2.legend(bbox_to_anchor=[1,-0.1], loc=1, ncol=1)
#             ax2.set_xticks([])
#             ax2.set_yticks([])
            ax2.axis('off')

    # avoid some overlapping
    #plt.tight_layout()
    
    return ax


def vis_ensemble(datetime, ensemble_mean, ensemble_min, ensemble_max, ensemble_std, df_targ, dfs_pred, top_models, 
                 transects, colors, zorders):
    '''
    This function plots Taylor diagram based metrics
    
    Input:
    datetime (array): Datetime
    ensemble_mean (array): Time series of ensemble mean
    ensemble_min (array): Time series of ensemble min
    ensemble_max (array): Time series of ensemble max
    ensemble_std (array): Time series of ensemble std
    df_target: DataFrame for target
    dfs_pred: DataFrames for prediction from different models
    top_models: individual models to plot
    
    Output:
    ax: Ax with plot
    '''
    TRANSECTS = transects
    MODEL_COLORS = colors
    index = datetime
    fig = plt.figure(figsize=(12, 2.5*len(TRANSECTS))) 
    axes = gridspec.GridSpec(len(TRANSECTS), 2, width_ratios=[3, 1]) 
    letters = string.ascii_lowercase # Letters used to label subplots
    for i, tran_id in enumerate(TRANSECTS):
        ax = plt.subplot(axes[i, 0])
        ax.fill_between(index, ensemble_min[:, i], ensemble_max[:, i], color='grey', edgecolor='none', alpha=0.2)
        ax.fill_between(index, ensemble_mean[:, i]+ensemble_std[:, i], 
                        ensemble_mean[:, i]-ensemble_std[:, i], color='grey', edgecolor='none', alpha=0.4)
        ax.plot(index, ensemble_mean[:, i], color='grey', label='Ensemble mean', zorder=100, alpha=0.8)
        for model in top_models:
            ax.plot(dfs_pred[model].index, dfs_pred[model][tran_id], 
            linestyle='-', color=MODEL_COLORS[model], label=model, alpha=1, zorder=zorders[model])
        if len(df_targ)<20:
            fmt='o'
        else:
            fmt='.'
        #ax.plot(index, ensemble_median[:, i], label='Ensemble median')
        ax.errorbar(df_targ.index, df_targ[tran_id], color='k', 
                    yerr=7, fmt=fmt, zorder=100, alpha=1, label='Targ')
            # Add subtitle
        ax.set_title(tran_id)
        # Add label
        ax.text(0.01,0.95, letters[i] + '1) ', 
                    bbox=dict(boxstyle="square", ec='k',fc='w',alpha=0.5), 
                    ha='left',va='top', transform=ax.transAxes, zorder=10)
        ax.set_ylabel('Shoreline Position (m)')
        if i == 0:
            ax.legend(ncol=3, fontsize=8)

        ax2 = plt.subplot(axes[i, 1])
        x = df_targ[tran_id].dropna()
        y=dfs_pred['Ensemble'].loc[x.index, tran_id]


        sns.kdeplot(x=x, y=y, fill=True, cmap='Reds',
                    ax=ax2)
        ax2.plot([0,1],[0,1], transform=ax2.transAxes, color='k', linewidth=0.5, linestyle='--')

        if i==2:
            ax2.set_xlabel('Target')
        else:
            ax2.set_xlabel(None)

        ax2.set_ylabel('Pred Ensemble')
        ax2.set_title('')
        #ax2.set_xlim(150, 230)
        ax2.set_ylim(ax2.get_xlim())
        #ax2.set_yticks(ax2.get_xticks())
        ax2.set_aspect('equal')

        r2 = r2_score(x, y)
        RMSE = np.sqrt(np.mean((x - y) ** 2))
        skill = 1 - RMSE/np.std(x)
        lamda_score = mielke_lambda(x, y)

        metric_str = "$R^2$={:.2f}\nSkill={:.2f}\n$λ$={:.2f}".format(r2, skill, lamda_score)


        ax2.text(0.2,0.95, metric_str, 
                bbox=dict(boxstyle="square", ec='k',fc='w',alpha=0.5), 
                ha='left',va='top', transform=ax2.transAxes, zorder=10)
        
        ax2.text(0.8,0.95, letters[i] + '2) ', 
            bbox=dict(boxstyle="square", ec='k',fc='w',alpha=0.5), 
            ha='left',va='top', transform=ax2.transAxes, zorder=10)


    fig.subplots_adjust(hspace=0.3)
    return fig

def loss_boxplot(df_loss, df_meta, transects, colors):
    df_loss_merge = df_loss.merge(df_meta, left_index=True, right_on='Model Name')
    df_loss_merge['Process'] = 'CS+LS'
    df_loss_merge.loc[(df_loss_merge['Cross-Shore'].isna())&(~df_loss_merge['Long-Shore'].isna()), 'Process']='LS Only'
    df_loss_merge.loc[(~df_loss_merge['Cross-Shore'].isna())&(df_loss_merge['Long-Shore'].isna()), 'Process']='CS Only'
    
    fig, axes = plt.subplots(1, 3, figsize=(12, 4))
    MODEL_COLORS = colors
    model_types = ['DDM', 'HM']
    processes = ['CS Only', 'LS Only', 'CS+LS']
    markers = {
    'HM': '*',
    'DDM':'o',
    }
    
    TRANSECTS = transects
    for i, tran in enumerate(TRANSECTS):
        ax = axes[i]
        for j, process in enumerate(processes):
            pos_off = [-0.15, 0.15]
            boxcolors = ['lightcoral', 'seagreen']
            for k, model_type in enumerate(model_types):
                series = df_loss_merge.loc[(df_loss_merge['Process']==process)&(df_loss_merge['Type']==model_type), tran]
                model_names = df_loss_merge.loc[(df_loss_merge['Process']==process)&(df_loss_merge['Type']==model_type), 'Model Name']
                if len(series)>1:
                    ax.boxplot(series, positions=[j+pos_off[k]], showfliers=False, widths=0.2,
                              boxprops={'color':boxcolors[k], 'linewidth':2}, whiskerprops={'color':boxcolors[k], 'linewidth':2},
                              capprops={'color':boxcolors[k], 'linewidth':2}, medianprops = {'color':'k', 'linewidth':2})
                for kk, value in enumerate(series.values):
                    ax.scatter([j+pos_off[k]], value, color=MODEL_COLORS[model_names.values[kk]], marker=markers[model_type], zorder=5)

        ax.set_xlim(-0.5, 2.5)
        ax.set_xticks(range(len(processes)))
        ax.set_xticklabels(processes)
        ax.set_title(tran)
        ax.set_ylim(0.7, 2)
        if i == 0:
            ax.set_ylabel('Loss')
        else:
            ax.set_yticks([])


    # Create custom legends using mpatches
    boxlabels = ['DDM', 'HM']
    legend_patches = [mpatches.Patch(edgecolor=boxcolors[i], facecolor='None', label=boxlabels[i]) for i in range(len(boxcolors))]

    # Add the legend to the plot
    ax.legend(handles=legend_patches, loc='upper right')
    
    return fig
    