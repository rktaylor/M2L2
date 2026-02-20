test -r ~/.alias && . ~/.alias
PS1='GRASS 7.1.svn (Penaguila):\w > '
grass_prompt() {
	LOCATION="`g.gisenv GISDBASE`/`g.gisenv LOCATION_NAME`/`g.gisenv MAPSET`"
	if test -d "$LOCATION/grid3/G3D_MASK" && test -f "$LOCATION/cell/MASK" ; then
		echo [2D and 3D raster MASKs present]
	elif test -f "$LOCATION/cell/MASK" ; then
		echo [Raster MASK present]
	elif test -d "$LOCATION/grid3/G3D_MASK" ; then
		echo [3D raster MASK present]
	fi
}
PROMPT_COMMAND=grass_prompt
#GRASS_PROJSHARE=/Library/Frameworks/PROJ.framework/Versions/4.5/Resources/proj
#export GRASS_PROJSHARE

GRASS_ADDON_PATH=$GRASS_ADDON_PATH:/Library/GRASS/7.0/Modules/bin 
export GRASS_ADDON_PATH

#GRASS_ADDON_ETC=/Users/cmbarton/grass_etc
#export GRASS_ADDON_ETC

GRASS_FONT=Helvetica
export GRASS_FONT


export GRASS_WX64BIT=0
export GRASS_GNUPLOT="gnuplot -persist"
export GRASS_PAGER=more
export GRASS_HTML_BROWSER_MACOSX="-b com.apple.helpviewer"
export GRASS_HTML_BROWSER=/Applications/GRASS/GRASS-7.1.app/Contents/MacOS/etc/html_browser_mac.sh
export GRASS_XTERM=/Applications/GRASS/GRASS-7.1.app/Contents/MacOS/etc/grass-xterm-mac
export GRASS_ADDON_ETC=/Users/cmbarton/Library/GRASS/7.1/Modules/etc:/Library/GRASS/7.1/Modules/etc
export GRASS_OS_STARTUP=Mac.app
export GRASS_WXBUNDLED=1
export GRASS_PYTHONWX=/usr/bin/pythonw2.7
export GRASS_PYTHON=python
export GRASS_VERSION=7.1.svn
export GRASS_ADDON_BASE=/Users/cmbarton/Library/GRASS/7.1/Modules
export GRASS_PROJSHARE=/Library/Frameworks/PROJ.framework/Resources/proj
export GRASS_FONT_CAP=/Users/cmbarton/Library/GRASS/7.1/Modules/etc/fontcap

export PATH="/Applications/GRASS/GRASS-7.1.app/Contents/MacOS/bin:/Applications/GRASS/GRASS-7.1.app/Contents/MacOS/scripts:/Users/cmbarton/Library/GRASS/7.1/Modules/bin:/Users/cmbarton/Library/GRASS/7.1/Modules/scripts:-framework GDAL/Library/Frameworks/PROJ.framework/Programs:/Applications/anaconda/bin:/Library/Frameworks/GDAL.framework/Programs:/opt/subversion/bin:/usr/local/bin:/usr/X11R6/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/opt/X11/bin:/usr/texbin"
export HOME="/Users/cmbarton"
