# Submission of prediction results

## Model description

This is a Bayesian Hierarchical Linear Model - [code available here](https://github.com/simmonsja/ShoreModel_Benchmark/tree/jsdev). It is based on monthly aggregated drivers and as such throws a lot of valuable information in the quest for simplicity. Lets define the parameters that appear in the model:

- y: target (monthly mean shoreline)
- H: $H_sig$ monthly mean significant wave height
- X: $H_sig$ monthly max significant wave height
- T: $T_p$ monthly mean peak wave period
- D: $W_dir$ monthly mean wave direction
- m: Month of the year
- ar1: Autoregressive parameter

We are modelling across i = 1,..,9 transects and t = 1,..,N timesteps. So the shoreline at transect i for timestep t is $y_{i,t}$. Similarly the regression parameter (e.g., $\beta$ or $\alpha$) for the peak wave period at transect i is $\alpha_{T_{i}}$.

$$ y_{i,t} = \beta_{ar1_{i}} y_{i,t-1} + \beta_{H_{i,t}} * H_{i,t} + \beta_{m_{i,m[t]}} + \epsilon$$
$$ \epsilon \sim N(0, \sigma^2)$$
$$ \beta_{H_{i,t}} = \alpha_{0_{i}} + \alpha_{ar1_{i}} y_{i,t-1} + \alpha_{X_{i}} X_{i,t} + \alpha_{T_{i}} T_{i,t} + \alpha_{D_{i}} D_{i,t}$$

There is an autoregressive term applied to the shoreline from the previous timestep (this is observed data in training and modelled shoreline position when predicting forward over unseen timesteps). There is a monthly varying intercept term at each transect (i.e., 12 different learned parameters for each transect which are selected according to the month of timestep t). 

To add in interaction terms, the code is structured with the regression term for the monthly mean significant wave height ($H$) itself being a regression on the other wave drivers: maximum wave height ($X$), wave period ($T$), wave direction ($D$); and the antecedent shoreline conditions (via $y_{t-1}$). So these other factors modulate the overall effect of wave energy on the shoreline response (e.g., a given wave energy might cause more/less shoreline change IF the shoreline is already eroded/accreted or IF the wave direction is more/less shorenormal). 

I didn't have time to make any serious attempt at model selection so this setup is mostly based on ... vibes. I think the $\beta_{H_{i,t}}$ is likely a bit crowded so it would have been worth experimenting what belongs in it versus the base regression.

## Bayesian + Hierarchical

We have several parameters to estimate and we estimate the parameters for each transect within one big model. Being a Bayesian model we will be incorporating some prior information on the parameters. We could specify an independent prior for each parameter, but why should we skip all the Hierarchical fun? This model uses a hierchical prior for most of the parameters to induce a little bit of pressure on the model to share information on parameter values between the transects. What does this look like?

We set a prior on the mean of all transects and sample for it:
$$\bar{\beta_{T}} \sim N(0,2)$$
We set a prior on the variance of all transects and sample for it:
$$\tau_{T} \sim Exp(1)$$
And then we set the prior for each individual transect as a normal distribution with the mean and variance we just sampled:
$$\beta_{T_{i}} \sim N(\bar{\beta_{T}}, \tau_{T})$$

So this has the effect of regularising the parameter estimates towards the mean of all transects and helps to prevent overfitting (at the very least it wont hurt much). Penalising our parameter estimates back to the mean is more influential when a given parameter is only weakly informed by the data.

The other parameters follow a similar pattern except for the autoregressive parameter which is sampled from a uniform distribution $\beta_{ar1_{i}} \sim U(0,1)$ independently for each profile. This is done for model stability again without the time to rectify myself.

$\sigma$ is sampled as a single parameter $\sigma \sim Exp(1)$.

There are many useful resources expalining Bayesian inference [but heres a simple Bayesian linear regression example with more information](https://github.com/simmonsja/numpyro-template/blob/main/01_NumPyro_template.ipynb).

Ideally we would incorporate spatial dependencies (e.g. with a GP prior) into our prior when considering fitting these parameters. i.e., it could be a good assumption to make that profiles closer together would have more similar parameters. However, there weren't enough transects for me to make a good go at this in the time I had.

## Uncertainty intervals

Because we have applied a Bayesian approach we get some estimation of uncertainty. So I have provided both the 89% confidence interval of the mean modelled value (uncertainty from the parameters in this model) and the 89% confidence interval where we expect the data to lie (includes the idealised normal distribution that captures the data generating process - i.e., captured in $sigma$).

## Model implementation

The data are aggregated to a mean monthly value for the shoreline and the forcing data. I also calculated the max Hsig each month as another covariate. I then predict on only a monthly timescale.

The input and output variables are standardised (and output rescaled to absolute shoreline positions).

### Model mechanics
- [ ] Process-Based Models (PBM): couple hydrodynamics, waves, and morphodynamics through mass and momentum conservation laws.
- [ ] Hybrid Models (HM): use observational data to calibrate free parameters in the equilibrium configuration of a system.
- [X] Data-Driven Models (DDM): use observational data to train regression models (e.g. machine learning, statistical downscaling).
- 
### Model elements
- [X] Cross-shore: model the shoreline position for each transect independently.
- [ ] Long-shore: incorporate the interaction of shoreline position across different transects.
- [ ] Sea level: consider the impact of sea level rise on shoreline position.
