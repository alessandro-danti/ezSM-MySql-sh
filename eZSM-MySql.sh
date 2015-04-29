#!/bin/bash

# eZSM-MySql.sh
#
# Wrapper script to store the data from eZServerMonitor.sh

# Database settings

myDbName="ezSvrMon"
myDbUser="ezsmdb"
myDbPass="Welcome123"
myDbHost="localhost"

# IP to integer conversion function 
ip2dec () {
    local a b c d ip=$@
    IFS=. read -r a b c d <<< "$ip"
    printf '%d\n' "$((a * 256 ** 3 + b * 256 ** 2 + c * 256 + d))"
}

# Enable to avoid printing any error to STDOUT - for DEBUG
exec 2> /dev/null

myOutput=$(mktemp)

if [ -z "$1" ]
then
	echo "You have to choose which checks you want to run! Exiting..."
	exit 1
fi 

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
			myInterface=$(echo $myLine|awk -F" " '{ print $3 }'|sed -e 's/^[ \t]*//')
			myIPAddress=$(echo $myLine|awk -F"\t" '{ print $2 }'|sed -e 's/^[ \t]*//')
			myLANInterfaces[$myInterface]=$myIPAddress
			;;	
		*"IP WAN"*)
			myIPWAN=$(echo $myLine|awk -F"\t" '{ print $2 }'|sed -e 's/^[ \t]*//')
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
mySystemInsert="INSERT INTO System VALUES ('', '$myHostname', '$myOS', '$myKernel', '$myUptime', '$myLastBoot', '$myCurrentUser', FROM_UNIXTIME('$myTimestamp'));"

# echo "$mySystemInsert"

# Table LoadAverage
myLoadAvgInsert="INSERT INTO LoadAverage VALUES ((SELECT SystemID FROM System WHERE LastChanged = FROM_UNIXTIME($myTimestamp) AND Hostname = '$myHostname'), '$myLoadOne', '$myLoadFive', '$myLoadFifteen', '$myProcesses', FROM_UNIXTIME('$myTimestamp'));"

# echo "$myLoadAvgInsert"

# Table CPU
myCPUInsert="INSERT INTO CPU VALUES ((SELECT SystemID FROM System WHERE LastChanged = FROM_UNIXTIME($myTimestamp) AND Hostname = '$myHostname'), '$myCPUModel', '$myCPUFrequency', '$myCPUCache', '$myCPUBogomips', FROM_UNIXTIME('$myTimestamp'));"

# echo "$myCPUInsert"

# Table RAM
myRAMInsert="INSERT INTO RAM VALUES ((SELECT SystemID FROM System WHERE LastChanged = FROM_UNIXTIME($myTimestamp) AND Hostname = '$myHostname'), '$myRAMTotal', '$myRAMFree', FROM_UNIXTIME('$myTimestamp'));"

# echo "$myRAMInsert"

# Table NetworkInterfaces
for i in "${!myLANInterfaces[@]}"
do
	myConvertedLANIP=$(ip2dec "${myLANInterfaces[$i]}")
	myNetworkInsert="$myNetworkInsert\nINSERT INTO NetworkInterfaces VALUES ((SELECT SystemID FROM System WHERE LastChanged = FROM_UNIXTIME($myTimestamp) AND Hostname = '$myHostname'), '$i', '$myConvertedLANIP', FROM_UNIXTIME('$myTimestamp'), '');"
	# echo -e "$i -- $myNetworkInsert"
done

myConvertedWANIP=$(ip2dec "$myIPWAN")

myIPWANInsert="INSERT INTO NetworkInterfaces VALUES ((SELECT SystemID FROM System WHERE LastChanged = FROM_UNIXTIME($myTimestamp) AND Hostname = '$myHostname'), 'WAN', '$myConvertedWANIP', FROM_UNIXTIME('$myTimestamp'), '');"
# echo $myIPWANInsert

# Table Ping
for e in "${!myPingHosts[@]}"
do
	myPingInsert="$myPingInsert\nINSERT INTO Ping VALUES ((SELECT SystemID FROM System WHERE LastChanged = FROM_UNIXTIME($myTimestamp) AND Hostname = '$myHostname'), '$e', '${myPingHosts[$e]}', FROM_UNIXTIME('$myTimestamp'), '');"
        # echo "$myPingInsert"
done

# Table Diskspace
for o in "${!myDiskDevices[@]}"
do
	myDiskInsert="$myDiskInsert\nINSERT INTO Diskspace VALUES ((SELECT SystemID FROM System WHERE LastChanged = FROM_UNIXTIME($myTimestamp) AND Hostname = '$myHostname'), '$o', '${myDiskDevices[$o]}', FROM_UNIXTIME('$myTimestamp'), '');"
	# echo "$myDiskInsert"
done

# Table Services
for u in "${!myServices[@]}"
do
	if [[ ${myServices[$u]} == "OFFLINE" ]]
	then
		myServiceStatus=0
	else
		myServiceStatus=1
	fi
	myServicesInsert="$myServicesInsert\nINSERT INTO Services VALUES ((SELECT SystemID FROM System WHERE LastChanged = FROM_UNIXTIME($myTimestamp) AND Hostname = '$myHostname'), '$(echo $u|awk -F"(" '{ print $1}'| sed 's/^[ \t]*//;s/[ \t]*$//')', '$myHostname', '$(echo $u|awk -F"(" '{ print $2 }'|tr -d "()")', '$myServiceStatus', FROM_UNIXTIME('$myTimestamp'), '');"
	# echo "$myServicesInsert"
done

/usr/bin/mysql -u $myDbUser -p$myDbPass -D $myDbName -t<<EOF
$(echo $mySystemInsert)
$(echo $myLoadAvgInsert)
$(echo $myCPUInsert)
$(echo $myRAMInsert)
$(echo -e $myNetworkInsert)
$(echo $myIPWANInsert)
$(echo -e $myPingInsert)
$(echo -e $myDiskInsert)
$(echo -e $myServicesInsert)
EOF

rm $myOutput
