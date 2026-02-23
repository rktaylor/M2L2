
Installation Instructions for MML-v1 (2015).


Instructions written for Mac OS X 

-----------------------------------------------------

1) Extract the model files to the directory of your choosing. Make a note of the path to where you do this. There should now be a folder there called "midland-modeling-laboratory". Open the folder, and you should now see other folders labeled "data/GIS-Database" and "code/APSIM", and a file called “code/MML/MMLv1.jar", and this DOCS/README.txt file. 

2) Check the contents of the extracted folders:

Inside the "GIS_Database" folder, there will be a text file called "MML1v_sample.config" and a hidden text file called ".grassrc6".
On a Mac, the same config file may be viewed by dragging the file to a text editing program.

Inside the APSIM folder there will be a LibreOffice Calc workbook (for computing reasonable input values for agent economies) and four subdirectories called "Images", "Rules", "Scripts", and "Temp". These directories contain various files that will be used by the model. 

3) It is important to ensure that all python scripts in the "Scripts" directory are set to be "executable.” From the GUI: 

Navigate to the scripts directory (<PATH_TO>/MMLv1/APSIM/Scripts)
For the Mac, Right click the scripts folder and choose get Info. Click the lock icon on the bottom right of the Info page and enter your password. Make Sure that your username has read and write access. While selecting your username, click on the gray flower / gear and choose apply to enclosed files and directories.

Alternatively, you can do this from the terminal (Linux or Mac):
cd /home/<username>/APSIM/Scripts 	#navigate to the scripts directory
sudo chmod 777 *.py			#set permissions for all script files.
 

4) Install latest GRASS-6.4, Java Runtime Environment, Python, WX Python, and their dependencies:

Mac: Download the latest DMG files for each of these, and install as per directions.
The latest GRASS 6.4 and its dependencies can be found at http://grassmac.wikidot.com/downloads

5) It is necessary to disable any power-saving settings enabled by default in your OS. 

Mac: System Preferences / Energy Saver

(NOTE: You probably ought to turn off any screen savers as well. You can, however, enable the display to turn off after a period of time. It's also best to turn off security features such as requiring a password when you wake up the display.)

6) To start the MML, open a terminal and navigate to the directory with the MMLv1.jar file (or just drag the file to the Terminal window, and type:

java -jar MMLv1.jar (Note: The flag -Xmx2048m may be necessary after the preceding command. See the note at the bottom of the file.)

7) When the GUI opens, some of the fields will be filled with dummy data, but several important fields will be empty. We will load in a configuration file to fill these out automatically for the sample data.

The data can be added via the GUI or using a text editor.

In the GUI, you will need to update the paths in the System Settings tab. APSIM location will be the location of that folder on your computer. Python, on a mac is located in /usr/bin usually. The grass .rc6 file is usually located in a users home directory. However, if you are running multiple instances of the model, you must use multiple copies of this file. Usually it is best to keep a copy associated with each grass database file. 

Please Note that the original source code is located in the APSIM Java Source Files Directory.


To edit the configuration file manually:

Open <PATH_TO>/GIS_Database/MMLv1_sample_data.config in your favorite text editor. You will see many numbers separated by the "|" symbol. Don't touch any of these. Look for three instances of the exact phrase "<PATH_TO>" (without quotes). Replace "<PATH_TO>" with the real path to where you downloaded and unzipped the MMLv1 directory. What you are doing is specifying the path to the GIS_Database and APSIM folders, which are directly in your home directory. Save your changes and close your text editor.

(NOTE: It may be easiest to use the "Find and Replace" tool of your text editor to do this operation. Also Note: I've included a blank "GIS_Database" directory in the MMLv1 directory tree. I suggest that you copy your GRASS location into this directory, and use it for model runs. It's best to keep model runs distinct from your normal GIS data directory, as the model makes MANY files, and potentially MANY mapsets.)

10) Once you've saved the changes to the "MMLv1_sample.config" file, go back to the MMLv1 GUI, and  select "Load Configuration File". Navigate to the "MMLv1_sample.config" file (in <PATH_TO>/MMLv1/GIS-Database/), and double click it to load it into the GUI. If all is well, you will see the fields populate with data. You may now edit any of the other values as you wish (although all default values are correct for the included sample data). You can select "Validate" to ensure that all settings are correct. Once you are sure all values are correct, you can execute a simulation by selecting "Initialize".

