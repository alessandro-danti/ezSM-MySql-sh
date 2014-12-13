#!/bin/bash

# eZSM-MySql.sh
#
# Wrapper script to store the data from eZServerMonitor.sh
exec 2> /dev/null

myOutput=$(mktemp)

$(dirname $0)/eZServerMonitor.sh $1|sed 's/\x1b\[[0-9;]*m//g' > $myOutput

OFS=$IFS
IFS="
"
for myLine in $(cat $myOutput)
do 
	# echo "--- $myLine"
	case $myLine in
		*"Hostname"*)
			myHostname=$(echo $myLine|awk -F"\t" '{ print $2 }'|sed -e 's/^[ \t]*//')
		;;
		*"OS"*)
			myOS=$(echo $myLine|awk -F"\t" '{ print $3 }'|sed -e 's/^[ \t]*//')
		;;
		*"Kernel"*)
			myKernel=$(echo $myLine|awk -F"\t" '{ print $2 }'|sed -e 's/^[ \t]*//')
		;;
		*"Uptime"*)
			myUptime=$(echo $myLine|awk -F"\t" '{ print $2 }'|sed -e 's/^[ \t]*//')
		;;
		*"Last boot"*)
			myLastBoot=$(echo $myLine|awk -F"\t" '{ print $2 }'|sed -e 's/^[ \t]*//')
		;;
		*"Current user"*)
			myCurrentUser=$(echo $myLine|awk -F" " '{ print $3 " " $4 }'|sed -e 's/^[ \t]*//')
		;;
		*"Server datetime"*)
			myDatetime=$(echo $myLine|awk -F" " '{ print $3 " " $4 }'|sed -e 's/^[ \t]*//')
		;;
		*"Since 1 minute"*)
			myLoadOne=$(echo $myLine|awk -F" " '{ print $4 " " $5 }'|sed -e 's/^[ \t]*//')
		;;
		*"Since 5 minute"*)
			myLoadFive=$(echo $myLine|awk -F" " '{ print $4 " " $5 }'|sed -e 's/^[ \t]*//')
		;;
		*"Since 15 minute"*)
			myLoadFifteen=$(echo $myLine|awk -F" " '{ print $4 " " $5 }'|sed -e 's/^[ \t]*//')
		;;
		*"Processus"*)
			myProcesses=$(echo $myLine|awk -F"\t" '{ print $2 }'|sed -e 's/^[ \t]*//')
		;;
		*"Model"*)
			myCPUModel=$(echo $myLine|awk -F"\t" '{ print $3 }'|sed -e 's/^[ \t]*//')
		;;
		*"Frequency"*)
			myCPUFrequency=$(echo $myLine|awk -F"\t" '{ print $2 }'|sed -e 's/^[ \t]*//')
		;;
		*"Cache L2"*)
			myCPUCache=$(echo $myLine|awk -F"\t" '{ print $2 }'|sed -e 's/^[ \t]*//')
		;;
		*"Bogomips"*)
			myCPUBogomips=$(echo $myLine|awk -F"\t" '{ print $2 }'|sed -e 's/^[ \t]*//')
		;;
		*"RAM"*)
			myRAMFree=$(echo $myLine|awk -F"\t" '{ print $2 }'|awk -F" " '{ print $1 }'|sed -e 's/^[ \t]*//')
			myRAMTotal=$(echo $myLine|awk -F"\t" '{ print $2 }'|awk -F " " '{ print $5 }'|sed -e 's/^[ \t]*//')
		;;
		*"IP LAN"*)
			declare -A myLANInterfaces
			myInterface=$(echo $myLine|awk -F" " '{ print $3 }')
			myIPAddress=$(echo $myLine|awk -F"\t" '{ print $2 }')
			myLANInterfaces[$myInterface]=$myIPAddress
			;;	
		*"IP WAN"*)
			myIPWAN=$(echo $myLine|awk -F"\t" '{ print $2 }')
			;;
		*"ms"*)
			declare -A myPingHosts
			myPingAddress=$(echo $myLine|awk -F"\t" '{ print $1 }'|sed -e 's/^[ \t]*//')
			myPingHosts[$myPingAddress]=$(echo $myLine|awk -F"\t" '{ print $2 }'|sed -e 's/^[ \t]*//')
			;;
		*"/dev/"*)
			declare -A myDiskDevices
			myDiskName=$(echo $myLine|awk -F" " '{ print $1 }')
			myDiskDevices[$myDiskName]=$(echo $myLine|awk -F" " '{ print $2 " " $3 " " $4 " " $5}')
			;;
		*"ONLINE"*|*"OFFLINE"*)
			declare -A myServices
			myServiceName=$(echo $myLine|awk -F":" '{ print $1 }'|sed -e 's/^[ \t]*//')
			myServices[$myServiceName]=$(echo $myLine|awk -F":" '{ print $2 }'|sed -e 's/^[ \t]*//')
			;;
	esac
