This is a fork of https://github.com/shevabam/ezservermonitor-sh, intended to add functionalities to save the script
data to a MySql database.
The core functionality stays the same as the original script, which will be kept up to date as the original author commits new releases.

Changelog 8.12.2014
 - Added database schema in MySql Workbench and generated schema file, plus a PNG picture as reference in the 
   development branch - USE AT YOUR OWN RISK 
 - Added .gitignore file to ignore some unneeded extensions (.bak, .swp and OSX/Windows generated files)

Changelog 1.12.2014
 - Created branch "development" where not production ready code can be found - USE AT YOUR OWN RISK.
   If you want to be sure that I have tested stuff throughly, please stick to the "master" branch.

Changelog 25.11.2014
 - First version of the Database Schema uploaded in draw.io XML format

Changelog 24.11.2014
 - The script configuration has been externalized. Now there is the option to either use the eZSM-config.sh or the 
   main script to set the various configuration options.

---

[eZ Server Monitor](http://www.ezservermonitor.com) (eSM) is a script for monitoring Linux servers. It is available in [Bash](http://www.ezservermonitor.com/esm-sh/features) version and [Web](http://www.ezservermonitor.com/esm-web/features) application.

# eZ Server Monitor `sh

In its [Bash](http://www.ezservermonitor.com/esm-sh/features) version eSM is a simple script that displays on a terminal information such as:

![](http://www.ezservermonitor.com/uploads/esm_sh/esm-sh_dashboard-complete.png)

- **System** : hostname, OS, kernel version, uptime, last boot date, number of current user(s), server datetime
- **Load average** : percentages showing the CPU load (1 minute, 5 minutes et 15 minutes)
- **CPU** : model, frequency, cores number, cache L2, bogomips
- **Memory** : displays free and total memory
- **Network usage** : displaying the IP address of each network interface (WAN and LAN)
- **Ping** : ping the hosts defined in the configuration section of the script
- **Disk usage** : table of each mount point with the space available, used and total
- **Services** : displays the status (up or down) services defined in the configuration section of the script
- **Disks and system temperatures** : displays the disks, CPU and motherboard temperatures (optional)


You can download the last version [here](http://www.ezservermonitor.com/esm-sh/downloads). The [documentation](http://www.ezservermonitor.com/esm-sh/documentation) describes the script as a whole and also the list of options available.

View more information on the [official website](http://www.ezservermonitor.com/esm-sh/features).
