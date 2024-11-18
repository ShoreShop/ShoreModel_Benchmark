ShorelineS model
Model description
ShorelineS is an open-source numerical model for coastal planform evolution, based on one-dimensional equations for alongshore sediment transport and mass conservation, on a free-form grid that may consist of several coastal sections represented as strings of coastline points, see Roelvink et al (2000). The coastline sections can evolve freely and may include undulations, islands, spits, salient and tombolos; the sections may influence each other through shadowing and may merge or split. A range of hard elements or coastal structures are supported, such as groynes, T-groynes, offshore breakwaters and revetments; processes simulated include bypassing and diffraction. A range of longshore (bulk) transport formulas is available and soft engineering measures such as beach- and nearshore nourishments can be simulated. 
The basic equation for the updating of the coastline position is based on the conservation of sediment:
	
 where n is the cross-shore coordinate, s the longshore coordinate, t is time, Dc is the active profile height (m), Qs is the longshore transport (m3/yr), tan ? is the average profile slope between the dune or barrier crest and the depth of closure, RSLR is the relative sea-level rise (m/yr) and qi is the source/sink term (m3/m/yr) due to cross-shore transport, overwashing, nourishments, sand mining and exchanges with rivers and tidal inlets. 
At each point the local direction of the coast is determined from the two adjacent points (as a reference line), then the longshore transport is calculated for each segment. The difference leads the points to build out or to shrink. The mass conservation equation is solved using a staggered forward time–central space explicit scheme. 
Model implementation (step 1)
The ShorelineS model was applied to Task1. Short-term prediction and Task2. Medium-term prediction. At present, ShorelineS has cross-shore processes due to dune erosion and accretion, and due to slow feeding of nearshore nourishments, but no equilibrium-type formulations as in i.e. ShoreFor. Therefore we ran it in purely longshore mode, and to reduce complexity even further, with the simplest CERC formula:
CERC 1 :	Q_s=bH_(S,off)^(5/2)  sin?2 (?_off)	
We ran this with the wave conditions defined at the 10 m line at all transects. We noted that the wave conditions there were almost exactly equal and led to a mean angle of wave energy flux of around 117 deg. 
We applied closed boundaries at both sides as we checked that it was an enclosed beach, and ran the model with a 50 m resolution. However, having an almost uniform wave climate, we could not possibly explain the curvature all the coastlines; in preliminary runs we did get a beach rotation depending on the wave conditions, but never with significant curvature.
In reality we would look at Google Earth and determine the geometry of the headlands or groynes on either side, and implement these as hard polygons, automatically defining the diffraction points. Since we had no information on the geometry of the headlands we played around with different southern and northern groynes until we got a coastline behaviour that was close enough to the observed behaviour. A snapshot of the end of the calibration run shows the geometry we chose.
Of course this type of ‘reverse engineering’ is not really desirable and we would much have preferred to have more (readily available) data on the actual situation. As it stands, we used only one groyne in the north, which gave a significant diffraction pattern and affected the orientation of much of the beach, which would otherwise be out of synch with the mean wave direction by approx.. 4 degrees.
Given this uncertainty in boundary conditions we kept the rest of the calibration process very simple and just adjusted the value of b in the CERC formula between 0.1e6 and 0.3e6, to best match the amplitude of shoreline changes within each year. Here, we found a reasonable match in amplitudes for a value of b=0.3e61.
For the short-term prediction 1999-2023 and the medium-term prediction 1951-1998 we used exactly the same settings and model setup, and just applied the relevant initial coastline for both cases.

Model implementation (step 2)
The ShorelineS model was applied to Task1. Short-term prediction and Task2. Medium-term prediction. At present, ShorelineS has cross-shore processes due to dune erosion and accretion, and due to slow feeding of nearshore nourishments, but no equilibrium-type formulations as in i.e. ShoreFor. Therefore we ran it in purely longshore mode.
In this submission we knew the location and used the actual geometry of the headlands on either side of CurlCurl beach.

We observed that Profile 1 is 230 m from the northern headland and Profile 9 ~50 m from the southern headland, so we extended the coastlines to both headlands.
We switched to the CERC3 formulationas it includes a term for the longshore gradient in wave height, which is important for pocket beaches.
The CERC3 formula is widely used in models worldwide such as GENESIS. It is the more common version of the CERC tranport formula (USACE, 1984) which is applied after the wave transformation has taken place (e.g. in a 2D wave model). It is still a very basic formulation. The refracted wave height at the point-of-breaking (Hs,br) and the wave direction (?br) at this location determine the transport rate. A theoretical value is computed by the model for the scaling parameter b as defined in the Shore Protection Manual (USACE, 1984). By default a k parameter of 0.35 is used. The ? and ?s are the density of water and sediment (kg/m3), while p is the porosity.

CERC 3 :	Qs=b HSbr^(5/2)  sin 2 (phi_br) 	 

	with b according to USACE(1984)
	
The general scaling parameter qscal is applied to tune the transport formulation to local conditions. In our case, after trying several values, a value of 0.3 was applied, based on a comparison of the amplitudes of shoreline position changes at both ends. No automatic calibration or data assimilation was applied in this case.
Model bias correction
Although the model preserved the general shape of the coastline quite well, there was a systematic error in the orientation of the beach.
Correction needed1  15.52   2.93  -4.14 -10.65  17.36 -25.07 -29.38 -30.09  15.7This amounts to a small error in beach orientation of 2-3 %, which could easily be attributed to an uncertainty in the wave climate. 
This bias could be corrected in different ways, but the most simple and straightforward was to add the correction to the output time series of coastline position, both for the calibration run and for the short- and medium term predictions. So, for each model setting, we ran the calibration period, computed the mean difference between observed and computed coastline positions and stored these; then applied the correction to the output results of the medium and short term predictions.

Model classification
Model mechanics
X  Process-Based Models (PBM): couple hydrodynamics, waves, and morphodynamics through mass and momentum conservation laws.
*  Hybrid Models (HM): use observational data to calibrate free parameters in the equilibrium configuration of a system.
*  Data-Driven Models (DDM): use observational data to train regression models (e.g. machine learning, statistical downscaling).
Model elements (multiple choices)
*  Cross-shore: model the shoreline position for each transect independently.
X  Long-shore: incorporate the interaction of shoreline position across different transects.
*  Sea level: consider the impact of sea level rise on shoreline position.
References
Roelvink, Huisman, Elghandour, Ghonim, Reyns (2020).. Efficient modelling of complex sandy coastal evolution at monthly to century time scales. Frontiers in Marine Science 7, 535.