done
IFS=$OFS

# Mark timestamp to be saved in the database
myTimestamp=$(date +%s)

# Table System
echo $myHostname
echo $myOS
echo $myKernel
echo $myUptime
echo $myLastBoot
echo $myCurrentUser
echo $myDatetime

mySystemInsert="INSERT INTO System VALUES ('', '$myHostname', '$myOS', '$myKernel', '$myUptime', '$myLastBoot', '$myCurrentUser', FROM_UNIXTIME('$myTimestamp'));"

echo "$mySystemInsert"

# Table LoadAverage
echo $myLoadOne
echo $myLoadFive
echo $myLoadFifteen
echo $myProcesses

myLoadAvgInsert="INSERT INTO LoadAverage VALUES ((SELECT SystemID FROM System WHERE LastChanged = FROM_UNIXTIME($myTimestamp) AND Hostname = '$myHostname'), '$myLoadOne', '$myLoadFive', '$myLoadFifteen', '$myProcesses', FROM_UNIXTIME('$myTimestamp'));"

echo "$myLoadAvgInsert"

# Table CPU
echo $myCPUModel
echo $myCPUFrequency
echo $myCPUCache
echo $myCPUBogomips

myCPUInsert="INSERT INTO CPU VALUES ((SELECT SystemID FROM System WHERE LastChanged = FROM_UNIXTIME($myTimestamp) AND Hostname = '$myHostname'), '$myCPUModel', '$myCPUFrequency', '$myCPUCache', '$myCPUBogomips', FROM_UNIXTIME('$myTimestamp'));"

echo "$myCPUInsert"

# Table RAM
echo $myRAMTotal
echo $myRAMFree

myRAMInsert="INSERT INTO RAM VALUES ((SELECT SystemID FROM System WHERE LastChanged = FROM_UNIXTIME($myTimestamp) AND Hostname = '$myHostname'), '$myRAMTotal', '$myRAMFree', FROM_UNIXTIME('$myTimestamp'));"

echo "$myRAMInsert"

# Table NetworkInterfaces
for i in "${!myLANInterfaces[@]}"
do
	echo $i
	echo ${myLANInterfaces[$i]}
	myNetworkInsert="INSERT INTO NetworkInterfaces VALUES ((SELECT SystemID FROM System WHERE LastChanged = FROM_UNIXTIME($myTimestamp) AND Hostname = '$myHostname'), '$i', '${myLANInterfaces[$i]}', FROM_UNIXTIME('$myTimestamp'), '');"
	echo "$myNetworkInsert"
done

echo $myIPWAN

myIPWANInsert="INSERT INTO NetworkInterfaces VALUES ((SELECT SystemID FROM System WHERE LastChanged = FROM_UNIXTIME($myTimestamp) AND Hostname = '$myHostname'), 'WAN', '$myIPWAN', '$myTimeStamp')"

# Table Ping
for e in "${!myPingHosts[@]}"
do
	echo $e
	echo ${myPingHosts[$e]}
	myPingInsert="INSERT INTO Ping VALUES ((SELECT SystemID FROM System WHERE LastChanged = FROM_UNIXTIME($myTimestamp) AND Hostname = '$myHostname'), '$e', '${myPingHosts[$e]}', FROM_UNIXTIME('$myTimestamp'), '');"
        echo "$myPingInsert"
done

# Table Diskspace
for o in "${!myDiskDevices[@]}"
do
	echo $o
	echo ${myDiskDevices[$o]}
	myDiskInsert="INSERT INTO Diskspace VALUES ((SELECT SystemID FROM System WHERE LastChanged = FROM_UNIXTIME($myTimestamp) AND Hostname = '$myHostname'), '$o', '${myDiskDevices[$o]}', FROM_UNIXTIME('$myTimestamp'), '');"
	echo "$myDiskInsert"
done

# Table Services
for u in "${!myServices[@]}"
do
	echo $u
	echo ${myServices[$u]}
	if [[ ${myServices[$u]} == "OFFLINE" ]]
	then
		myServiceStatus=0
	else
		myServiceStatus=1
	fi
	myServicesInsert="INSERT INTO Services VALUES ((SELECT SystemID FROM System WHERE LastChanged = FROM_UNIXTIME($myTimestamp) AND Hostname = '$myHostname'), '$(echo $u|awk -F"(" '{ print $1}'| sed 's/^[ \t]*//;s/[ \t]*$//')', '$myHostname', '$(echo $u|awk -F"(" '{ print $2 }'|tr -d "()")', '$myServiceStatus', FROM_UNIXTIME('$myTimestamp'), '');"
	echo "$myServicesInsert"
done

rm $myOutput
