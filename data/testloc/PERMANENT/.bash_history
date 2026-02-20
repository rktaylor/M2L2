v.in.ascii input=/home/csdc-library1/GIS_Database/Penaguila_UTM30/PERMANENT/.tmp/csdclibrary1-OptiPlex-790/6054.0 output=Mas_d_is
g.remove rast=BDRK@PERMANENT,cfactor@PERMANENT,dep25@PERMANENT,dif1@PERMANENT,dif_100@PERMANENT,dif_20_rr@PERMANENT,dif_30@PERMANENT,diff100@PERMANENT,er25@PERMANENT,newdiff@PERMANENT
g.region -s rast=DEM@PERMANENT
g.region -s -p rast=DEM@PERMANENT
v.build.all
r.catchment.py -k -c elev=DEM@PERMANENT vect=Mas_d_is@PERMANENT buffer=farm_catch_10yr_30ppl sigma=10 area=3171429 mapval=1
g.remove rast=MASK@PERMANENT
r.what --v -f -n input=farm_catch_10yr_30ppl_cost_surface@PERMANENT east_north=728376.292190,4287788.281299
r.what --v -f -n input=farm_catch_10yr_30ppl_cost_surface@PERMANENT east_north=728291.765577,4287252.946080
r.what --v -f -n input=farm_catch_10yr_30ppl_cost_surface@PERMANENT east_north=734293.155141,4289873.271101
r.what --v -f -n input=farm_catch_10yr_30ppl_cost_surface@PERMANENT east_north=732179.989802,4286013.222414
r.what --v -f -n input=farm_catch_10yr_30ppl_cost_surface@PERMANENT east_north=737364.288768,4292070.963054
r.what --v -f -n input=farm_catch_10yr_30ppl_cost_surface@PERMANENT east_north=736434.496019,4291789.207676
r.what --v -f -n input=farm_catch_10yr_30ppl_cost_surface@PERMANENT east_north=735870.985262,4291507.452297
r.what --v -f -n input=farm_catch_10yr_30ppl_cost_surface@PERMANENT east_north=736885.304625,4292070.963054
r.what --v -f -n input=farm_catch_10yr_30ppl_cost_surface@PERMANENT east_north=736180.916178,4291620.154449
r.what --v -f -n input=farm_catch_10yr_30ppl_cost_surface@PERMANENT east_north=737786.921836,4292127.314130
r.what --v -f -n input=farm_catch_10yr_30ppl_cost_surface@PERMANENT east_north=737815.097374,4292211.840744
r.what --v -f -n input=farm_catch_10yr_30ppl_cost_surface@PERMANENT east_north=737786.921836,4292183.665206
r.mapcalc graze_catch = if(isnull( DEM@PERMANENT ), null(), 1)
r.mapcalc init_veg = if(isnull( DEM@PERMANENT ), null(), 50)
r.soildepth.py -s elev=DEM@PERMANENT bedrock=init_bdrk soildepth=init_soildepth min=1 max=40 slopebreaks=15,0.5;45,0.15 curvebreaks=-0.015,-0.5;0.015,0.5 smoothingtype=median smoothingsize=5
g.remove rast=temporary.slope@PERMANENT
r.agropast.semiadaptive.0.4.py &
r.agropast.semiadaptive.0.4.py &
r.catchment.py&
r.soildepth.py&
exit
g.region -p
r.agropast.semiadaptive.0.4.py &
exit
r.mapcalc init_fert = if(isnull( DEM@PERMANENT), null(), 100)
r.landscape.evol.py -p elev=DEM@PERMANENT initbdrk=init_bdrk@PERMANENT Kt=0.001 loadexp=2.5 rain=20.44 R=4.45 storms=23 smoothing=no prefx=levol_ outdem=elevation outsoil=soildepth number=1
g.remove rast=14396_rainfall_excess_map_0001@PERMANENT,14396flowacc_largenums0001@PERMANENT,14396flowdir0001@PERMANENT
r.landscape.evol.py&
r.landscape.evol.py&
which gdal
which gdal
g.version -r
exit
gsettings set org.gnome.desktop.interface ubuntu-overlay-scrollbars false 
lsb_release -a
exit
exit
r.mapcalc --overwrite expression=farm_catch_10yr_30ppl = if(isnull(farm_catch_10yr_30ppl@PERMANENT), null(), int(farm_catch_10yr_30ppl@PERMANENT ))
r.info map=farm_catch_10yr_30ppl@PERMANENT
exit
r.watershed -a elevation=farm_catch_10yr_30ppl_cost_surface@PERMANENT accumulation=cost_acc
r.univar map=cost_acc@PERMANENT,farm_catch_10yr_30ppl_cost_surface@PERMANENT
r.univar -g map=cost_acc@PERMANENT,farm_catch_10yr_30ppl_cost_surface@PERMANENT
r.mapcalc expression=inv_cost = 1388802.30848678 - farm_catch_10yr_30ppl_cost_surface@PERMANENT
r.watershed -a --overwrite elevation=inv_cost@PERMANENT accumulation=cost_acc
r.watershed -a --overwrite elevation=farm_catch_10yr_30ppl_cost_surface@PERMANENT accumulation=cost_acc
r.watershed -a --overwrite elevation=farm_catch_10yr_30ppl_cost_surface@PERMANENT accumulation=cost_acc convergence=1
r.watershed -a --overwrite elevation=farm_catch_10yr_30ppl_cost_surface@PERMANENT threshold=1000 accumulation=cost_acc basin=cost_basins convergence=1
r.watershed -a --overwrite elevation=farm_catch_10yr_30ppl_cost_surface@PERMANENT threshold=5000 accumulation=cost_acc basin=cost_basins convergence=1
r.stream.extract elevation=DEM@PERMANENT accumulation=cost_acc@PERMANENT threshold=5000 stream_rast=cost_streams
r.stream.extract --overwrite elevation=DEM@PERMANENT accumulation=cost_acc@PERMANENT threshold=1000 stream_rast=cost_streams
r.watershed -a --overwrite elevation=farm_catch_10yr_30ppl_cost_surface@PERMANENT threshold=5000 accumulation=cost_acc basin=cost_basins stream=cost_streams convergence=1
r.watershed -a --overwrite elevation=farm_catch_10yr_30ppl_cost_surface@PERMANENT threshold=10000 accumulation=cost_acc basin=cost_basins stream=cost_streams convergence=1
r.watershed -a --overwrite elevation=farm_catch_10yr_30ppl_cost_surface@PERMANENT threshold=1000 accumulation=cost_acc basin=cost_basins stream=cost_streams convergence=1
r.watershed -a -b --overwrite elevation=farm_catch_10yr_30ppl_cost_surface@PERMANENT threshold=1000 accumulation=cost_acc basin=cost_basins stream=cost_streams convergence=1
r.watershed -a -b --overwrite elevation=inv_cost@PERMANENT threshold=1000 accumulation=cost_acc basin=cost_basins stream=cost_streams convergence=1
r.watershed -a -b --overwrite elevation=inv_cost@PERMANENT threshold=5000 accumulation=cost_acc basin=cost_basins stream=cost_streams convergence=1
r.watershed -a --overwrite elevation=inv_cost@PERMANENT threshold=5000 accumulation=cost_acc basin=cost_basins stream=cost_streams convergence=1
r.watershed -a --overwrite elevation=inv_cost@PERMANENT threshold=1000 accumulation=cost_acc basin=cost_basins stream=cost_streams convergence=1
g.extension.rebuild.all.py -f
g.extension.py extension=r.stream.extract svnurl=http://svn.osgeo.org/grass/grass-addons/grass6
g.extension.py extension=r.stream.order svnurl=http://svn.osgeo.org/grass/grass-addons/grass6
g.extension.py extension=r.stream.basins svnurl=http://svn.osgeo.org/grass/grass-addons/grass6
r.watershed -a --overwrite elevation=farm_catch_10yr_30ppl_cost_surface@PERMANENT threshold=1000 accumulation=cost_acc basin=cost_basins stream=cost_streams convergence=1
r.watershed -a --overwrite elevation=farm_catch_10yr_30ppl_cost_surface@PERMANENT threshold=1000 accumulation=cost_acc drainage=costs_dir basin=cost_basins stream=cost_streams convergence=1
r.stream.order stream=cost_streams@PERMANENT dir=costs_dir@PERMANENT strahler=costs_strahler
r.stream.basins dir=costs_dir@PERMANENT stream=costs_strahler@PERMANENT basins=cost_basins
r.stream.basins --overwrite dir=costs_dir@PERMANENT stream=costs_strahler@PERMANENT basins=cost_basins
r.watershed -a --overwrite elevation=farm_catch_10yr_30ppl_cost_surface@PERMANENT threshold=500 accumulation=cost_acc drainage=costs_dir stream=cost_streams convergence=1
r.watershed -a --overwrite elevation=farm_catch_10yr_30ppl_cost_surface@PERMANENT threshold=100 accumulation=cost_acc drainage=costs_dir stream=cost_streams convergence=1
r.stream.order --overwrite stream=cost_streams@PERMANENT dir=costs_dir@PERMANENT strahler=costs_strahler
r.stream.basins --overwrite dir=costs_dir@PERMANENT stream=costs_strahler@PERMANENT basins=cost_basins
r.stream.basins --overwrite dir=costs_dir@PERMANENT stream=costs_strahler@PERMANENT cats=1 basins=cost_basins
r.stream.basins --overwrite dir=costs_dir@PERMANENT stream=costs_strahler@PERMANENT cats=4 basins=cost_basins
r.stream.basins --overwrite dir=costs_dir@PERMANENT stream=costs_strahler@PERMANENT basins=cost_basins
r.stream.order --overwrite stream=cost_streams@PERMANENT dir=costs_dir@PERMANENT strahler=costs_strahler horton=costs_horton
r.stream.basins --overwrite dir=costs_dir@PERMANENT stream=costs_horton@PERMANENT basins=cost_basins
r.stream.order --overwrite stream=cost_streams@PERMANENT dir=costs_dir@PERMANENT strahler=costs_strahler shreve=costs_shreve horton=costs_horton hack=costs_hack
r.stream.basins --overwrite dir=costs_dir@PERMANENT stream=costs_shreve@PERMANENT basins=cost_basins
r.stream.basins --overwrite dir=costs_dir@PERMANENT stream=costs_hack@PERMANENT basins=cost_basins
r.watershed -a --overwrite elevation=inv_cost@PERMANENT threshold=100 accumulation=cost_acc drainage=costs_dir stream=cost_streams convergence=1
r.stream.order --overwrite stream=cost_streams@PERMANENT dir=costs_dir@PERMANENT strahler=costs_strahler shreve=costs_shreve horton=costs_horton hack=costs_hack
r.stream.basins --overwrite dir=costs_dir@PERMANENT stream=costs_hack@PERMANENT basins=cost_basins
r.stream.basins --overwrite dir=costs_dir@PERMANENT stream=costs_horton@PERMANENT basins=cost_basins
r.watershed -a --overwrite elevation=farm_catch_10yr_30ppl_cost_surface@PERMANENT threshold=100 accumulation=cost_acc drainage=costs_dir stream=cost_streams convergence=1
r.stream.order --overwrite stream=cost_streams@PERMANENT dir=costs_dir@PERMANENT strahler=costs_strahler shreve=costs_shreve horton=costs_horton hack=costs_hack
r.stream.basins --overwrite dir=costs_dir@PERMANENT stream=costs_horton@PERMANENT basins=cost_basins
r.stream.basins -l --overwrite dir=costs_dir@PERMANENT stream=costs_horton@PERMANENT basins=cost_basins
r.stream.basins -l --overwrite dir=costs_dir@PERMANENT stream=costs_strahler@PERMANENT basins=cost_basins
r.stream.basins -l --overwrite dir=costs_dir@PERMANENT stream=cost_streams@PERMANENT basins=cost_basins
r.stream.basins --overwrite dir=costs_dir@PERMANENT stream=cost_streams@PERMANENT basins=cost_basins
r.stream.basins --overwrite dir=costs_dir@PERMANENT stream=costs_strahler@PERMANENT basins=cost_basins
r.watershed -a --overwrite elevation=farm_catch_10yr_30ppl_cost_surface@PERMANENT threshold=10000 accumulation=cost_acc drainage=costs_dir stream=cost_streams convergence=1
r.stream.order --overwrite stream=cost_streams@PERMANENT dir=costs_dir@PERMANENT strahler=costs_strahler shreve=costs_shreve horton=costs_horton hack=costs_hack
r.stream.basins --overwrite dir=costs_dir@PERMANENT stream=costs_strahler@PERMANENT basins=cost_basins
r.stream.basins --overwrite dir=costs_dir@PERMANENT stream=cost_streams@PERMANENT basins=cost_basins
r.watershed -a --overwrite elevation=farm_catch_10yr_30ppl_cost_surface@PERMANENT threshold=100000 accumulation=cost_acc drainage=costs_dir stream=cost_streams convergence=1
r.stream.basins --overwrite dir=costs_dir@PERMANENT stream=cost_streams@PERMANENT basins=cost_basins
r.watershed -a --overwrite elevation=farm_catch_10yr_30ppl_cost_surface@PERMANENT threshold=50000 accumulation=cost_acc drainage=costs_dir stream=cost_streams convergence=1
r.stream.basins --overwrite dir=costs_dir@PERMANENT stream=cost_streams@PERMANENT basins=cost_basins
r.watershed -a --overwrite elevation=farm_catch_10yr_30ppl_cost_surface@PERMANENT threshold=20000 accumulation=cost_acc drainage=costs_dir stream=cost_streams convergence=1
r.stream.basins --overwrite dir=costs_dir@PERMANENT stream=cost_streams@PERMANENT basins=cost_basins
r.watershed -a --overwrite elevation=farm_catch_10yr_30ppl_cost_surface@PERMANENT threshold=10000 accumulation=cost_acc drainage=costs_dir stream=cost_streams convergence=1
r.stream.basins --overwrite dir=costs_dir@PERMANENT stream=cost_streams@PERMANENT basins=cost_basins
r.watershed -a --overwrite elevation=farm_catch_10yr_30ppl_cost_surface@PERMANENT threshold=1000 accumulation=cost_acc drainage=costs_dir stream=cost_streams convergence=1
r.stream.basins --overwrite dir=costs_dir@PERMANENT stream=cost_streams@PERMANENT basins=cost_basins
r.watershed -a --overwrite elevation=farm_catch_10yr_30ppl_cost_surface@PERMANENT threshold=5000 accumulation=cost_acc drainage=costs_dir stream=cost_streams convergence=1
r.stream.basins --overwrite dir=costs_dir@PERMANENT stream=cost_streams@PERMANENT basins=cost_basins
r.watershed -a --overwrite elevation=farm_catch_10yr_30ppl_cost_surface@PERMANENT threshold=2500 accumulation=cost_acc drainage=costs_dir stream=cost_streams convergence=1
r.stream.basins --overwrite dir=costs_dir@PERMANENT stream=cost_streams@PERMANENT basins=cost_basins
r.watershed -a --overwrite elevation=farm_catch_10yr_30ppl_cost_surface@PERMANENT threshold=2500 accumulation=cost_acc drainage=costs_dir basin=cost_basin stream=cost_streams convergence=1
r.stats input=cost_basin@PERMANENT
r.stats -a -n input=cost_basin@PERMANENT
r.stats -c -n input=cost_basin@PERMANENT
r.stream.extract&
r.stream.extract&
r.stream.order&
r.stream.basins&
exit
r.mapcalc expression=aatteesstt = if( cost_basin@PERMANENT = 21 || cost_basin = 22, 3, null())
r.mapcalc expression=aatteesstt = if(cost_basin@PERMANENT == 21 || cost_basin == 22, 3, null())
time r.agropast.semiadaptive7.0.5.py -i -1 years=500 prfx=aatestsim costsurf=farm_catch_10yr_30ppl_cost_surface@PERMANENT agcatch=farm_catch_10yr_30ppl@PERMANENT grazecatch=graze_catch@PERMANENT fodder_rules=/home/mdlpd/Dropbox/Scripts_Working_Dir/rules/fodder_rules.txt inlcov=init_veg@PERMANENT infert=init_fert@PERMANENT lc_rules=/home/mdlpd/Dropbox/Scripts_Working_Dir/rules/luse_reclass_rules.txt cfact_rules=/home/mdlpd/Dropbox/Scripts_Working_Dir/rules/cfactor_recode_rules.txt elev=DEM@PERMANENT initbdrk=init_bdrk@PERMANENT
time r.agropast.semiadaptive7.0.5.py -i -1 years=500 prfx=aatestsim costsurf=farm_catch_10yr_30ppl_cost_surface@PERMANENT agcatch=farm_catch_10yr_30ppl@PERMANENT grazecatch=graze_catch@PERMANENT fodder_rules=/home/mdlpd/Dropbox/Scripts_Working_Dir/rules/fodder_rules.txt inlcov=init_veg@PERMANENT infert=init_fert@PERMANENT lc_rules=/home/mdlpd/Dropbox/Scripts_Working_Dir/rules/luse_reclass_rules.txt cfact_rules=/home/mdlpd/Dropbox/Scripts_Working_Dir/rules/cfactor_recode_rules.txt elev=DEM@PERMANENT initbdrk=init_bdrk@PERMANENT
time r.agropast.semiadaptive7.0.5.py -i -1 years=500 prfx=aatestsim costsurf=farm_catch_10yr_30ppl_cost_surface@PERMANENT agcatch=farm_catch_10yr_30ppl@PERMANENT grazecatch=graze_catch@PERMANENT fodder_rules=/home/mdlpd/Dropbox/Scripts_Working_Dir/rules/fodder_rules.txt inlcov=init_veg@PERMANENT infert=init_fert@PERMANENT lc_rules=/home/mdlpd/Dropbox/Scripts_Working_Dir/rules/luse_reclass_rules.txt cfact_rules=/home/mdlpd/Dropbox/Scripts_Working_Dir/rules/cfactor_recode_rules.txt elev=DEM@PERMANENT initbdrk=init_bdrk@PERMANENT
g.mremove type=rast pattern=aa*,11* -f
exit
g.mlist -m type=rast pattern=*Year_500_Elevation_Map@*
g.mlist -m type=rast pattern=*Year_500_Elevation_Map*
g.mlist -m type=rast pattern=*Year_500_Elevation_Map*
r.watershed elevation=DEM@PERMANENT threshold=1000 stream=streams
r.watershed --overwrite elevation=DEM@PERMANENT threshold=10000 stream=streams
r.watershed --overwrite elevation=DEM@PERMANENT threshold=100000 stream=streams
r.watershed --overwrite elevation=DEM@PERMANENT threshold=50000 stream=streams
r.watershed --overwrite elevation=DEM@PERMANENT threshold=30000 stream=streams
r.watershed --overwrite elevation=DEM@PERMANENT threshold=20000 stream=streams
r.watershed --overwrite elevation=DEM@PERMANENT threshold=15000 stream=streams
r.watershed --overwrite elevation=DEM@PERMANENT threshold=10000 stream=streams
r.watershed --overwrite elevation=DEM@PERMANENT threshold=5000 stream=streams
r.slope.aspect elevation=DEM@PERMANENT slope=slope
r.cost -k input=slope@PERMANENT output=streams_cost start_coordinates=724004.143967,4291207.85996
r.cost -k --overwrite input=slope@PERMANENT output=streams_cost start_coordinates=724015.087862,4291197.60006
r.cost -k --overwrite input=slope@PERMANENT output=streams_cost outdir=streams_dir start_coordinates=724015.087862,4291197.60006
r.drain -n -d input=streams_cost@PERMANENT indir=streams_dir@PERMANENT output=masdis_stream_extract start_coordinates=724594.448566,4280298.83786
r.drain -n -d input=streams_cost@PERMANENT indir=streams_dir@PERMANENT output=masdis_stream_extract vector_output=masdis_stream_vect start_coordinates=724594.448566,4280298.83786
r.drain -n -d --overwrite input=streams_cost@PERMANENT indir=streams_dir@PERMANENT output=masdis_stream_extract vector_output=masdis_stream_vect start_coordinates=724594.448566,4280298.83786
r.drain -d --overwrite input=streams_cost@PERMANENT indir=streams_dir@PERMANENT output=masdis_stream_extract vector_output=masdis_stream_vect start_coordinates=724594.448566,4280298.83786
r.drain -c -d --overwrite input=streams_cost@PERMANENT indir=streams_dir@PERMANENT output=masdis_stream_extract vector_output=masdis_stream_vect start_coordinates=724594.448566,4280298.83786
r.drain -n -d --overwrite input=streams_cost@PERMANENT indir=streams_dir@PERMANENT output=masdis_stream_extract vector_output=masdis_stream_vect start_coordinates=724594.448566,4280298.83786
r.drain -n --overwrite input=DEM@PERMANENT output=masdis_stream_extract2 vector_output=masdis_stream_vect2 start_coordinates=724594.448566,4280298.83786
r.stats -1 -n input=masdis_stream_extract@PERMANENT,DEM@PERMANENT
r.stats -1 -n input=masdis_stream_extract@PERMANENT,DEM@PERMANENT sort=desc
r.stats -1 -n input=masdis_stream_extract@PERMANENT,DEM@PERMANENT sort=asc
r.stats -1 -n input=masdis_stream_extract@PERMANENT,DEM@PERMANENT
g.remove rast=aatteesstt@PERMANENT
g.mremove type=rast pattern=costs*,CUMERDEP*
g.mremove type=rast pattern=costs*,CUM*
g.mremove type=rast pattern=costs*,*CUM*
g.mremove -f type=rast pattern=costs*,*CUM*
python ~/stream_stats.py
python ~/stream_stats.py
python ~/stream_stats.py
python ~/stream_stats.py
python ~/stream_stats.py
python ~/stream_stats.py
python ~/stream_stats.py
python ~/stream_stats.py
python ~/stream_stats.py
python ~/stream_stats.py
python ~/stream_stats.py
python ~/stream_stats.py
g.mremove type=rast pattern=*CUMERDEP* -f
python ~/stream_stats.py
g.mremove type=rast pattern=*CUMERDEP* -f
g.mremove type=rast pattern=*CUMERDEP* -f
python ~/stream_stats.py
python ~/stream_stats.py
python ~/stream_stats.py
python ~/stream_stats.py
python ~/stream_stats.py
python ~/stream_stats.py
python ~/stream_stats.py
python sse_stats.py
python sse_stats.py
python sse_stats.py
python sse_stats.py
python ~/stream_stats.py
python sse_stats.py
python ~/stream_stats.py
python stats_accumulator.py
python stats_accumulator.py
python stats_accumulator.py
python stats_accumulator.py
python stats_accumulator.py
python sse_stats.py
python sse_stats.py
python sse_stats.py
python sse_stats.py
python sse_stats.py
python sse_stats.py
python sse_stats.py
python sse_stats.py
python sse_stats.py
exit
r.to.vect input=streams@PERMANENT output=stream1 type=line
r.to.vect -v input=streams@PERMANENT output=stream1 type=line
r.to.vect -v --overwrite input=streams@PERMANENT output=stream1 type=line
g.copy vect=masdis_stream@Exp1_ARCHIVE,masdis_stream_FINAL
g.remove rast=cost_acc@PERMANENT,cost_basins@PERMANENT,cost_streams@PERMANENT,masdis_stream_extract2@PERMANENT
v.to.rast --overwrite input=masdis_stream_FINAL@PERMANENT type=line output=masdis_stream_extract use=cat
r.cost input=masdis_stream_extract@PERMANENT output=masdis_stream_extract_costs start_coordinates=724003.750846,4291206.76583
r.univar map=masdis_stream_extract_costs@PERMANENT
exit
g.remove rast=cost_basin@PERMANENT,streams_cost@PERMANENT,streams_dir@PERMANENT vect=levol_1415_randomly_sampled_points@PERMANENT,masdis_stream_vect2@PERMANENT,masdis_stream_vect@PERMANENT
r.stats input=masdis_stream_extract_costs@PERMANENT,masdis_stream_extract@PERMANENT separator=comma
r.stats -r input=masdis_stream_extract_costs@PERMANENT,masdis_stream_extract@PERMANENT separator=comma
r.stats -r input=masdis_stream_extract_costs@PERMANENT,masdis_stream_extract@PERMANENT separator=comma
r.stats -C input=masdis_stream_extract_costs@PERMANENT,masdis_stream_extract@PERMANENT separator=comma
r.stats -C input=masdis_stream_extract@PERMANENT separator=comma
r.stats -C input=masdis_stream_extract@PERMANENT,DEM@PERMANENT separator=comma
r.mapcalc expression=masdis_stream_extract_elevation=masdis_stream_extract*DEM
r.stats -1 -A input=masdis_stream_extract_costs@PERMANENT,masdis_stream_extract_elevation@PERMANENT separator=comma
r.stats input=masdis_stream_extract_elevation@PERMANENT,masdis_stream_extract_costs@PERMANENT
r.stats -A input=masdis_stream_extract_elevation@PERMANENT,masdis_stream_extract_costs@PERMANENT
r.stats -A input=masdis_stream_extract_costs,masdis_stream_extract_elevation
r.stats -A input=masdis_stream_extract_costs,masdis_stream_extract_elevation
r.stats -1 -A input=masdis_stream_extract_costs,masdis_stream_extract_elevation
r.stats -r input=masdis_stream_extract_costs@PERMANENT,masdis_stream_extract_elevation@PERMANENT
r.stats -A input=masdis_stream_extract_costs@PERMANENT,masdis_stream_extract_elevation@PERMANENT
r.stats -i input=masdis_stream_extract_costs@PERMANENT,masdis_stream_extract_elevation@PERMANENT
r.info map=DEM@PERMANENT
r.stats -r input=masdis_stream_extract_costs@PERMANENT,masdis_stream_extract_elevation@PERMANENT
r.stats -C input=masdis_stream_extract_costs@PERMANENT,masdis_stream_extract_elevation@PERMANENT
r.stats -A input=masdis_stream_extract_costs@PERMANENT,masdis_stream_extract_elevation@PERMANENT
r.stats -A input=masdis_stream_extract_costs@PERMANENT,masdis_stream_extract_elevation@PERMANENT
r.stats -A input=masdis_stream_extract_costs,DEM
r.stats -1 -n input=masdis_stream_extract_costs,DEM separator=comma
r.agropast.semiadaptive7.0.4.py
g.gui
g.gui
exit
g.remove -f type=raster name=levol_soildepth_init@PERMANENT,masdis_stream_extract@PERMANENT,masdis_stream_extract_costs@PERMANENT,masdis_stream_extract_elevation@PERMANENT,slope@PERMANENT,streams@PERMANENT