NOTE: If you hit "Validate", and NO MESSAGE of any type pops up, then you have not correctly specified one of the paths in the "System Settings" tab or in the "Environment Model -> Map Selection" tab. This is a known bug, but for the time being you just need to ensure these paths are correct. If they are, pressing "Validate" will bring up a window that says "Current configuration appears valid", or an actual error message will appear telling you what else is wrong.

11) Accessing model output. All GIS data files will be written to a new mapset in the specified GIS location. The directory structure is: GIS-Database/<Location>/<Mapset>. If you use the default values in the config file, the GIS data from your first model run will be physically in "<PATH_TO>/MMLv1/GIS-Database/YourMapset/YourExperiment-Run1." Stats files created during the model run will be in "<PATH_TO>/MMlv1/GIS-Database/YourMapset/YourExperiment-Run1/stats". These are all formatted as comma-separated values, and can be opened in any spreadsheet or text editor.

A sample location has been included in the GIS_Database folder with the model files for the Penaguila Valley in eastern Spain. It includes samples of the various types of maps that must be made before the model is run. 



Instructions written for Ubuntu Linux (version 12.04), but should work for any current (2015) installation of a Debian Linux-based OS.

-----------------------------------------------------

1) Extract the model files to the directory of your choosing (right (option) click, "extract here"). Make a note of the path to where you do this. There should now be a folder there called "MMLv1". Open the folder, and you should now see other folders labeled "data/GIS-Database" and "code/APSIM", and a file called “code/MML/MMLv1.jar", and this DOCS/README.txt file. 

2) Check the contents of the extracted folders:

Inside the "GIS-Database" folder, there will be a text file called "MML1v_sample.config" and a hidden text file called ".grassrc6".

Inside the APSIM folder there will be a LibreOffice Calc workbook (for computing reasonable input values for agent economies) and four subdirectories called "Images", "Rules", "Scripts", and "Temp". These directories contain various files that will be used by the model. 

3) It is important to ensure that all python scripts in the "Scripts" directory are set to be "executable". From the GUI: 

Navigate to the scripts directory (<PATH_TO>/MMLv1//APSIM/Scripts)
One by one, right click on each file and select "properties".
Choose the "permissions" tab, and check the box that says "allow executing file as program" checkbox (linux only).

Alternatively, you can do this from the terminal (Linux or Mac):
cd /home/<username>/APSIM/Scripts 	#navigate to the scripts directory
sudo chmod 777 *.py			#set permissions for all script files.

4) (Linux only) Add the "ubuntugis-unstable" PPA repository to your APT-sources list. Open a terminal and type: 

sudo add-apt-repository ppa:ubuntugis/ubuntugis-unstable

(NOTE: This is the repository from which we will get the latest GRASS-6.4)

5) (Linux only)Update the package list, and install any system updates:

sudo apt-get update
sudo apt-get dist-upgrade

(NOTE: It's always important to have your system completely up to date, but on a newly installed machine, this command will download and install many updates. This is important, so be patient.)

6) Install latest GRASS-6.4, Java Runtime Environment, Python, WX Python, and their dependencies:

Linux: sudo apt-get install grass grass-dev openjdk-7-jre python2.7 wxpython
Mac: Download the latest DMG files for each of these, and install as per directions.

(NOTE: It is important that you intall grass, JRE, and Python this way, so that they are installed in the default locations (usr/lib or usr/bin). If you installed from source, or chose a custom location for these programs, you will have to use a text editor to directly update the paths in "MML1v_sample_data.config" file to reflect these non-standard locations, or the config file will not load into the MMLv1 GUI)

7) It is neccessary to disable any power-saving settings enabled by default in your OS. From the launcher:

Linux: System Settings->Power: set "Suspend when inactive for" to "Don't suspend".


(NOTE: You probably ought to turn off any screen savers as well. You can, however, enable the display to turn off after a period of time. It's also best to turn off security features such as requiring a password when you wake up the display.)

8) To start the MML, open a terminal in the directory with the MMLv1.jar file, and type:

java -jar MMLv1.jar

9) When the GUI opens, some of the fields will be filled with dummy data, but several important fields will be empty. We will load in a configuration file to fill these out automatically for the sample data 

The data can be added via the GUI or using a text editor.

In the GUI, you will need to update the paths in the System Settings tab. APSIM location will be the location of that folder on your computer. Python, on a mac is located in /usr/bin usually. The grass .rc6 file is usually located in a users home directory. However, if you are running multiple instances of the model, you must use multiple copies of this file. Usually it is best to keep a copy associated with each grass database file. 


To edit the model configuration file manually:


