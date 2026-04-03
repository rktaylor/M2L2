import sys
import os
import subprocess
import tempfile
import json
#grass_install_tree = os.environ.get('GISBASE')
#sys.path.append(os.path.join(grass_install_tree, 'etc', 'python'))
#import grass.script as grass
from grass_helpers import *

grass_sesh = GrassController(
    db=DEFAULT_GISDB,
    loc="testloc",
)

grass = grass_sesh.grass_client
with open('scratch/options.json', 'r') as file:
    config = json.load(file)


def main():
    soildepth = "temp.soildepth"
    tempsdepth = "temp.soildepth2"
    if config.get('soildepth') == None:
        soildepth2 = "temp.soildepth3"
    else:
        soildepth2 = config.get('soildepth')
    elev = config.get('elev')
    bedrock = config.get('bedrock')
    smoothingtype = config.get('smoothingtype')
    smoothingsize = config.get('smoothingsize')
    slopebreaks = config.get('slopebreaks').split(";") 
    curvebreaks = config.get('curvebreaks').split(";") 
    smin = config.get('min')
    smax = config.get('max')
    slope = "temp_slope_deletable"
    pc = "temp_pc_deletable"
    tc = "temp_tc_deletable"
    mc = "temp_mc_deletable"
    temprate = "temp_rate_deletable"
    #let's grab the current resolution
    res = grass.region()['nsres']
    # make color rules for soil depth maps
    sdcolors = tempfile.NamedTemporaryFile(mode="w",delete=False)
    sdcolors.write('100% 0:249:47\n20% 78:151:211\n6% 194:84:171\n0% 227:174:217')
    sdcolors.flush()
    grass.message('STEP 1, Calculating curvatures\n')
    grass.run_command('r.slope.aspect', quiet = "True", overwrite = "True", elevation=elev, slope=slope, pcurv=pc, tcurv=tc)
    #creat meancurvature map (in a manner compatible with older versions of grass6), and then grab some stats from it for the later rescale operation
    grass.mapcalc("${mc}=(${tc}+${pc})/2", quiet = "True", mc = mc, tc = tc, pc = pc)
    mcdict = grass.parse_command('r.univar', flags = "g", map=mc)
    #figuring out if user-supplied curvature breakpoints exceed actual limits of curvature in the map, and adjusting if necessary
    if mcdict['min'] < curvebreaks[0].split(',')[0]:
        y1 = mcdict['min'] + ',' + curvebreaks[0].split(',')[1]
    else:
        y1 = curvebreaks[0]
    if mcdict['max'] > curvebreaks[1].split(',')[0]:
        y2 = mcdict['max'] + ',' + curvebreaks[1].split(',')[1]
    else:
        y2 = curvebreaks[1]
    
    grass.message('STEP 2, Calculating "depth potential" across the landscape\n')
    #nested rescale of first slope (to percentage of maximum soil depth potential), and then curvature (to percentage offset from slope function), and then combining the two measures to make final estimation of soil depth potential. Final output depth potential map will be scaled between 0 and 1, which maps to lowest depth potential to highest depth potential.
    grass.mapcalc("${temprate}=eval(x=graph( ${slope}, 0,1 , ${x1}, ${x2}, 90,0), y=graph(${mc}, ${y1}, 0,0, ${y2}), z=if(y < 0, x+(x*y), x+((1-x)*y)), if(z < 0, 0, if(z > 1, 1, z)))", quiet = "True", temprate = temprate, slope = slope, x1 = slopebreaks[0], x2 = slopebreaks[1], mc = mc, y1 = y1, y2 = y2)

    grass.message('STEP 3, Calculating actual soil depths across the landscape (based on user input min and max soil depth values)\n')
    # create dictionary to record max and min rate so we can rescale it according the user supplied max and min desired soil depths
    ratedict = grass.parse_command('r.univar', flags = "g", map=temprate)
    #creating and running a linear regression to scale the calculated landform soil depth potential into real soil depths using user specified min and max soil depth values
    grass.mapcalc('${soildepth}=graph(${temprate}, ${rmin},${smin}, ${rmax},${smax})', quiet = "True", soildepth = soildepth, temprate = temprate, rmin = ratedict['min'], rmax = ratedict['max'], smin = smin, smax = smax)
    unsmodict = grass.parse_command('r.univar', flags = "g", map=soildepth)
    grass.run_command('r.neighbors', quiet = "True", input=soildepth, output=tempsdepth, size=smoothingsize, method=smoothingtype)
    #fix shrinking edge caused by eighborhood operation (and r.slope.aspect above) by filling in the null areas. We do this by 0.98 * smax, since the null cells are all the cells of the actual drainage divide with slope basically = 0, and very mildly convex curvatures. This basically blends them in nicely with the neighboring cells.
    grass.mapcalc('${soildepth_real}=if(isnull(${input_sdepth}) && isnull(${elev}), null(), if(isnull(${input_sdepth}), 0.98*${smax},${input_sdepth}))', quiet = 'True',  input_sdepth = tempsdepth , soildepth_real = soildepth2, elev = elev, smax = smax)
    #grab some stats if asked to
    if config.get('GIS_FLAG_s') == '1':
        depthdict = grass.parse_command('r.univar', flags = "ge", map=soildepth2, percentile=90)
    
    grass.message('STEP 4, calculating bedrock elevation map\n')
    grass.mapcalc("${bedrock}=eval(x=(${elev} - ${soildepth}), if(isnull(x), ${elev}, x))", quiet = "True", bedrock = bedrock, elev = elev, soildepth = soildepth)
    grass.message('Cleaning up...')
    grass.run_command('g.remove', flags="f", type="rast", name=",".join[pc, tc, mc, slope, soildepth, tempsdepth])
    if config.get('GIS_FLAGS').get("k") == '1':
        grass.run_command('g.rename', quiet = "true", rast = "%s,%s_depth_potential" % (temprate, bedrock))
    else:
        grass.run_command('g.remove', quiet = "True", rast = temprate)
    if config.get('soildepth') is None:
        grass.run_command('g.remove', quiet = "true", rast = soildepth2)
    else:
        grass.run_command('r.colors', quiet = "True", map=soildepth2, rules=sdcolors.name)
    grass.message('\nDONE!\n')
    if config.get('GIS_FLAGS').get("s") == '1':
        grass.message("min, max, and mean before smoothing: " + unsmodict['min']  + ", " + unsmodict['max'] + ", " + unsmodict['mean'])
        for key in depthdict.keys():
            grass.message('%s=%s' % (key,  depthdict[key]))
        grass.message('Total volume of soil is %s cubic meters' % (float(depthdict['sum'])*res*res))
    return
    
# here is where the code in "main" actually gets executed. This way of programming is neccessary for the way g.parser needs to run.
if __name__ == "__main__":
    if ( len(sys.argv) <= 1 or sys.argv[1] != "@ARGS_PARSED@" ):
        os.execvp("g.parser", [sys.argv[0]] + sys.argv)
    else:
        main()





