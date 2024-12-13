% ShoreShop 2.0 CoSMoS-COAST-CONV (convolution) model. SeanV.
%
% This (REVISED) code makes a shoreline prediction for the anonymized "Beach X" location
% on the east coast of Australia as part of the ShoreShop 2.0 competition.
% See: https://github.com/ShoreShop/ShoreModel_Benchmark for more details.
%
% Note this code is an experimental/in-development/lite verison of the CoSMoS-COAST model.  
% It has not undergone peer-review. 
%
% The full (peer-reviewed) CoSMoS-COAST model software release is avaliable here:
% https://doi.org/10.5066/P95T9188
%
% REVISION NOTES: This version of the code uses different convolution time
% for the cross-shore and longshore shoreline change components.  The
% original version used a single time scale for both components. 
%

clear all; close all; clc;

% check for individual, external functions dependencies that NEED to be downloaded to run the code
if isempty(which('fconv2'))
    error('I did not find the necessary function ''fconv2.m'' in the path.  It could be replaced with the built-in ''conv2'' function, which is slower. ''fconv2.m'' can be found/downloaded here: https://www.mathworks.com/matlabcentral/fileexchange/129654-fast-2d-convolution');
end

if isempty(which('smoothn'))
    error('I did not find the necessary function ''smoothn.m'' in the path.  It could be replaced by some built-in smoothing/filtering codes, but it can also be found/downloaded here: https://www.mathworks.com/matlabcentral/fileexchange/25634-smoothn');
end

if isempty(which('redwhiteblue'))
    warning('I did not find the function ''redwhiteblue.m'' in the path.  Model code will work without it, but some plots using this colormap will not work. It can be found here: https://www.mathworks.com/matlabcentral/fileexchange/86932-red-white-blue-colormap');
end

if isempty(which('taylor_diagram'))
    warning('I did not find the function ''taylor_diagram.m'' in the path.  Model code will work without it, but plotting Taylor diagrams will not work. It can be found here: https://github.com/PeterRochford/SkillMetricsToolbox');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Load ShoreShop shoreline data for Beach X
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% load shorelines
fprintf('loading shoreline data ... '); % display progress
T=readtable('..\..\datasets\shorelines\shorelines_obs.csv'); % read in the given "Beach X" shoreline observations to a matlab table
fprintf('done.\n'); % display progress

