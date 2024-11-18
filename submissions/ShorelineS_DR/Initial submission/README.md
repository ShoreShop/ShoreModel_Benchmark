ShorelineS model
Model description
ShorelineS is an open-source numerical model for coastal planform evolution, based on one-dimensional equations for alongshore sediment transport and mass conservation, on a free-form grid that may consist of several coastal sections represented as strings of coastline points, see Roelvink et al (2000). The coastline sections can evolve freely and may include undulations, islands, spits, salient and tombolos; the sections may influence each other through shadowing and may merge or split. A range of hard elements or coastal structures are supported, such as groynes, T-groynes, offshore breakwaters and revetments; processes simulated include bypassing and diffraction. A range of longshore (bulk) transport formulas is available and soft engineering measures such as beach- and nearshore nourishments can be simulated. 
The basic equation for the updating of the coastline position is based on the conservation of sediment:
 	
   dn/dt=-1/Dc dQs/ds - RSLR/tan beta + 1/Dc sum (qi)

 where n is the cross-shore coordinate, s the longshore coordinate, t is time, Dc is the active profile height (m
), Qs is the longshore transport (m3/yr), tan β is the average profile slope between the dune or barrier crest and the depth of closure, RSLR is the relative sea-level rise (m/yr) and qi is the source/sink term (m3/m/yr) due to cross-shore transport, overwashing, nourishments, sand mining and exchanges with rivers and tidal inlets. 
At each point the local direction of the coast is determined from the two adjacent points (as a reference line), then the longshore transport is calculated for each segment. The difference leads the points to build out or to shrink. The mass conservation equation is solved using a staggered forward time–central space explicit scheme. 
Model implementation
The ShorelineS model was applied to Task1. Short-term prediction and Task2. Medium-term prediction. At present, ShorelineS has cross-shore processes due to dune erosion and accretion, and due to slow feeding of nearshore nourishments, but no equilibrium-type formulations as in i.e. ShoreFor. Therefore we ran it in purely longshore mode, and to reduce complexity even further, with the simplest CERC formula:

CERC 1 :	Q_s=bH_(S,off)^(5/2)  sin⁡2 (ϕ_off)	

We ran this with the wave conditions defined at the 10 m line at all transects. We noted that the wave conditions there were almost exactly equal and led to a mean angle of wave energy flux of around 117 deg. 
We applied closed boundaries at both sides as we checked that it was an enclosed beach, and ran the model with a 50 m resolution. However, having an almost uniform wave climate, we could not possibly explain the curvature all the coastlines; in preliminary runs we did get a beach rotation depending on the wave conditions, but never with significant curvature.
In reality we would look at Google Earth and determine the geometry of the headlands or groynes on either side, and implement these as hard polygons, automatically defining the diffraction points. Since we had no information on the geometry of the headlands we played around with different southern and northern groynes until we got a coastline behaviour that was close enough to the observed behaviour. A snapshot of the end of the calibration run shows the geometry we chose.
Of course this type of ‘reverse engineering’ is not really desirable and we would much have preferred to have more (readily available) data on the actual situation. As it stands, we used only one groyne in the north, which gave a significant diffraction pattern and affected the orientation of much of the beach, which would otherwise be out of synch with the mean wave direction by approx.. 4 degrees.
Given this uncertainty in boundary conditions we kept the rest of the calibration process very simple and just adjusted the value of b in the CERC formula between 0.1e6 and 0.3e6, to best match the amplitude of shoreline changes within each year. Here, we found a reasonable match in amplitudes for a value of b=0.3e6 .
For the short-term prediction 1999-2023 and the medium-term prediction 1951-1998 we used exactly the same settings and model setup, and just applied the relevant initial coastline for both cases.

Model classification
Model mechanics
x	  Process-Based Models (PBM): couple hydrodynamics, waves, and morphodynamics through mass and momentum conservation laws.
	  Hybrid Models (HM): use observational data to calibrate free parameters in the equilibrium configuration of a system.
	  Data-Driven Models (DDM): use observational data to train regression models (e.g. machine learning, statistical downscaling).
Model elements (multiple choices)
	  Cross-shore: model the shoreline position for each transect independently.
x	  Long-shore: incorporate the interaction of shoreline position across different transects.
	  Sea level: consider the impact of sea level rise on shoreline position.
References
Roelvink, Huisman, Elghandour, Ghonim, Reyns (2020).. Efficient modelling of complex sandy coastal evolution at monthly to century time scales. Frontiers in Marine Science 7, 535.

