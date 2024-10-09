# Submission of prediction results

## Model description

This is a Bayesian Hierarchical Linear Model. 

$$ y_{i,t} = \beta_{H_{i,t}} * H_{sig_{i,t}} + \epsilon$$

**sorry I will fill out the readme and submit before the workshop but just want to do the submission before the deadline** 

You also get uncertainty - both the 89% confidence interval of the model (uncertainty from the parameters in this model) and the 89% confidence interval where we expect the data to lie (includes the idealised normal distribution of the errors)

## Model implementation

The data are interpolated to a mean monthly value for the shoreline and the wave data. I also calculated the max Hsig each month as another covariate. I predict on a monthly timescale.

### Model mechanics
- [ ] Process-Based Models (PBM): couple hydrodynamics, waves, and morphodynamics through mass and momentum conservation laws.
- [ ] Hybrid Models (HM): use observational data to calibrate free parameters in the equilibrium configuration of a system.
- [X] Data-Driven Models (DDM): use observational data to train regression models (e.g. machine learning, statistical downscaling).
- 
### Model elements
- [X] Cross-shore: model the shoreline position for each transect independently.
- [ ] Long-shore: incorporate the interaction of shoreline position across different transects.
- [ ] Sea level: consider the impact of sea level rise on shoreline position.
