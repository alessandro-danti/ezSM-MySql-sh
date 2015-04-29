#!/bin/bash

# CLEAN_DB.sh

# State check
# set myState to DEV if you want to run the script
myState="DEV"

if [[ $myState != "DEV" ]]
then
	echo "State not set to DEV. Script not running..."
	exit
fi 

# Database settings

myDbName="ezSvrMon"
myDbUser="ezsmdb"
myDbPass="Welcome123"
myDbHost="localhost"

/usr/bin/mysql -u $myDbUser -p$myDbPass -D $myDbName -t<<EOF
delete from CPU;
delete from DiskTemperature;
delete from Diskspace;
delete from LoadAverage;
delete from NetworkInterfaces;
delete from Ping;
delete from RAM;
delete from Services;
delete from SystemTemperature;
delete from System;
EOF

