import fnmatch
import os
import numpy as np
import matplotlib.pyplot as plt
from scipy import stats

###############################
#EDIT VALS BELOW THIS LINE
BASEPATH = '/home/mdlpd/GIS_DataBase/New_penag/records'
FILEPATTERN = '30pf10sim_*_yields_stats.txt'
COLUMN = 20
SKIPHEADER = 35
OUTPUTFILE = "STDEV_GRAZE_RETURNS.csv"
##############################

matches = []
for root, dirnames, filenames in os.walk(BASEPATH):
  for filename in fnmatch.filter(filenames, FILEPATTERN):
      matches.append(os.path.join(root, filename))

all_data = np.genfromtxt(matches.pop(0), dtype=float, delimiter=',', skip_header=SKIPHEADER, usecols=(COLUMN))

for match in matches:
  data = np.genfromtxt(match, dtype=float, delimiter=',', skip_header=SKIPHEADER, usecols=(COLUMN))
  all_data = np.vstack((all_data, data))

np.savetxt("%s%s%s" % (BASEPATH, os.sep, OUTPUTFILE), all_data.T, delimiter=",")
