% this is just a script to create fancy results plots of the CoSMoS-COAST-conv model for ShoreShop2.0. SeanV.

fprintf('Making fancy plots (this may take a few minutes) ... \n'); % display progress

SAVE_FANCY_PLOTS=1; % write fancy plots to file?

if SAVE_FANCY_PLOTS
    if ~exist('./figures','dir') % if the figures directory doesn't exist ...
        mkdir('figures');      % ... make it
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% plot transect coordinates and shoreline time series
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if 1

    % load ShoreShop 2 coordinates
    T=readtable('..\..\datasets\transects_coords.csv'); % load transect coordinates

    ID1=T.ID;
    x_on1=T.Land_x;
    y_on1=T.Land_y;
    x_off1=T.Sea_x;
    y_off1=T.Sea_y;

    figure; set(gcf,'Position',[100 100 2000 1000],'PaperPositionMode','auto','color','w');

    xp0=0.04;
    yp0=0.05;
    height=0.95;
    width=0.37;
    xsep=0.06;

    subplot('Position',[xp0 yp0 width+0.01 height]); box on; hold on;

    han1=plot([T.Land_x T.Sea_x]',[T.Land_y T.Sea_y]','o'); set(han1,'LineWidth',1,'MarkerSize',8,'MarkerFaceColor','r','MarkerEdgeColor','k','HandleVisibility','off'); axis equal; axis tight; axis([min(T.Land_x)-20 max(T.Sea_x)+40 min(T.Sea_y)-20 max(T.Land_y)+20])

    han1=plot([T.Land_x(1) T.Sea_x(1)]',[T.Land_y(1) T.Sea_y(1)]','-r'); set(han1,'LineWidth',2,'MarkerSize',8,'MarkerFaceColor','r','MarkerEdgeColor','k'); axis equal; axis tight; axis([min(T.Land_x)-20 max(T.Sea_x)+40 min(T.Sea_y)-20 max(T.Land_y)+20])
    han1=plot([T.Land_x T.Sea_x]',[T.Land_y T.Sea_y]','-r'); set(han1,'LineWidth',2,'MarkerSize',8,'MarkerFaceColor','r','MarkerEdgeColor','k','HandleVisibility','off'); axis equal; axis tight; axis([min(T.Land_x)-20 max(T.Sea_x)+40 min(T.Sea_y)-20 max(T.Land_y)+20])

    for i=1:Ntr
        text(T.Sea_x(i)+10,T.Sea_y(i)-3,num2str(i),'FontSize',16);
    end

    phi=atan2d(T.Sea_y-T.Land_y,T.Sea_x-T.Land_x);

    xsl=T.Land_x+Y0'.*cosd(phi);
    ysl=T.Land_y+Y0'.*sind(phi);

    Yobsmax=quantile(Yobs,0.975);
    Yobsmin=quantile(Yobs,0.025);

    xsl_max=T.Land_x+(Y0+Yobsmax)'.*cosd(phi);
    ysl_max=T.Land_y+(Y0+Yobsmax)'.*sind(phi);

    xsl_min=T.Land_x+(Y0+Yobsmin)'.*cosd(phi);
    ysl_min=T.Land_y+(Y0+Yobsmin)'.*sind(phi);

    han1=fill([xsl_max; flipud(xsl_min)],[ysl_max; flipud(ysl_min)],'c'); set(han1,'FaceAlpha',0.5);

    han1=plot(xsl,ysl,'o'); set(han1,'LineWidth',1,'MarkerSize',8,'MarkerFaceColor','b','MarkerEdgeColor','k','HandleVisibility','off');
    han1=plot(xsl,ysl,'-b'); set(han1,'LineWidth',2);

    set(gca,'FontSize',16);

    legend('transect','shoreline range','mean shoreline')

    title('ShoreShop2.0 transect coordinates');

    yp0=0.89;
    height2=0.09;
    width2=0.52;
    ysep=0.015;

    for i=1:9
        nsubplot=i; subplot('Position',[xp0+width+xsep yp0-(nsubplot-1)*(height2+ysep) width2 height2]); hold on; box on;

        han1=plot(t_obs,Y(:,i),'co'); set(han1,'MarkerSize',6,'MarkerEdgeColor','b','MarkerFaceColor','c')
        han1=plot(t_obs,Ysmooth(:,i),'-b'); set(han1,'LineWidth',2);
        axis([min(t_obs) max(t_obs) -40 40]); datetick('x','keepticks','keeplimits');
        if i<9
            set(gca,'XTickLabel',[]);
        end
        set(gca,'YTick',[-30:15:30]);
        set(gca,'FontSize',16);
        ylabel('Y [m]','FontSize',16);

        text(min(t_obs)+100,30,['transect #',num2str(i)],'FontSize',14);
    end

    legend('raw','smoothed','Position',[0.907666667933268 0.754994625146036 0.0679999987334013 0.0544999985098825])

    if SAVE_FANCY_PLOTS
        saveas(gcf,'figures\ShoreShop2_coordinates_all_transects.jpg');
    end

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% time stepping for smoothed observations
dti=1; % we go from an irregularly spaced shoreline time series to a regularly spaced time series with time step dt (for the purposes of plotting) ... either the daily time series or the irregular time series can later be used during calibration