Open <PATH_TO>/GIS_Database/MMLv1_sample_data.config in your favorite text editor. You will see many numbers separated by the "|" symbol. Don't touch any of these. Look for three instances of the exact phrase "<PATH_TO>" (without quotes). Replace "<PATH_TO>" with the real path to where you downloaded and unzipped the MMLv1 directory. What you are doing is specifying the path to the GIS_Database and APSIM folders, which are directly in your home directory. Save your changes and close your text editor.

(NOTE: It may be easiest to use the "Find and Replace" tool of your text editor to do this operation. Also Note: I've included a blank "GIS_Database" directory in the MMLv1 directory tree. I suggest that you copy your GRASS location into this directory, and use it for model runs. It's best to keep model runs distinct from your normal GIS data directory, as the model makes MANY files, and potentially MANY mapsets.)

10) Once you've saved the changes to the "MMLv1_sample.config" file, go back to the MMLv1 GUI, and  select "Load Configuration File". Navigate to the "MMLv1_sample.config" file (in <PATH_TO>/MMLv1/GIS-Database/), and double click it to load it into the GUI. If all is well, you will see the fields populate with data. You may now edit any of the other values as you wish (although all default values are correct for the included sample data). You can select "Validate" to ensure that all settings are correct. Once you are sure all values are correct, you can execute a simulation by selecting "Initialize".

NOTE: If you hit "Validate", and NO MESSAGE of any type pops up, then you have not correctly specified one of the paths in the "System Settings" tab or in the "Environment Model -> Map Selection" tab. This is a known bug, but for the time being you just need to ensure these paths are correct. If they are, pressing "Validate" will bring up a window that says "Current configuration appears valid", or an actual error message will appear telling you what else is wrong.

11) Accessing model output. All GIS data files will be written to a new mapset in the specified GIS location. The directory structure is: GIS-Database/<Location>/<Mapset>. If you use the default values in the config file, the GIS data from your first model run will be physically in "<PATH_TO>/MMLv1/GIS-Database/PPNB/Agropast-Run1", and can be accessed in GRASS by selecting the location "PPNB" and mapset "Agropast-Run1" when starting GRASS. Stats files created during the model run will be in "<PATH_TO>/MMlv1/GIS-Database/PPNB/Agropast-Run1/stats". These are all formatted as comma-separated values, and can be opened in any spreadsheet or text editor.

A sample location has been included in the GIS_Database folder with the model files for the Penaguila Valley in eastern Spain. It includes samples of the various types of maps that must be made before the model is run. 


-----------------------------------------------------------

Running the Model : The MML. jar file can be opened with a simple double click. This will be the last simple part of the process :) A sample configuration file is included and can be loaded. Each tab contains default values originally used for the Mediterranean that may be different for your area. Users must specify the directory to their gis database location and select the maps they wish to use in their simulation. Also, users must specify the paths to GRASS, python, the APSIM folder included with the model, and their .grassrc6 file.  

Once values have been entered in all of the boxes in the model startup interface, click validate or initialize. Validate will just check all of the information you have entered, and initialize will check all of the values you entered and then run the model if there are no errors.


-----------------------------------------------------------

NOTES for running multiple instances on multi-core machines:

It is possible to concurrently run as many instances of the model as you have processors (e.g., you can simultaneously run 4 simulations on a 4-core machine). You must, however, have a unique GIS-Database for each instance of the model. I suggest making copies of the default GIS-database, and naming the new directories "GIS-Database1", GIS-Database2", etc. You will need to open a text editor and directly edit the "MML1v_sample_data.config" files in each new directory to reflect the new "GIS-database" path and ".grassrc6" path for each new copy, or you can open change the information in the GUI and save out different config files that reference each gis database. Once each new config file has been edited, you can run multiple instances of the model by opening a terminal (a new terminal for each instance you want to run), and following the instructions in step 7, above. NOTE: it may be important that you manage your RAM for each run. You can set the maximum RAM dedicated to java "heap-space" for each simulation by adding "-Xmx####" to the java run command, where "####" is the maximum amount of RAM to be allocated to the process. For example, to launch a simulation with a cap of 2 Gigabytes of RAM, type the following: "java -jar -Xmx2g MMLv1.jar". If you want to specify in Megabytes, replace the "g" with "m" (e.g. -Xmx2g and -Xmx2056m are the same). It is important to remember that each instance of APSIM will probably need at least 2GB of RAM dedicated to heap space, or it will likely have an OutOfMemoryError. It's best to free up as much system RAM as possible, so be sure to close all other non-esential applications (like Dropbox, or any screen saver), and you can even disable your network connection.
			