t_obs=datenum(T.Datetime);         % get the time part of the table
Yraw=table2array(T(:,2:end));      % arrange all shoreline transects into a 2-D array (dimension 1 = time, dimension 2 = transect #)
Y0=nanmean(Yraw);                  % calculate the mean value of each transect
Y=Yraw-Y0;                         % detrend each shoreline time series (i.e., detrend each column) by removing the mean

Ntr=size(Y,2);                     % get the number of transects (i.e., the 9 beach transects for Beach X)

% smooth the shorelines (since the shoreline data source is from satellites ... and those data REALLY need to be smoothed to provide a resonable depiction of the actual shoreline variability, IMO)
smooth_fac=1;                  % smoothing factor
Ysmooth=smoothn(Y,smooth_fac); % perform the smoothing on the shorelines, since the satellite-derived shorelines are quite noisy

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Load forcing conditions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% which future emissions scenario to load
%RCP='RCP45';
RCP='RCP85';

fprintf('loading wave/sea-level data ... '); % display progress

% load wave height
T=readtable('..\..\datasets\hindcast_waves\Hs.csv');      % load the wave height file to a matlab table
t_w=datenum(T.Datetime);                      % get the time vector
Hs=table2array(T(:,2:end));                   % arrange all transects into a 2-D array

if strcmp(RCP,'RCP45')
    T=readtable('..\..\datasets\forecast_waves\RCP45\Hs.csv'); % load the wave height file to a matlab table
elseif strcmp(RCP,'RCP85')
    T=readtable('..\..\datasets\forecast_waves\RCP85\Hs.csv'); % load the wave height file to a matlab table
else
    error('Unknown RCP scenario. SeanV')
end
t_w2=datenum(T.Datetime);
id=find(t_w2>t_w(end),1,'first');
t_w=cat(1,t_w,t_w2(id:end));                % get the time vector
Hs=cat(1,Hs,table2array(T(id:end,2:end)));  % arrange all transects into a 2-D array

Hs_med=nanmedian(Hs,2);                     % calculate the alongshore median

% smooth waves (this is mostly done to remove the few odd NaN's that are present)
smooth_fac=0.001;                         % smoothing factor parameter
Hs_med_smooth=smoothn(Hs_med,smooth_fac); % also smooth the alongshore median wave height

% load wave period (NOTE that the wave period is actually NOT used in the following code, but other equlibirum shoreline models, e.g., ShoreFor, do use it, so it's included here)
T=readtable('..\..\datasets\hindcast_waves\Tp.csv');  % load the wave period file to a matlab table
Tp=table2array(T(:,2:end));                           % arrange all transects into a 2-D array

if strcmp(RCP,'RCP45')
    T=readtable('..\..\datasets\forecast_waves\RCP45\Tp.csv'); % load the wave height file to a matlab table
elseif strcmp(RCP,'RCP85')
    T=readtable('..\..\datasets\forecast_waves\RCP85\Tp.csv'); % load the wave height file to a matlab table
else
    error('Unknown RCP scenario. SeanV')
end
Tp=cat(1,Tp,table2array(T(id:end,2:end))); % arrange all transects into a 2-D array

Tp_med=nanmedian(Tp,2);                    % calculate the alongshore median

% smooth waves (this is mostly done to remove the odd NaN's that are present)
smooth_fac=0.001;                         % smoothing factor parameter
Tp_med_smooth=smoothn(Tp_med,smooth_fac); % also smooth the alongshore median wave period

% load wave direction
T=readtable('..\..\datasets\hindcast_waves\Dir.csv');        % load the wave direction file to a matlab table
Dir=table2array(T(:,2:end));                     % arrange all transects into a 2-D array

if strcmp(RCP,'RCP45')
    T=readtable('..\..\datasets\forecast_waves\RCP45\Dir.csv'); % load the wave height file to a matlab table
elseif strcmp(RCP,'RCP85')
    T=readtable('..\..\datasets\forecast_waves\RCP85\Dir.csv'); % load the wave height file to a matlab table
else
    error('Unknown RCP scenario. SeanV')
end
Dir=cat(1,Dir,table2array(T(id:end,2:end)));     % arrange all transects into a 2-D array

Dir0=nanmedian(Dir(:));                          % calculate the median wave direction (one scalar value)

Dir_rel=Dir-Dir0;                                % recenter the direction data by removing the median
Dir_rel(Dir_rel>180)=Dir_rel(Dir_rel>180)-360;   % recenter values greater than 180 degrees

Dir_rel=detrend(Dir_rel,0);                      % detrend each transect, so that the direction data is roughly shorenormal

Dir_med=nanmedian(Dir_rel,2);                    % calculate the alongshore median
Dir_med=Dir_med-nanmedian(Dir_med);              % make sure the Dir_med has a zero median value

% get rid of oblique waves
Dir_med_smooth=Dir_med;                            % copy wave direction to smoothed copy
Dir_med_smooth(abs(Dir_med_smooth)>45)=NaN;        % get rid of highly oblique waves
Dir_med_smooth=smoothn(Dir_med_smooth,smooth_fac); % smooth the direction

Dir_med_smooth=Dir_med_smooth-nanmedian(Dir_med_smooth);  % make sure the Dir_med has a zero median value

% check the wave direction
%figure; plot(t_w,Dir_med_smooth,'-b',t_w,movmean(Dir_med_smooth,365),'-r',[t_w(1) t_w(end)],[0 0],'k--'); datetick('x');

% load the sea-level data
T=readtable('..\..\datasets\sealevel\sealevel_obs.csv','VariableNamingRule','preserve');  % load the sea-level file to a matlab table
T2=readtable('..\..\datasets\sealevel\sealevel_proj.csv');                                % load the sea-level file to a matlab table
t_sl=cat(1,datenum(T.Year,1,1),datenum(T2.Year,1,1));                         % get the time vector
SL=cat(1,T.("Sealevel (m)"),eval(['T2.',RCP]));                               % get the sea-level data for the RCP of choice
SL_smooth=smoothn(SL,1);                                                      % smooth the sea-level curve
SL_w=interp1(t_sl,SL_smooth,t_w,'linear','extrap');                           % interpolate the SL conditions onto the wave times
SL_w(t_w<t_sl(1))=SL_smooth(1);                                               % use a flat part of the initial curve

fprintf('done.\n'); % display progress

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% model time stepping conditions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

t0   =datenum(1940,1,02);    % model start time (some satellite data are odd near the begining of the time series, so we remove this)
tstop=datenum(2100,12,31);   % model stop time

% model time step
dt=1; % typically daily 

% model time vector
t=(t0:dt:tstop)';

% number of time steps
len=length(t);

% target output times (given in https://github.com/ShoreShop/ShoreModel_Benchmark)
t_output_short =(datenum(2019,01,01):datenum(2023,12,31))';  % make time array for the short-term prediction
t_output_medium=(datenum(1951,05,01):datenum(1998,12,31))';  % make time array for the short-term prediction
t_output_long  =(datenum(2019,01,01):datenum(2100,12,31))';  % make time array for the long-term prediction

% get rid of obserations outside of model window
id=(t_obs<t0 | t_obs>tstop);
t_obs(id)=[];
Y(id,:)=[];
Ysmooth(id,:)=[];

% get waves onto model time
[Hs]=interp1(t_w,Hs_med_smooth,t);
[Tp]=interp1(t_w,Tp_med_smooth,t);
[Dir]=interp1(t_w,Dir_med_smooth,t);
[SL]=interp1(t_w,SL_w,t,'linear','extrap');

% NOTE: we apply only ONE time series of wave height, period (not used),
% direction, and sea level to ALL transects.  Which is a bit different than
% applying individual/unique wave/SLR time series for each model transect.
% But Beach X is so small that unique time series are unnecessary any
% longshore variability will manifest in the alongshore variability of the
% model parameters... Besides unique wave time series are generally TOO
% FAR offshore to adequately capture the correct (i.e., 'nearshore') nature
% of the wave conditions, anyway.  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% model parameters

% Yates (2009) model parameters (written in terms of the modification in my 2021 paper)

% (semi-optimized parameter values)
DT_cs=60;                       % equlibirum time scale parameter [days]
DY_cs=15;                       % shoreline excursion parameter [m]

% longshore transport parameter values
DT_ls=60;                       % equlibirum time scale parameter [days]
DY_ls=0;   % the longshore transport parameter (DIFFERENT FROM THE TYPICAL K in the normal COSMOS-COAST version ... can be positive or negative, for example)

% the equlibirum profile model (a.k.a. Bruun rule)
c=1;              % the Bruun coefficient [dimensionless scaling factor]
tanAlpha=1/45.5;  % the Bruun/transgression slope (given in https://github.com/ShoreShop/ShoreModel_Benchmark)

% the long-term residual trend
vlt=0; % a linear trend [m/yr]

% calculate the long-term erosion rate in m/yr
vlt_max=NaN(1,Ntr);
for i=1:Ntr                                                         % for all transect
    id=~isnan(Y(:,i));                                              % get indices that are not NaN's
    vlt_max(1,i)=getfield(polyfit(t_obs(id),Y(id,i),1),{1})*365.25; % calculate the linear shoreline change rate
end

% the initial model parameter state vector (SEVEN parameters per transect)
%p= DT      DY      DT_ls  DY_ls    c     vlt      Y0 (i.e., the unknown initial condition)
p0=[DT_cs   DY_cs   DT_ls  DY_ls    c      0       0  ];  % the initial guess of the model parameters
lb=[20      2       20     -5000    0.75  -0.5    -50 ];  % ... and its lower and 
ub=[300     100     365    5000    1.25   0.5     50  ];  % ... upper bounds

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% THE MODEL PHYSICS (which is surprisingly short, IMO)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% NOTE THAT THE INPUT VARIABLE 'p' (used in the anonymous functions below) 
% is the state vector that contains the optimization parameters for a given transect ... 
% we optimize the model by determining the best 'p'

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (wave-driven) cross-shore model (i.e., the modified Yates model)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% the wave energy anomaly scaled by parameters DY (i.e., p(2)) and DT (i.e., p(1)).
f_cs=@(p,t,Hs) -p(2)/p(1)*(detrend(Hs.^2));  % the modified Yates convolution forcing function (written as a matlab anonymous function)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% longshore transport model (i.e., a CERC-like model)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% the longshore flux function.  Note that p(3) is longshore excursion parameter DY_ls, which varies between transects
Q   =@(p,t,Hs,alpha) p(4).*sind(2*alpha);   % the (CERC-like) longshore sediment transport flux (written as a matlab anonymous function)

% the longshore forcing function
f_ls=@(p,t,Hs,alpha) 1./p(3)*detrend(Q(p,t,Hs,alpha),0);   % the detrended lonshore sediment flux, scaled by the (inverse of the) time scale DT (i.e., p(1))

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (sea-level-driven) cross-shore model (i.e., the Bruun rule)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% the Bruun rule
Ybru=@(p,t,S) -p(5)/tanAlpha*(S-S(1));  % the Bruun model (written as a matlab anonymous function) 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% the residual trend term
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% a linear residual trend
Yvlt=@(p,t) p(6)/365.25*(t-t(1))+p(7);         % the residual trend (written as a matlab anonymous function)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% the combined cross-shore + longshore transport model, written as a convolution
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

f=@(p,t,Hs,alpha) f_cs(p,t,Hs)+f_ls(p,t,Hs,alpha);       % the convolution focring function (written as a matlab anonymous function) 
g_cs=@(p,t)          (1-dt/p(1)).^(t/dt).*(t>=0);        % the convolution  memory function (written as a matlab anonymous function), which is related to the time scale parameter DT (i.e., p(1))   
g_ls=@(p,t)          (1-dt/p(3)).^(t/dt).*(t>=0);        % the convolution  memory function (written as a matlab anonymous function), which is related to the time scale parameter DT (i.e., p(1))   

% the cross-shore shoreline change component only
Yst=@(p,t,Hs) cat(1,0,dt*getfield(fconv2(f_cs(p,t,Hs),g_cs(p,t-t(1))),{1:length(t)-1,1}));

% the longshore shoreline change component only
Ylst=@(p,t,Hs,alpha) cat(1,0,dt*getfield(fconv2(f_ls(p,t,Hs,alpha),g_ls(p,t-t(1))),{1:length(t)-1,1}));

% the combined cross-shore + longshore equlibirum + SLR + trend model, written as a convolution
Ymod=@(p,t,Hs,alpha,S) Yst(p,t,Hs)+Ylst(p,t,Hs,alpha)+Ybru(p,t,S)+Yvlt(p,t);  % the full model, written as a convolution (note: a convolution along each column, where each column represents a different transect)

% Note that while written this way, the model does not do ANY traditional
% time-stepping. Instead, time series of wave conditions are used to
% DIRECTLY calculate the shoreline time series, rather than
% updating/time-stepping Y^(N+1) from Y^N+f^N.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% THE MODEL TO CALIBRATE/OPTIMIZE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% the observed shoreline data set that is used for model calibration
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

t_obs_cal=t_obs;   % the observation times used for model calibration
%Yobs=Y;           % the (raw) observations used for model calibration (not working)
Yobs=Ysmooth;      % the (smoothed) observations used for model calibration (CALIBRATE USING SMOOTHED DATA)

% t_obs_cal=ti_obs;   % the (daily interpolated) observation times used for model calibration
% Yobs=Yi;            % the (daily interpolated) observations used for calibration

% add the 1951 shoreline data point to the calibration dataset
% this extra data point comes from: https://github.com/ShoreShop/ShoreModel_Benchmark/blob/main/datasets/shorelines/shorelines_target_medium.csv
t_obs_cal=cat(1,datenum(1951,05,01),t_obs_cal);
Yobs=cat(1,[182.9269951	190.8071143	185.5028497	179.8483611	182.7418803	201.6839691	203.8400302	198.7993275	193.0535854]-Y0,Yobs);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% the model to optimize (as a function of the model parameters p)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% the vector of model output for the calibration scenario.  Note that the only input is p, the parameters.  The input conditions (t,Hs,Dir) define the calibration portion/period
Ycal=@(p)  Ymod(p,t,Hs,Dir,SL);
    
% the model interpolated onto the observations (to evaluate the skill metrics)
Ycali=@(p) interp1(t,Ycal(p),t_obs_cal);    % the vector of model output interpolated to the observation points

% skill metric arrays (columns represent each transect)
P=NaN(length(p0),Ntr);
RMSE_opt=NaN(1,Ntr);
RMSEn_opt=NaN(1,Ntr);
STDn_opt=NaN(1,Ntr);
COR_opt=NaN(1,Ntr);
IDX_opt=NaN(1,Ntr);
LAMBDA_opt=NaN(1,Ntr);
L_opt=NaN(1,Ntr);

% save the individual shoreline components for all transects
Yfinal=NaN(length(t),Ntr);
YLST=NaN(length(t),Ntr);
YST=NaN(length(t),Ntr);
YBRU=NaN(length(t),Ntr);
YVLT=NaN(length(t),Ntr);

% start with p=p0, then use the optimized version of the previous transect for the initial condition for the next transect iteration
%p=p0; % initial parameter state vector is from the initial conditions (Although I'm not sure how this actually works in parallel, so I'm not including it)

% Note: The following 'for'-loop can be run in parallel using 'parfor' instead of the typical (serial) 'for' loop. i.e.,
% parpool(Ntr); % set up a parallel pool w/ one worker for each transect.
% fprintf('Running optimization in parallel (this may take a few minutes) ... \n'); % display progress
% parfor i=1:Ntr  % FOR EACH TRANSECT ... optimize for each transects individually

for i=1:Ntr  % FOR EACH TRANSECT ... optimize for each transects individually

    STDt=nanstd(Yobs(:,i));        % the standard deviation of the observations used later to calculate the skill metrics

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % skill metrics (as a function of the model parameters p - which we seek to optimize)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    ERROR=@(p) Ycali(p)-Yobs(:,i);                      % the difference between model and observations
    STD  =@(p) nanstd(Ycali(p));                        % the standard deviation of the model
    STDn =@(p) STD(p)/STDt;                             % the normalized standard deviation
    MSE  =@(p) nanmean((ERROR(p)).^2);                  % mean square error (MSE)
    RMSE =@(p) sqrt(mean(ERROR(p).^2));                 % the root-mean-square error (RMSE)
    RMSEn=@(p) RMSE(p)/STDt;                            % the normalized RMSE
    COR  =@(p) diag(corrcoef(Ycali(p),Yobs(:,i)),1);    % the correlation coefficient    
    
    IDX_AGREEMENT=@(p) 1-sum((Yobs(:,i)-Ycali(p)).^2)/sum( (abs(Ycali(p)-nanmean(Yobs(:,i)))+abs(Yobs(:,i)-nanmean(Yobs(:,i)))).^2 ); % index of agreement
    LAMBDA       =@(p) 1-MSE(p)/(var(Yobs(:,i))+var(Ycali(p))+(nanmean(Yobs(:,i))-nanmean(Ycali(p))).^2);                             % lambda

    % the loss function to optimize (based on the target given in the ShoreShop2.0 guidelines)
    L=@(p) sqrt((0-RMSEn(p))^2+(1-COR(p))^2+(1-STDn(p))^2); % the loss function to be minimized

    % optimization options
    options = optimset('Display','off'); % turn 'off' all the optimization dispay progress, you can also replace 'off' with 'iter' if you want the progress to display

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % OPTIMIZE
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    fprintf('running optimization for transect %d (this may take a few minutes) ... ',i); % display progress
    tic          % start timer
    p = fmincon(L,p0,[],[],[],[],lb,ub,[],options); % minimize the loss function subject to the lower and upper bounds (lb and ub, respectively, given above)
    twall=toc;   % stop timer

    % display wall-clock time
    if twall>60
        fprintf('done. wall-clock time = %.1f minutes. ',twall/60); % print total time in minutes
    else
        fprintf('done. wall-clock time = %.1f seconds. ',twall);    % or print total time in seconds
    end

    % save optimized parameters for all transects
    P(:,i)=p;

    % save output the final optimized skill metrics
    RMSE_opt(i)=RMSE(p);
    RMSEn_opt(i)=RMSEn(p);
    STDn_opt(i)=STDn(p);
    COR_opt(i)=COR(p);
    IDX_opt(i)=IDX_AGREEMENT(p);
    LAMBDA_opt(i)=LAMBDA(p);
    L_opt(i)=L(p);

    % report RMS error for each transect after calibration
    fprintf('(optimized) model RMSE = %.2f m.\n',RMSE_opt(i));

    % save output the final shoreline prediction
    Yfinal(:,i)=Ycal(p);

    % save output the final shoreline prediction
    YLST(:,i)=Ylst(p,t,Hs,Dir);
     YST(:,i)= Yst(p,t,Hs    );
    YBRU(:,i)=Ybru(p,t,SL    );
    YVLT(:,i)=Yvlt(p,t       );

    % make an example figure after calibration
    figure; set(gcf,'Position',[200+(i-1)*20 400-(i-1)*20 1400 600]); hold on; box on;
    han1=plot([t_obs(2)-100 t_obs(end)+500],[0 0],'k--'); set(han1,'HandleVisibility','off')
    han1=plot(t,Yfinal(:,i),'-r',t_obs_cal,Yobs(:,i),'bo'); set(han1,'MarkerSize',6,'MarkerFaceColor','b','MarkerEdgeColor','k');
    %han1=plot(t,YLST(:,i),'-r',t,YST(:,i),'-m',t,YBRU(:,i),'-c',t,YVLT(:,i),'-g'); datetick('x','keeplimits'); set(han1,'LineWidth',1.5); axis tight;
    %han1=plot(t_obs_cal(1),Yobs(1,i),'co'); set(han1,'MarkerSize',10,'MarkerFaceColor','c','MarkerEdgeColor','k');
    set(gca,'XLim',[t_obs(2)-100 t_obs(end)+500],'FontSize',16); datetick('x','keeplimits');
    legend('model','(smoothed) observations','Location','SouthEast');
    ylabel('shoreline position [m]');
    title(['transect #',num2str(i)]);
    drawnow;

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% make .csv output following the format given in https://github.com/ShoreShop/ShoreModel_Benchmark
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% save the output .csv files
output_dir='../../resubmissions/CoSMoS-COAST-CONV_SV'; % output directory to save to
if ~exist(output_dir,'dir')                     % if the output directory doesn't exist ...
    mkdir(output_dir);                          % make it
end

% make/interpolate the short-term target output
Y_output_short=interp1(t,Yfinal,t_output_short)+Y0; % note: we're adding back the column mean
Toutput_short=array2table(Y_output_short); 
Toutput_short.Properties.VariableNames={'Transect1','Transect2','Transect3','Transect4','Transect5','Transect6','Transect7','Transect8','Transect9'};
Toutput_short=[table(datestr(t_output_short,'yyyy-mm-dd'),'VariableNames',{'Datetime'}) Toutput_short];

% save the medium-term target output
writetable(Toutput_short,[output_dir,'/shorelines_prediction_short.csv']);

% make/interpolate the medium-term target output
Y_output_medium=interp1(t,Yfinal,t_output_medium)+Y0; % note: we're adding back the column mean
Toutput_medium=array2table(Y_output_medium); 
Toutput_medium.Properties.VariableNames={'Transect1','Transect2','Transect3','Transect4','Transect5','Transect6','Transect7','Transect8','Transect9'};
Toutput_medium=[table(datestr(t_output_medium,'yyyy-mm-dd'),'VariableNames',{'Datetime'}) Toutput_medium];

% save the medium-term target output
writetable(Toutput_medium,[output_dir,'/shorelines_prediction_medium.csv']);

% make/interpolate the long-term target output ..
Y_output_long=interp1(t,Yfinal,t_output_long)+Y0; % note: we're adding back the column mean
Toutput_long=array2table(Y_output_long); 
Toutput_long.Properties.VariableNames={'Transect1','Transect2','Transect3','Transect4','Transect5','Transect6','Transect7','Transect8','Transect9'};
Toutput_long=[table(datestr(t_output_long,'yyyy-mm-dd'),'VariableNames',{'Datetime'}) Toutput_long];

% save the long-term target output
writetable(Toutput_long,[output_dir,'/shorelines_prediction_long_',RCP,'.csv']);

% visual check to see if table conversion actually did what it was supposed to
figure; 
subplot(4,1,1); 
plot(t,Hs,'b'); datetick('x');
count=2;
for i=[2 5 8]
    subplot(4,1,count); hold on; box on;
    plot(t_obs_cal,Yobs(:,i)+Y0(i),'b.',t,Yfinal(:,i)+Y0(i),'b');
    plot(datenum(Toutput_long.Datetime),eval(['Toutput_long.Transect',num2str(i)]),'r.');
    plot(datenum(Toutput_medium.Datetime),eval(['Toutput_medium.Transect',num2str(i)]),'c.');
    plot(datenum(Toutput_short.Datetime),eval(['Toutput_short.Transect',num2str(i)]),'m.'); set(gca,'YLim',[-35+Y0(i) 35+Y0(i)]); datetick('x');
    count=count+1;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% make some fancy output plots
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fancyPlots  % a (seperate) script that makes some fancy plots based on the results
