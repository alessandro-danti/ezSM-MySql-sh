#!/bin/bash

# eZSM-MySql.sh
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
			myHostname=$(echo $myLine|awk -F"\t" '{ print $2 }')
		;;
		*"OS"*)
			myOS=$(echo $myLine|awk -F"\t" '{ print $3 }')
		;;
		*"Kernel"*)
			myKernel=$(echo $myLine|awk -F"\t" '{ print $2 }')
		;;
		*"Uptime"*)
			myUptime=$(echo $myLine|awk -F"\t" '{ print $2 }')
		;;
		*"Last boot"*)
			myLastBoot=$(echo $myLine|awk -F"\t" '{ print $2 }')
		;;
		*"Current user"*)
			myCurrentUser=$(echo $myLine|awk -F" " '{ print $3 " " $4 }')
		;;
		*"Server datetime"*)
			myDatetime=$(echo $myLine|awk -F" " '{ print $3 " " $4 }')
		;;
		*"Since 1 minute"*)
			myLoadOne=$(echo $myLine|awk -F" " '{ print $4 " " $5 }')
		;;
		*"Since 5 minute"*)
			myLoadFive=$(echo $myLine|awk -F" " '{ print $4 " " $5 }')
		;;
		*"Since 15 minute"*)
			myLoadFifteen=$(echo $myLine|awk -F" " '{ print $4 " " $5 }')
		;;
		*"Processus"*)
			myProcesses=$(echo $myLine|awk -F"\t" '{ print $2 }')
		;;
		*"Model"*)
			myCPUModel=$(echo $myLine|awk -F"\t" '{ print $3 }')
		;;
		*"Frequency"*)
			myCPUFrequency=$(echo $myLine|awk -F"\t" '{ print $2 }')
		;;
		*"Cache L2"*)
			myCPUCache=$(echo $myLine|awk -F"\t" '{ print $2 }')
		;;
		*"Bogomips"*)
			myCPUBogomips=$(echo $myLine|awk -F"\t" '{ print $2 }')
		;;
		*"RAM"*)
			myRAMFree=$(echo $myLine|awk -F"\t" '{ print $2 }'|awk -F" " '{ print $1 }')
			myRAMTotal=$(echo $myLine|awk -F"\t" '{ print $2 }'|awk -F " " '{ print $5 }')
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
			myPingAddress=$(echo $myLine|awk -F"\t" '{ print $1 }')
			myPingHosts[$myPingAddress]=$(echo $myLine|awk -F"\t" '{ print $2 }')
			;;
		*"/dev/"*)
			declare -A myDiskDevices
			myDiskName=$(echo $myLine|awk -F" " '{ print $1 }')
			myDiskDevices[$myDiskName]=$(echo $myLine|awk -F" " '{ print $2 " " $3 " " $4 " " $5}')
			;;
		*"ONLINE"*|*"OFFLINE"*)
			declare -A myServices
			myServiceName=$(echo $myLine|awk -F":" '{ print $1 }')
			myServices[$myServiceName]=$(echo $myLine|awk -F":" '{ print $2 }')
			;;
	esac
done
IFS=$OFS

echo $myHostname
echo $myOS
echo $myKernel
echo $myUptime
echo $myLastBoot
echo $myCurrentUser
echo $myDatetime
echo $myLoadOne
echo $myLoadFive
echo $myLoadFifteen
echo $myProcesses
echo $myCPUModel
echo $myCPUFrequency
echo $myCPUCache
echo $myCPUBogomips
echo $myRAMTotal
echo $myRAMFree
for i in "${!myLANInterfaces[@]}"
do
	echo $i
	echo ${myLANInterfaces[$i]}
done
echo $myIPWAN
for e in "${!myPingHosts[@]}"
do
	echo $e
	echo ${myPingHosts[$e]}
done
for o in "${!myDiskDevices[@]}"
do
	echo $o
	echo ${myDiskDevices[$o]}
done
for u in "${!myServices[@]}"
do
	echo $u
	echo ${myServices[$u]}
done