% make a model time vector with the minimum observation dt
ti_obs=(min(t_obs):dti:max(t_obs))';
Nobs=length(ti_obs); % number of observation times (many of which are NaN's)

% interpolate the smoothed shoreline time series onto the new dt (e.g., daily) time step
Yi=interp1(t_obs,Ysmooth,ti_obs,'makima');

% split the time series into cross-shore and longshore components
YCS=repmat(nanmedian(Yi,2),1,Ntr); % take the moving-median of the time series (i.e., the median of all transects for each time) 
YLS=Yi-YCS;                        % find the longshore component by subtracting the cross-shore component from the full time series ... these variables are mostly just used for visualization 

% get rid of data outside of the simulation window
id=(ti_obs<t0 | ti_obs>tstop);
ti_obs(id)=[];
Yi(id,:)=[];
YCS(id,:)=[];
YLS(id,:)=[];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% plot raw vs. smoothed shoreline time series for Beach X
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if 0

    figure; set(gcf,'Position',[100 50 1500 600]); hold on; box on;

    sat_RMSE=10;

    id_tr=5;

    han1=fill([ti_obs; flipud(ti_obs)],[YCS(:,id_tr)+sat_RMSE; flipud(YCS(:,id_tr))-sat_RMSE],'c','FaceAlpha',0.4,'LineStyle','none');
    han1=fill([ti_obs; flipud(ti_obs)],[YCS(:,id_tr)+2*sat_RMSE; flipud(YCS(:,id_tr))-2*sat_RMSE],'c','FaceAlpha',0.2,'LineStyle','none');
    han1=plot(t_obs,Yobs(2:end,id_tr),'-bo'); set(han1,'MarkerFaceColor','b','MarkerSize',4,'LineWidth',2);
    han1=plot(t_obs,Y(:,5),'-ro'); set(han1,'MarkerFaceColor','r','MarkerSize',4);
    plot([t0 tstop],[0 0],'k--',[t0 tstop],[-10 -10],'k--',[t0 tstop],[10 10],'k--','HandleVisibility','off'); datetick('x');
    axis([ti_obs(1) ti_obs(end) -50 35 ]);

    legend('+/-\sigma (satellite CI bands)','+/-2\sigma (satellite CI bands)','alongshore-averaged shoreline position','transect #5 shoreline position','Position',[0.189333333333333 0.143055555555557 0.258444444444444 0.169166666666667])
    set(gca,'FontSize',16);

    ylabel('Shoreline position [m]','FontSize',16);

    if SAVE_FANCY_PLOTS
        saveas(gcf,'figures\ShoreShop2_smoothing_tr_5.jpg');
    end

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% plot smoothed shoreline anomaly time series array for Beach X
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if 1
    figure; set(gcf,'Position',[100 100 1600 900],'PaperPositionMode','auto','Color','w'); hold on; box on;
    pcolor(t_obs,1:9,Ysmooth'); shading flat; axis ij; colormap(redwhiteblue(-15,15,64)); colorbar;  caxis([-20 20]); datetick('x'); axis tight; %caxis([-25 25]);
    set(gca,'layer','top','FontSize',16)
    set(gca,'color',[0.5 0.5 0.5]);
    ylabel('transect #','FontWeight','bold');
    title('ShoreShop2.0 - Beach X - Satellite-derived shoreline position (anomaly, smoothed)','FontWeight','bold');
    annotation(gcf,'textbox',[0.861625 0.932222222222222 0.0621250000000001 0.0466666666666666],'String',{'Shoreline','position [m]'},'FitBoxToText','off','FontSize',12,'LineStyle','none');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% cross shore vs longshore (observed)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if 1

    figure; set(gcf,'Position',[100 50 1000 1300]);

    xp0=0.08;
    yp0=0.72;
    height=0.24;
    width=0.9;
    ysep=0.09;

    nsubplot=1; subplot('Position',[xp0 yp0-(nsubplot-1)*(height+ysep) width height]); hold on; box on;

    imagesc(ti_obs,1:9,Yi'); shading flat; axis ij; colormap(redwhiteblue(-15,15,64)); colorbar; caxis([-20 20]);  axis tight;
    ylabel('transect #');
    title('Total shoreline anomaly [m] (smoothed)')

    datetick('x','keepticks','keeplimits');
    set(gca,'FontSize',16,'XTick',datenum(2000:2018,1,1),'layer','top'); han1=colorbar;
    datetick('x','keepticks','keeplimits');

    nsubplot=2; subplot('Position',[xp0 yp0-(nsubplot-1)*(height+ysep) width height]); hold on; box on;

    imagesc(ti_obs,1:9,YCS'); shading flat; axis ij; colormap(redwhiteblue(-15,15,64)); colorbar; caxis([-20 20]);  axis tight;

    datetick('x','keepticks','keeplimits');
    set(gca,'FontSize',16,'XTick',datenum(2000:2018,1,1),'layer','top'); han1=colorbar;
    datetick('x','keepticks','keeplimits');

    ylabel('transect #');
    title('Cross-shore shoreline anomaly [m] (time-varying alongshore median position)')

    nsubplot=3; subplot('Position',[xp0 yp0-(nsubplot-1)*(height+ysep) width height]); hold on; box on;

    imagesc(ti_obs,1:9,YLS'); shading flat; axis ij; colormap(redwhiteblue(-15,15,64)); colorbar; caxis([-20 20]);  axis tight;
    ylabel('transect #');
    title('Longshore shoreline anomaly [m] (total minus cross-shore)')

    datetick('x','keepticks','keeplimits');
    set(gca,'FontSize',16,'XTick',datenum(2000:2018,1,1),'layer','top'); han1=colorbar;
    datetick('x','keepticks','keeplimits');

    if SAVE_FANCY_PLOTS
        saveas(gcf,'figures\ShoreShop2_cross_vs_longshore_obs_3panel.jpg');
    end

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% cross shore vs longshore (modeled)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if 1

    figure; set(gcf,'Position',[100 50 1000 1300]);

    xp0=0.08;
    yp0=0.72;
    height=0.24;
    width=0.9;
    ysep=0.09;

    nsubplot=1; subplot('Position',[xp0 yp0-(nsubplot-1)*(height+ysep) width height]); hold on; box on;

    imagesc(t,1:9,Yfinal'); shading flat; axis ij; colormap(redwhiteblue(-15,15,64)); colorbar; caxis([-20 20]);  axis tight;
    ylabel('transect #');
    title('Total shoreline anomaly [m] (modeled)')

    datetick('x','keepticks','keeplimits');
    set(gca,'FontSize',16,'XTick',datenum(2000:2018,1,1),'layer','top','XLim',[datenum(2000,1,1) datenum(2018,1,1)]); han1=colorbar;
    datetick('x','keepticks','keeplimits');

    nsubplot=2; subplot('Position',[xp0 yp0-(nsubplot-1)*(height+ysep) width height]); hold on; box on;

    imagesc(t,1:9,YST'); shading flat; axis ij; colormap(redwhiteblue(-15,15,64)); colorbar; caxis([-20 20]);  axis tight;

    datetick('x','keepticks','keeplimits');
    set(gca,'FontSize',16,'XTick',datenum(2000:2018,1,1),'layer','top','XLim',[datenum(2000,1,1) datenum(2018,1,1)]); han1=colorbar;
    datetick('x','keepticks','keeplimits');

    ylabel('transect #');
    title('Cross-shore shoreline anomaly [m] (time-varying alongshore median position)')

    nsubplot=3; subplot('Position',[xp0 yp0-(nsubplot-1)*(height+ysep) width height]); hold on; box on;

    imagesc(t,1:9,YLST'); shading flat; axis ij; colormap(redwhiteblue(-15,15,64)); colorbar; caxis([-20 20]);  axis tight;
    ylabel('transect #');
    title('Longshore shoreline anomaly [m] (total minus cross-shore)')

    datetick('x','keepticks','keeplimits');
    set(gca,'FontSize',16,'XTick',datenum(2000:2018,1,1),'layer','top','XLim',[datenum(2000,1,1) datenum(2018,1,1)]); han1=colorbar;
    datetick('x','keepticks','keeplimits');

    if SAVE_FANCY_PLOTS
        saveas(gcf,'figures\ShoreShop2_cross_vs_longshore_mod_3panel.jpg');
    end

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% plot shoreline component time series for Beach X
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if 1
    figure; set(gcf,'Position',[200 200 2000 1000]);

    xp0=0.05;
    yp0=.68;
    width=.93;
    height=0.3;
    ysep=0.02;
    MARKERSIZE=5;
    LINEWIDTH=2;

    i=2; nplot=1; subplot('Position',[xp0 yp0-(nplot-1)*(height+ysep) width height]);  hold on; box on;

    text(t(1)+500,25,['transect #',num2str(i)],'FontSize',14);

    han1=plot(t,Yfinal(:,i),'-b',t_obs_cal,Yobs(:,i),'bo'); set(han1,'MarkerSize',MARKERSIZE,'MarkerFaceColor','b','MarkerEdgeColor','b');
    han1=plot(t,YLST(:,i),'-r',t,YST(:,i),'-m',t,YBRU(:,i),'-c',t,YVLT(:,i),'-g'); datetick('x','keeplimits'); set(han1,'LineWidth',LINEWIDTH); axis tight;
    han1=plot(t_obs_cal(1),Yobs(1,i),'co'); set(han1,'MarkerSize',10,'MarkerFaceColor','c','MarkerEdgeColor','k'); set(gca,'Ylim',[-30 30],'XTickLabel',[],'FontSize',14)
    han1=plot([t(1) t(end)],[0 0],'k--'); set(han1,'HandleVisibility','off');
    ylabel('shoreline position [m]');

    i=5; nplot=2; subplot('Position',[xp0 yp0-(nplot-1)*(height+ysep) width height]);  hold on; box on;

    text(t(1)+500,25,['transect #',num2str(i)],'FontSize',14);

    han1=plot(t,Yfinal(:,i),'-b',t_obs_cal,Yobs(:,i),'bo'); set(han1,'MarkerSize',MARKERSIZE,'MarkerFaceColor','b','MarkerEdgeColor','b');
    han1=plot(t,YLST(:,i),'-r',t,YST(:,i),'-m',t,YBRU(:,i),'-c',t,YVLT(:,i),'-g'); datetick('x','keeplimits'); set(han1,'LineWidth',LINEWIDTH); axis tight;
    han1=plot(t_obs_cal(1),Yobs(1,i),'co'); set(han1,'MarkerSize',10,'MarkerFaceColor','c','MarkerEdgeColor','k'); set(gca,'Ylim',[-30 30],'XTickLabel',[],'FontSize',14)
    han1=plot([t(1) t(end)],[0 0],'k--'); set(han1,'HandleVisibility','off');
    ylabel('shoreline position [m]');

    i=8; nplot=3; subplot('Position',[xp0 yp0-(nplot-1)*(height+ysep) width height]);  hold on; box on;

    text(t(1)+500,25,['transect #',num2str(i)],'FontSize',14);

    han1=plot(t,Yfinal(:,i),'-b',t_obs_cal,Yobs(:,i),'bo'); set(han1,'MarkerSize',MARKERSIZE,'MarkerFaceColor','b','MarkerEdgeColor','b');
    han1=plot(t,YLST(:,i),'-r',t,YST(:,i),'-m',t,YBRU(:,i),'-c',t,YVLT(:,i),'-g'); datetick('x','keeplimits'); set(han1,'LineWidth',LINEWIDTH); axis tight;
    han1=plot(t_obs_cal(1),Yobs(1,i),'co'); set(han1,'MarkerSize',10,'MarkerFaceColor','c','MarkerEdgeColor','k'); set(gca,'Ylim',[-30 30],'FontSize',14);
    han1=plot([t(1) t(end)],[0 0],'k--'); set(han1,'HandleVisibility','off');
    ylabel('shoreline position [m]');

    legend('total shoreline position','observations','longshore component','cross-shore component','SLR component','residual trend','initial observation','Position',[0.850666669289273 0.561333337714275 0.113499997377396 0.153999995619059]);

    if SAVE_FANCY_PLOTS
        saveas(gcf,'figures\ShoreShop2_model_components_2100.jpg');
    end

end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% plot shoreline component time series for Beach X
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if 1
    figure; set(gcf,'Position',[200 200 2000 1000]);

    xp0=0.05;
    yp0=.68;
    width=.93;
    height=0.3;
    ysep=0.02;
    MARKERSIZE=5;
    LINEWIDTH=2;

    i=2; nplot=1; subplot('Position',[xp0 yp0-(nplot-1)*(height+ysep) width height]);  hold on; box on;
    %han1=plot(t,Yfinal(:,i),'-b',t_obs_cal,Yobs(:,i),'bo'); set(han1,'MarkerSize',MARKERSIZE,'MarkerFaceColor','b','MarkerEdgeColor','b');
    han1=plot(t,YLST(:,i),'-r',t,YST(:,i),'-b'); datetick('x','keeplimits'); set(han1,'LineWidth',LINEWIDTH); axis tight;
    %han1=plot(t_obs_cal(1),Yobs(1,i),'co'); set(han1,'MarkerSize',10,'MarkerFaceColor','c','MarkerEdgeColor','k');
    han1=plot([t(1) t(end)],[0 0],'k--'); set(han1,'HandleVisibility','off');
    set(gca,'Ylim',[-27 27],'XTickLabel',[],'FontSize',14)
    set(gca,'XLim',[t_obs(2)-100 t_obs(end)+500],'layer','top','XTick',datenum(1998:2019,1,1),'XTickLabel',[]);
    ylabel('shoreline position [m]');

    i=5; nplot=2; subplot('Position',[xp0 yp0-(nplot-1)*(height+ysep) width height]);  hold on; box on;
    %han1=plot(t,Yfinal(:,i),'-b',t_obs_cal,Yobs(:,i),'bo'); set(han1,'MarkerSize',MARKERSIZE,'MarkerFaceColor','b','MarkerEdgeColor','b');
    han1=plot(t,YLST(:,i),'-r',t,YST(:,i),'-b'); datetick('x','keeplimits'); set(han1,'LineWidth',LINEWIDTH); axis tight;
    %han1=plot(t_obs_cal(1),Yobs(1,i),'co'); set(han1,'MarkerSize',10,'MarkerFaceColor','c','MarkerEdgeColor','k');
    han1=plot([t(1) t(end)],[0 0],'k--'); set(han1,'HandleVisibility','off');
    set(gca,'Ylim',[-27 27],'XTickLabel',[],'FontSize',14)
    set(gca,'XLim',[t_obs(2)-100 t_obs(end)+500],'layer','top','XTick',datenum(1998:2019,1,1),'XTickLabel',[]);
    ylabel('shoreline position [m]');

    i=8; nplot=3; subplot('Position',[xp0 yp0-(nplot-1)*(height+ysep) width height]);  hold on; box on;
    %han1=plot(t,Yfinal(:,i),'-b',t_obs_cal,Yobs(:,i),'bo'); set(han1,'MarkerSize',MARKERSIZE,'MarkerFaceColor','b','MarkerEdgeColor','b');
    han1=plot(t,YLST(:,i),'-r',t,YST(:,i),'-b'); datetick('x','keeplimits'); set(han1,'LineWidth',LINEWIDTH); axis tight;
    %han1=plot(t_obs_cal(1),Yobs(1,i),'co'); set(han1,'MarkerSize',10,'MarkerFaceColor','c','MarkerEdgeColor','k');
    han1=plot([t(1) t(end)],[0 0],'k--'); set(han1,'HandleVisibility','off');
    set(gca,'Ylim',[-27 27],'FontSize',14);
    set(gca,'XLim',[t_obs(2)-100 t_obs(end)+500],'layer','top','XTick',datenum(1998:2019,1,1)); datetick('x','keeplimits');
    ylabel('shoreline position [m]');

    legend('longshore component','cross-shore component','Position',[0.817014979229453 0.572963317969215 0.136999996677041 0.0584999983906747],'FontSize',16);

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% plot shoreline component time series for Beach X
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if 1
    figure; set(gcf,'Position',[200 200 2000 1000]);

    xp0=0.05;
    yp0=.68;
    width=.93;
    height=0.3;
    ysep=0.02;
    MARKERSIZE=5;
    LINEWIDTH=2;

    i=2; nplot=1; subplot('Position',[xp0 yp0-(nplot-1)*(height+ysep) width height]);  hold on; box on;
    han1=plot(t,Yfinal(:,i),'-b',t_obs_cal,Yobs(:,i),'bo'); set(han1,'MarkerSize',MARKERSIZE,'MarkerFaceColor','b','MarkerEdgeColor','b');
    han1=plot(t,YLST(:,i),'-r',t,YST(:,i),'-m',t,YBRU(:,i),'-c',t,YVLT(:,i),'-g'); datetick('x','keeplimits'); set(han1,'LineWidth',LINEWIDTH); axis tight;
    %han1=plot(t_obs_cal(1),Yobs(1,i),'co'); set(han1,'MarkerSize',10,'MarkerFaceColor','c','MarkerEdgeColor','k');
    han1=plot([t(1) t(end)],[0 0],'k--'); set(han1,'HandleVisibility','off');
    set(gca,'Ylim',[-30 30],'XTickLabel',[],'FontSize',14)
    set(gca,'XLim',[t_obs(2)-100 t_obs(end)+500],'layer','top');
    ylabel('shoreline position [m]');

    i=5; nplot=2; subplot('Position',[xp0 yp0-(nplot-1)*(height+ysep) width height]);  hold on; box on;
    han1=plot(t,Yfinal(:,i),'-b',t_obs_cal,Yobs(:,i),'bo'); set(han1,'MarkerSize',MARKERSIZE,'MarkerFaceColor','b','MarkerEdgeColor','b');
    han1=plot(t,YLST(:,i),'-r',t,YST(:,i),'-m',t,YBRU(:,i),'-c',t,YVLT(:,i),'-g'); datetick('x','keeplimits'); set(han1,'LineWidth',LINEWIDTH); axis tight;
    %han1=plot(t_obs_cal(1),Yobs(1,i),'co'); set(han1,'MarkerSize',10,'MarkerFaceColor','c','MarkerEdgeColor','k');
    han1=plot([t(1) t(end)],[0 0],'k--'); set(han1,'HandleVisibility','off');
    set(gca,'Ylim',[-30 30],'XTickLabel',[],'FontSize',14)
    set(gca,'XLim',[t_obs(2)-100 t_obs(end)+500],'layer','top');
    ylabel('shoreline position [m]');

    i=8; nplot=3; subplot('Position',[xp0 yp0-(nplot-1)*(height+ysep) width height]);  hold on; box on;
    han1=plot(t,Yfinal(:,i),'-b',t_obs_cal,Yobs(:,i),'bo'); set(han1,'MarkerSize',MARKERSIZE,'MarkerFaceColor','b','MarkerEdgeColor','b');
    han1=plot(t,YLST(:,i),'-r',t,YST(:,i),'-m',t,YBRU(:,i),'-c',t,YVLT(:,i),'-g'); datetick('x','keeplimits'); set(han1,'LineWidth',LINEWIDTH); axis tight;
    %han1=plot(t_obs_cal(1),Yobs(1,i),'co'); set(han1,'MarkerSize',10,'MarkerFaceColor','c','MarkerEdgeColor','k');
    han1=plot([t(1) t(end)],[0 0],'k--'); set(han1,'HandleVisibility','off');
    set(gca,'Ylim',[-30 30],'FontSize',14);
    set(gca,'XLim',[t_obs(2)-100 t_obs(end)+500],'layer','top');
    ylabel('shoreline position [m]');

    legend('total shoreline position','observations','longshore component','cross-shore component','SLR component','residual trend','Position',[0.824996945301692 0.61187483724325 0.113499997377396 0.132499996244907]);

    if SAVE_FANCY_PLOTS
        saveas(gcf,'figures\ShoreShop2_model_components.jpg');
    end

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% plot shoreline component time series arrays for Beach X
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if 1
    figure; set(gcf,'Position',[100 100 1600 900],'PaperPositionMode','auto','Color','w'); hold on; box on;

    xp0=0.05;
    yp0=.68;
    width=.93;
    height=0.3;
    ysep=0.02;

    nplot=1; subplot('Position',[xp0 yp0-(nplot-1)*(height+ysep) width height]);  hold on; box on;
    pcolor(t,1:9,YLST'); shading flat; axis ij; colormap(redwhiteblue(-15,15,64)); colorbar; datetick('x'); axis tight; caxis([-15 15]);
    set(gca,'XLim',[t_obs(2)-100 t_obs(end)+500],'layer','top');
 
    nplot=1; subplot('Position',[xp0 yp0-(nplot-1)*(height+ysep) width height]);  hold on; box on;
    pcolor(t,1:9,YST'); shading flat; axis ij; colormap(redwhiteblue(-15,15,64)); colorbar; datetick('x'); axis tight; caxis([-15 15]);
    set(gca,'XLim',[t_obs(2)-100 t_obs(end)+500],'layer','top');

    nplot=1; subplot('Position',[xp0 yp0-(nplot-1)*(height+ysep) width height]);  hold on; box on;
    pcolor(t,1:9,YBRU'); shading flat; axis ij; colormap(redwhiteblue(-15,15,64)); colorbar; datetick('x'); axis tight; caxis([-50 50]);
    set(gca,'XLim',[t_obs(2)-100 t_obs(end)+500],'layer','top');

    figure; set(gcf,'Position',[100 100 1600 900],'PaperPositionMode','auto','Color','w'); hold on; box on;
    pcolor(t,1:9,YVLT'); shading flat; axis ij; colormap(redwhiteblue(-15,15,64)); colorbar; datetick('x'); axis tight; caxis([-50 50]);
    set(gca,'XLim',[t_obs(2)-100 t_obs(end)+500],'layer','top');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% plot variance pie plots
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure; set(gcf,'PaperPositionMode','auto','Position',[100 100 800 900],'color','w');

x0=0.06;
y0=0.65;
width=0.4;
height=0.28;
xsep=0.02;
ysep=0.02;

TR=[2 5 8];

for j=1:2
    for i=1:3
   
        if j==1
            id=(t>=t_output_short(1)) & (t<=t_output_short(end));
        elseif j==2
            id=1:length(t);
        end

        PCT1=var(YLST(id,TR(i)));
        PCT2=var( YST(id,TR(i)));
        PCT3=var(YBRU(id,TR(i)));
        PCT4=var(YVLT(id,TR(i)));

        PCT=PCT1+PCT2+PCT3+PCT4;

        PCT1=PCT1/PCT*100;
        PCT2=PCT2/PCT*100;
        PCT3=PCT3/PCT*100;
        PCT4=PCT4/PCT*100;

        explode = [0 0 0 0];

        subplot('Position',[x0+(j-1)*(width+xsep) y0-(i-1)*(height+ysep) width height]); 
        han1=pie([PCT1 PCT2 PCT3 PCT4],explode); colormap([0 1 0; 1 0 0; 0 0 1; 1 1 0]);
        set(han1(2:2:end),'FontSize',14);

        if j==1
            annotation(gcf,'textbox',[0.07 y0-(i-1)*(height+ysep+0.015)+0.07  0.2 0.05],'string',['transect #',num2str(TR(i))],'FontSize',18,'FontWeight','bold','LineStyle','none','Rotation',90);
        end

    end

end

legend({'longshore','cross-shore','SLR','trend'},'FontSize',12,'Position',[0.81312210449201 0.886822766615957 0.168749996870756 0.0994444416628943]);

% xsep=0.01;
% j=1; annotation(gcf,'textbox',[0.104166666666667 0.9 0.225416666666667 0.0611111111111108],'string',['steep transgression slope (avg.=1/',num2str(nanmean(1./tanBeta),'%.0f'),'m)'],'FontSize',12,'FontWeight','bold','LineStyle','none');
% j=2; annotation(gcf,'textbox',[0.38 0.9 0.295416666666667 0.0611111111111108],'string',['intermediate transgression slope (avg.=1/',num2str(nanmean(1./tanAvg),'%.0f'),'m)'],'FontSize',12,'FontWeight','bold','LineStyle','none');
% j=3; annotation(gcf,'textbox',[0.721666666666667 0.9 0.259583333333333 0.0611111111111108],'string',['gentle transgression slope (avg.=1/',num2str(nanmean(1./tanAlpha),'%.0f'),'m)'],'FontSize',12,'FontWeight','bold','LineStyle','none');

annotation(gcf,'textbox',[0.190833333333333 0.967777777777778 0.835416666666668 0.0348148148148145],'string','Conribution of each shoreline-change component','FontSize',18,'FontWeight','bold','LineStyle','none');

if SAVE_FANCY_PLOTS
    saveas(gcf,'figures\ShoreShop2_variance_pie_plots.jpg');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% plot the wave direction vs wave height for Beach X
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if 0;
    figure; hold on; box on;
    han1=plot(Hs_med_smooth,Dir_med,'bo');set(han1,'MarkerFaceColor',[0,191,255]/255,'MarkerSize',5);
    han1=plot([0 8],[0 0],'--k'); set(han1,'LineWidth',2); set(gca,'YDir','rev','FontSize',16);
    xlabel('H_s [m]');
    ylabel('relative wave direction [deg]');
    axis([0 8 -90 90]);

    annotation('textbox',[0.78392857142857 0.195238095238095 0.11607142857143 0.0714285714285748],'String','south','LineStyle','none','FontSize',16);
    annotation('textbox',[0.787499999999997 0.845238095238097 0.117857142857145 0.0823809523809548],'String','north','LineStyle','none','FontSize',16);

    saveas(gcf,'ShoreShop2_dir_vs_Hs.jpg');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% plot longshore transport figure
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if 0
    figure;
    subplot(4,1,1); plot(t,Q(p0,t,Hs,Dir)); datetick('x');
    subplot(4,1,2); plot(t,Ylst(p0,t,Hs,Dir)); datetick('x');
    subplot(4,1,3); plot(t,Ylst_det(p0,t,Hs,Dir)); datetick('x');
    subplot(4,1,4); plot(t,Ylst_conv(p0,t,Hs,Dir)); datetick('x');

    Ylst1=getfield(Ylst_det(p0,t,Hs,Dir),{1:length(t),1});
    Ylst1_smooth=smoothn(Ylst1,1000000000);
    Ylst2=getfield(Ylst_conv(p0,t,Hs,Dir),{1:length(t),1});

    figure;
    subplot(2,1,1); plot(t,Ylst1,'b',t,Ylst1_smooth,'r'); datetick('x');
    subplot(2,1,2); plot(t,Ylst2,'m',t,Ylst1-Ylst1_smooth,'b'); datetick('x');
    legend('Ylst (conv)','Ylst (high-pass)');
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% plot convolution animation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if 1
    xp0=0.08;
    yp0=0.80;
    width=0.85;
    height=0.17;
    xsep=0.05;
    ysep=0.013;

    MAKE_ANIMATION=1;
    if MAKE_ANIMATION % make gif animation
        filename='convolution_animation.gif'; % make some filenames and other misc animation variables
        count=1;
        fps=35;
    end

    han1=figure; set(han1,'Position',[400 50 1400 1300],'PaperPositionMode','auto','color','w'); % plot the data

    t0_plot=t_obs(2);
    tstop_plot=datenum(2024,1,1);

    [YYYY0,~,~]=datevec(t0_plot);
    [YYYY1,~,~]=datevec(tstop_plot);

    for t1=(t0_plot:10:tstop_plot)

        [~,n]=min(abs(t-t1));

        clf;

        % id=double((g(p,t1-t)>0.01));
        % id=find(id);

        nsubplot=1; ax=subplot('position',[xp0 yp0-(nsubplot-1)*(height+ysep) width height]);  hold on; box on;
        plot(t,Hs,'b');  axis tight;
        han1=plot(t(id),Hs(id),'b');  axis tight; set(han1,'LineWidth',2);
        plot([t1 t1],[0 5.6],'k--');
        axis([t0_plot tstop_plot 0 5.6]);
        set(gca,'XTick',datenum(YYYY0:YYYY1,1,1),'YTick',0:1:5,'FontSize',14,'XTickLabel',[]); datetick('x','keepticks','keeplimits'); set(gca,'XTickLabel',[]);

        ylabel('Sig. wave height [m]','FontSize',16,'FontWeight','bold');

        title({'Equlibrium shoreline models as convolutions (f*g)'},'FontSize',16);

        nsubplot=2; ax=subplot('position',[xp0 yp0-(nsubplot-1)*(height+ysep) width height]);  hold on; box on;
        plot(t,Dir,'b');  axis tight;
        han1=plot(t(id),Dir(id),'b');  axis tight; set(han1,'LineWidth',2);
        plot([t1 t1],[-50 50],'k--');
        axis([t0_plot tstop_plot -50 50]);
        set(gca,'XTick',datenum(YYYY0:YYYY1,1,1),'YTick',-40:10:40,'FontSize',14,'XTickLabel',[]); datetick('x','keepticks','keeplimits'); set(gca,'XTickLabel',[]);

        ylabel({'(relative)           ','wave dir. [deg]'},'FontSize',16,'FontWeight','bold');

        left_color = [0 0 1];
        right_color = [255 0 0]/255;
        set(gcf,'defaultAxesColorOrder',[left_color; right_color]);

        nsubplot=3; ax=subplot('position',[xp0 yp0-(nsubplot-1)*(height+ysep) width height]);  hold on; box on;

        yyaxis left

        vmin=-1.7;
        vmax=1.1;

        han1=plot(t,f_cs(p,t,Hs),'b');  axis tight; set(han1,'color',left_color);
        han1=plot(t(id),f_cs(p,t(id),Hs(id)),'b');  axis tight; set(han1,'color',left_color,'LineWidth',2);
        plot([t1 t1],[vmin vmax],'k--');
        axis([t0_plot tstop_plot vmin vmax]);
        set(gca,'XTick',datenum(YYYY0:YYYY1,1,1),'FontSize',14,'XTickLabel',[]); datetick('x','keepticks','keeplimits'); set(gca,'XTickLabel',[]);

        ylabel({'(cross-shore)     ','forcing function'},'FontSize',16,'FontWeight','bold');

        yyaxis right

        han1=plot(t,g(p,t1-t)); set(han1,'color',right_color,'LineWidth',2);

        vmin=-2.1;
        vmax=1.1;
        plot([t1 t1],[vmin vmax],'k--');

        set(gca,'XTick',datenum(YYYY0:YYYY1,1,1),'FontSize',14,'XTickLabel',[]); datetick('x','keepticks','keeplimits'); set(gca,'XTickLabel',[]);
        axis([t0_plot tstop_plot vmin vmax]);

        ylabel({'memory function (g)'},'FontSize',16,'FontWeight','bold');

        nsubplot=4; ax=subplot('position',[xp0 yp0-(nsubplot-1)*(height+ysep) width height]);  hold on; box on;

        yyaxis left

        han1=plot(t,f_ls(p,t,Hs,Dir),'b');  axis tight; set(han1,'color',left_color);
        han1=plot(t(id),f_ls(p,t(id),Hs(id),Dir(id)),'b');  axis tight; set(han1,'color',left_color,'LineWidth',2);

        ylabel({'(longshore)        ','forcing function'},'FontSize',16,'FontWeight','bold');


        % plot([t1 t1],[-3.5 0.5],'k--');
        % axis([t0 tstop_plot -3.5 0.5]);
        % set(gca,'XTick',datenum(2000:2025,1,1),'YTick',-3:1:0,'FontSize',14,'XTickLabel',[]); datetick('x','keepticks','keeplimits'); set(gca,'XTickLabel',[]);

        yyaxis right

        han1=plot(t,g(p,t1-t)); set(han1,'color',right_color,'LineWidth',2);

        vmin=-1.1;
        vmax=1.1;
        plot([t1 t1],[vmin vmax],'k--');

        set(gca,'XTick',datenum(YYYY0:YYYY1,1,1),'FontSize',14,'XTickLabel',[]); datetick('x','keepticks','keeplimits'); set(gca,'XTickLabel',[]);
        axis([t0_plot tstop_plot vmin vmax]);

        %         Xlim=[t0 tstop];
        %         Ylim=[-3.5 1.1];
        %         Ylim2=[-70 30];
        %
        %         xp(1)=xp0+(t1-t0)/(Xlim(2)-Xlim(1))*width;
        %         xp(2)=xp0+(t1-t0)/(Xlim(2)-Xlim(1))*width;
        %         yp(1)=yp0-(nsubplot-1)*(height+ysep)+(0-Ylim(1))/(Ylim(2)-Ylim(1))*height;
        %         yp(2)=yp0-(nsubplot-1)*(height+ysep)+(0-Ylim(1))/(Ylim(2)-Ylim(1))*height-ysep-0.1-(-Yst_conv(n)-Ylim2(1))./(Ylim2(2)-Ylim2(1))*height;
        %
        %         annotation('arrow', xp, yp);

        ylabel({'memory function (g)'},'FontSize',16,'FontWeight','bold');

        nsubplot=5; ax=subplot('position',[xp0 yp0-(nsubplot-1)*(height+ysep) width height]); hold on; box on;

        id_tr=8;

        %plot(ti,Yi,'bo','MarkerSize',6,'MarkerEdgeColor','k','MarkerFaceColor','c')
        %scatter1 = scatter(ti_obs,Yi(:,id_tr),'MarkerFaceColor',[125, 249, 255]/255,'MarkerEdgeColor','k');
        scatter1 = scatter(t_obs,Y(:,id_tr),'MarkerFaceColor',[0.23 0.78 1.00],'MarkerEdgeColor','k');
        scatter1.MarkerFaceAlpha = .9;

        %han1=plot(t,Yst_conv,'c'); datetick('x','keepticks','keeplimits'); axis tight;
        han1=plot(t,Yfinal(:,id_tr),'r'); datetick('x','keepticks','keeplimits'); set(han1,'LineWidth',2); axis tight;

        %        han1=plot(t1,interp1(t,Yst_conv,t1),'ro'); set(han1,'MarkerFaceColor',right_color,'LineWidth',2,'MarkerSize',8,'MarkerEdgeColor','k');

        vmin=-45;
        vmax=45;

        plot([t1 t1],[vmin vmax],'k--');

        plot([t0_plot tstop_plot],[0 0],'k--')
        set(gca,'XTick',datenum(YYYY0:YYYY1,1,1),'FontSize',14); datetick('x','keepticks','keeplimits');
        axis([t0_plot tstop_plot vmin vmax]);
        ylabel('Shoreline pos. [m] (f*g)','FontSize',16,'FontWeight','bold');

        han1=legend('observations','model'); set(han1,'Position',[0.792580544077902 0.199422924643398 0.122857140281371 0.0449999987620573],'FontSize',16);

        %         annotation(gcf,'arrow',[0.541041666666667-0.01 0.794791666666667-0.017],[0.619 0.619]);
        %         annotation(gcf,'arrow',[0.270625-0.01 0.524791666666667-0.017],[0.619 0.619]);
        %         annotation(gcf,'arrow',[0.0610416666666667-0.01 0.255208333333334-0.017],[0.619 0.619]);
        %         annotation(gcf,'arrow',[0.810416666666667-0.01 0.956666666666667-0.006],[0.619 0.619]);
        %
        %         annotation(gcf,'arrow',[0.270-0.01 0.270-0.01],[0.57037037037037 0.152222222222222]);
        %         annotation(gcf,'arrow',[0.5403-0.01 0.5403-0.01],[0.57037037037037 0.285]);
        %         annotation(gcf,'arrow',[0.809166666666667-0.01 0.809375-0.01],[0.564444444444444 0.162]);

        annotation(gcf,'textbox',[0.0975714285714286 0.927692307692308 0.0217142857142857 0.0296678288602344],'string','A','FontSize',18,'FontWeight','bold','BackgroundColor','w');
        annotation(gcf,'textbox',[0.0975714285714286 0.927692307692308-(height+ysep)+0.005 0.0217142857142857 0.0296678288602344],'string','B','FontSize',18,'FontWeight','bold','BackgroundColor','w');
        annotation(gcf,'textbox',[0.0975714285714286 0.927692307692308-2*(height+ysep) 0.0217142857142857 0.0296678288602344],'string','C','FontSize',18,'FontWeight','bold','BackgroundColor','w');
        annotation(gcf,'textbox',[0.0975714285714286 0.927692307692308-3*(height+ysep) 0.0217142857142857 0.0296678288602344],'string','D','FontSize',18,'FontWeight','bold','BackgroundColor','w');
        annotation(gcf,'textbox',[0.0975714285714286 0.927692307692308-4*(height+ysep) 0.0217142857142857 0.0296678288602344],'string','E','FontSize',18,'FontWeight','bold','BackgroundColor','w');

        drawnow

        if MAKE_ANIMATION % make gif animation

            % grab frame
            frame = getframe(gcf);
            im=frame2im(frame);

            [imind,cm]=rgb2ind(im,256);

            if count == 1
                imwrite(imind,cm,filename,'gif', 'Loopcount',inf,'delaytime',1/fps);
            else
                imwrite(imind,cm,filename,'gif','WriteMode','append','delaytime',1/fps);
            end

            count=count+1;

        end

    end

end


if 0
    figure;
    for i=1:Ntr
        subplot(Ntr,1,i); han1=plot(t,getfield(Ycal(p),{1:length(t),i}),'-r',t_obs_cal,Yobs(:,i),'-bo',t_obs_cal,Yobs(:,i),'-bo',t_obs,Yobs_raw(:,i),'-c.'); set(han1,'MarkerFaceColor','b','MarkerSize',5); set(gca,'XLim',[t(1) max(t_output)],'YLim',[-25 25],'FontSize',16); datetick('x','keeplimits','keepticks');
    end

    stop

    figure; count=1;
    for i=[2 5 8]
        subplot(3,1,count); han1=plot(t,getfield(Ycal(p),{1:length(t),i}),'-r',t,getfield(Ylst_conv(p,t,Hs,Dir),{1:length(t),i}),'-b',t_obs_cal,Yobs(:,i),'-bo',t_obs_cal,Yobs_raw(:,i),'-c.'); set(han1,'MarkerFaceColor','b','MarkerSize',4); set(gca,'XLim',[t(1) max(t_output)],'YLim',[-25 25],'FontSize',16); datetick('x','keeplimits','keepticks');
        count=count+1;
    end

    han1=legend('model','longshore transport only','obs'); set(han1,'location','northwest');

    figure; count=1;
    for i=[2 5 8]
        subplot(3,1,count); han1=plot(t,Yst_ts(p,t,Hs),'-r',ti_obs,YCS(:,i),'-bo',t_obs_cal,Yobs_raw(:,i),'-c.'); set(han1,'MarkerFaceColor','b','MarkerSize',4); set(gca,'XLim',[t(1) max(t_output)],'YLim',[-25 25],'FontSize',16); datetick('x','keeplimits','keepticks');
        count=count+1;
    end

    han1=legend('cross-shore transport only','obs (Longshore component only)'); set(han1,'location','northwest');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% plot a Taylor diagram of the model skill
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

RMSEn1=0; % traget values of RMSEn, STDn, and COR
STDn1=1;
COR1=1;
L1=0;

% some final skill metrics to output
RMSEn1=cat(1,RMSEn1,RMSEn_opt');
STDn1=cat(1,STDn1,STDn_opt');
COR1=cat(1,COR1,COR_opt');
L1=cat(1,L1,L_opt');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Add matlab helper routines toolbox to the path (the kml toolobx is the most important here ... but others might be too)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
matlab_helpers_toolbox='SkillMetricsToolbox-master';
addpath(genpath(matlab_helpers_toolbox));

figure;

%[hp, ht, axl] = taylor_diagram(STDn1,RMSEn1,COR1,'tickSTD',[0:0.1:1],'axismax',[1 1]);

label = containers.Map({'transect 1','transect 2','transect 3','transect 4','transect 5','transect 6','transect 7','transect 8','transect 9'}, {'ro', 'go', 'bo','co','ko','mo','rd','gd', 'bd'});

%label = containers.Map({'Model 1'}, {'ro'});

% Plot first data point (red) on existing diagram
alpha = 1.0;
[hp, ht, axl] = taylor_diagram(STDn1(1:2),RMSEn1(1:2),COR1(1:2), ...
    'markerLabel',label, 'markerKey','transect 1', ...
    'markerLegend', 'off', 'alpha', alpha, ...
    'tickRMS',0.0:0.25:1.25,'tickRMSangle',120.0,'rmslabelformat','%.2f',...
    'colRMS','m', 'styleRMS', ':', 'widthRMS', 1.5, ...
    'tickSTD',0.0:.25:1.5, 'limSTD',1.5, ...
    'colSTD','b', 'styleSTD', '-.', 'widthSTD', 1.0, ...
    'colCOR','k', 'styleCOR', '--', 'widthCOR', 1.0, ...
    'styleOBS','-','colOBS','k','markerobs','o','titleOBS','target');

for i=2:Ntr
    % Overlay second data point (black) on existing diagram
    taylor_diagram(STDn1([1 i+1]),RMSEn1([1 i+1]),COR1([1 i+1]), ...
        'overlay','on', 'alpha', alpha, ...
        'markerLabel',label,  'markerKey',['transect ',num2str(i)]);

    drawnow;
end