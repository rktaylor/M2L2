grass74 
/hdd/GRAS_DB/Spain_EAA2018_ETRS89_z30/pastoral39 
-e --exec r.agropast.adaptive-fire.py 
years=500 
prfx=pastoral 
a_p_ratio=0.80 
costsurf=INIT_cost@catchments agcatch=catchment_agriculture_20pct@catchments 
grazecatch=catchment_grazing_80pct_intensive@catchments 
fodder_rules=/home/user/Dropbox/Scripts_Working_Dir/rules/fodder_rules.txt 
inlcov=INIT_Woodland@catchments 
infert=INIT_fertility@catchments 
fireprob=INIT_fire_prob@catchments 
lc_rules=/home/user/Dropbox/Scripts_Working_Dir/rules/luse_reclass_rules.txt 
cfact_rules=/home/user/Dropbox/Scripts_Working_Dir/rules/cfactor_recode_rules.txt 
elev=INIT_DEM@catchments 
initbdrk=INIT_BDRK@catchments &


/data/testloc/
costsurf=


---

for i in `seq 1 2`; do label="30pf10sim_"$i; r.agropast.semiadaptive7.0.4.py -i -1 numpeople=30 years=300 prfx=$label costsurf=farm_catch_10yr_30ppl_cost_surface@PERMANENT agcatch=farm_catch_10yr_30ppl@PERMANENT grazecatch=graze_catch@PERMANENT fodder_rules=/Users/cmbarton/Dropbox/GRASS_dropbox/grassdata_dropbox/Penaguila/rules/fodder_rules.txt inlcov=init_veg@PERMANENT infert=init_fert@PERMANENT lc_rules=/Users/cmbarton/Dropbox/GRASS_dropbox/grassdata_dropbox/Penaguila/rules/luse_reclass_rules.txt cfact_rules=/Users/cmbarton/Dropbox/GRASS_dropbox/grassdata_dropbox/Penaguila/rules/cfactor_recode_rules.txt elev=DEM@PERMANENT initbdrk=init_bdrk@PERMANENT; done